import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import '../generated/protocol.dart';

class PublicApiEndpoint extends Endpoint {
  // This endpoint does not require login for its methods.

  // ── Internal helpers ────────────────────────────────────────────────────────

  /// Throws if [apiKey] does not match the service API key in passwords.yaml.
  void _validateApiKey(Session session, String apiKey) {
    final expected = session.passwords['serviceApiKey'];
    if (expected == null || apiKey != expected) {
      throw Exception('Invalid API key.');
    }
  }

  /// Builds a date string in YYYY-MM-DD format from [dt].
  String _dateString(DateTime dt) {
    final d = dt.toUtc();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  // ── Auth ────────────────────────────────────────────────────────────────────

  Future<LoginResponse> login(
      Session session, String email, String password) async {
    var authResult = await auth.Emails.authenticate(session, email, password);

    if (!authResult.success || authResult.userInfo == null) {
      return LoginResponse(success: false);
    }

    // Resolve AppUser → OrganizationUserLink → Organization
    final appUser = await AppUser.db.findFirstRow(
      session,
      where: (u) => u.userInfoId.equals(authResult.userInfo!.id),
    );

    Organization? organization;
    if (appUser != null) {
      final link = await OrganizationUserLink.db.findFirstRow(
        session,
        where: (l) => l.appUserId.equals(appUser.id),
      );
      if (link != null) {
        organization = await Organization.db.findById(
          session,
          link.organizationId,
        );
      }
    }

    return LoginResponse(
      success:      true,
      userInfo:     authResult.userInfo,
      organization: organization,
      keyId:        authResult.keyId,
      key:          authResult.key,
    );
  }

  // ── Theory Section (GET) ────────────────────────────────────────────────────

  /// Returns the full theory section for [organizationId]: module title + all
  /// chapters with their video metadata and quiz questions, ordered by chapter.
  ///
  /// JSON shape:
  /// ```json
  /// {
  ///   "moduleTitle": "Fire Safety Training",
  ///   "chapters": [ { "chapterId": 1, "title": "Fire", ... } ]
  /// }
  /// ```
  Future<TheorySectionResponse> getTheorySection(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    final org = await Organization.db.findById(session, organizationId);
    if (org == null) throw Exception('Organization not found.');

    final chapters = await TheoryChapter.db.find(
      session,
      where:   (c) => c.organizationId.equals(organizationId),
      orderBy: (c) => c.chapterOrder,
    );

    return TheorySectionResponse(
      moduleTitle: org.name,
      chapters:    chapters,
    );
  }

  // ── Smart Training (GET) ────────────────────────────────────────────────────

  /// Returns all training parameters for [organizationId], including per-level
  /// feedback and scoring logic.
  ///
  /// JSON shape:
  /// ```json
  /// [
  ///   {
  ///     "paramId": "duration",
  ///     "name": "Duration",
  ///     "maxScore": 5,
  ///     "feedbackLow": { "scoreRange": "0/5", ... },
  ///     ...
  ///   }
  /// ]
  /// ```
  Future<List<TrainingParameter>> getTrainingParameters(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    return await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
  }

  // ── Assessment (GET) ────────────────────────────────────────────────────────

  /// Returns all assessment parameters for [organizationId].
  ///
  /// JSON shape mirrors training parameters but without the hint field.
  Future<List<AssessmentParameter>> getAssessmentParameters(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    return await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
  }

  // ── Module Configuration (GET) ──────────────────────────────────────────────

  /// Returns the public module configuration for [organizationId], with
  /// subscription modules resolved to the effective per-user state.
  ///
  /// [userId] is the AppUser.id as a string (same convention as
  /// [submitTrainingCertificate]). When provided and matched, each module's
  /// enabled flag reflects the user's individual override from
  /// [UserModuleProgress]; otherwise the org-level default is used.
  ///
  /// JSON shape:
  /// ```json
  /// {
  ///   "configId": "ORG1_v1.0.0",
  ///   "lastUpdated": "2026-03-19",
  ///   "subscriptionModules": { "theoryModule": true, ... },
  ///   "languages": { "defaultLanguage": "en", "supported": [...] },
  ///   "passingPercentage": 60,
  ///   "aiChatPrompt": "You are a fire safety expert..."
  /// }
  /// ```
  Future<ModuleConfigPublic> getModuleConfig(
    Session session,
    int organizationId,
    String apiKey,
    String userId,
  ) async {
    _validateApiKey(session, apiKey);

    final config = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(organizationId),
    );
    if (config == null) {
      throw Exception('Module configuration not found for this organization.');
    }

    // Resolve the AppUser from the string userId (AppUser.id convention).
    final parsedId = int.tryParse(userId);
    final appUser =
        parsedId != null ? await AppUser.db.findById(session, parsedId) : null;

    // Load all per-user module overrides for this org in one query.
    final userProgress = appUser != null
        ? await UserModuleProgress.db.find(
            session,
            where: (p) =>
                p.appUserId.equals(appUser.id) &
                p.organizationId.equals(organizationId),
          )
        : <UserModuleProgress>[];

    // Returns the user-specific isEnabled value if a progress record exists,
    // otherwise falls back to the org-level default.
    bool effective(String moduleId, bool orgDefault) {
      try {
        return userProgress.firstWhere((p) => p.moduleId == moduleId).isEnabled;
      } catch (_) {
        return orgDefault;
      }
    }

    return ModuleConfigPublic(
      configId:     'ORG${organizationId}_v1.0.0',
      lastUpdated:  _dateString(DateTime.now()),
      subscriptionModules: SubscriptionModules(
        theoryModule:        effective('theory',        config.theoryModule),
        aiExpertModule:      effective('aiExpert',      config.aiExpertModule),
        smartTrainingModule: effective('smartTraining', config.smartTrainingModule),
        assessmentModule:    effective('assessment',    config.assessmentModule),
      ),
      languages: LanguagesConfig(
        defaultLanguage: config.defaultLanguage,
        supported:       config.supportedLanguages,
      ),
      passingPercentage: config.passingPercentage,
      aiChatPrompt:      config.aiChatPrompt,
    );
  }

  // ── Language (GET) ──────────────────────────────────────────────────────────

  /// Returns the language configuration for [organizationId]: default language
  /// code and the list of supported languages with optional content URLs.
  ///
  /// JSON shape:
  /// ```json
  /// {
  ///   "defaultLanguage": "en",
  ///   "supported": [
  ///     { "code": "en", "name": "English", "contentUrl": "..." },
  ///     ...
  ///   ]
  /// }
  /// ```
  Future<LanguagesConfig> getLanguages(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    final config = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(organizationId),
    );
    if (config == null) {
      throw Exception('Module configuration not found for this organization.');
    }

    return LanguagesConfig(
      defaultLanguage: config.defaultLanguage,
      supported:       config.supportedLanguages,
    );
  }

  // ── Assets (GET) ────────────────────────────────────────────────────────────

  /// Returns all assets for [organizationId]. Assets can be filtered on the
  /// client side by the [Asset.module] field (e.g. "theory", "smartTraining").
  ///
  /// JSON shape:
  /// ```json
  /// [
  ///   {
  ///     "name": "Fire Extinguisher Model",
  ///     "version": "1.0",
  ///     "url": "https://...",
  ///     "module": "smartTraining"
  ///   }
  /// ]
  /// ```
  Future<List<Asset>> getAssets(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    return await Asset.db.find(
      session,
      where: (a) => a.organizationId.equals(organizationId),
    );
  }

  // ── Certificate / Training Result (POST) ────────────────────────────────────

  /// Records a completed Smart Training session submitted by the external
  /// training application. Stores the result and returns a confirmation.
  ///
  /// Request body:
  /// ```json
  /// {
  ///   "organizationId": 1,
  ///   "apiKey": "...",
  ///   "userId": "S1244",
  ///   "overallPercentage": 85,
  ///   "criteriaValidation": [
  ///     { "parameter": "Duration", "score": 4 },
  ///     ...
  ///   ]
  /// }
  /// ```
  ///
  /// Response:
  /// ```json
  /// { "success": true, "resultId": 42, "message": "Training result recorded." }
  /// ```
  Future<CertificateResponse> submitTrainingCertificate(
    Session session,
    int organizationId,
    String apiKey,
    String userId,
    int overallPercentage,
    List<TrainingCriteriaScore> criteriaValidation,
  ) async {
    _validateApiKey(session, apiKey);

    final org = await Organization.db.findById(session, organizationId);
    if (org == null) throw Exception('Organization not found.');

    // The external training app sends the AppUser.id as a string userId.
    // Resolve it to set appUserId so history queries can find these records.
    final parsedId = int.tryParse(userId);
    final matchedUser =
        parsedId != null ? await AppUser.db.findById(session, parsedId) : null;

    final result = TrainingSessionResult(
      appUserId:         matchedUser?.id,
      organizationId:    organizationId,
      externalUserId:    userId,
      overallPercentage: overallPercentage,
      criteriaScores:    criteriaValidation,
      completedAt:       DateTime.now().toUtc(),
    );

    final stored = await TrainingSessionResult.db.insertRow(session, result);

    return CertificateResponse(
      success:  true,
      resultId: stored.id,
      message:  'Training result recorded successfully.',
    );
  }
}
