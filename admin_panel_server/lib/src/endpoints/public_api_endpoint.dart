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

  /// Recursively removes [__className__] keys from a serialized JSON map.
  Map<String, dynamic> _clean(Map<String, dynamic> json) {
    final result = <String, dynamic>{};
    for (final entry in json.entries) {
      if (entry.key == '__className__') continue;
      result[entry.key] = _cleanValue(entry.value);
    }
    return result;
  }

  dynamic _cleanValue(dynamic value) {
    if (value is Map<String, dynamic>) return _clean(value);
    if (value is List) return value.map(_cleanValue).toList();
    return value;
  }

  /// Builds the public module config for [organizationId], resolving per-user
  /// module overrides from [appUser]'s progress records when provided.
  /// Returns null if no [ModuleConfig] row exists for the organization.
  Future<ModuleConfigPublic?> _buildModuleConfigPublic(
    Session session,
    int organizationId,
    AppUser? appUser,
  ) async {
    final config = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(organizationId),
    );
    if (config == null) return null;

    final org = await Organization.db.findById(session, organizationId);

    final userProgress = appUser != null
        ? await UserModuleProgress.db.find(
            session,
            where: (p) =>
                p.appUserId.equals(appUser.id) &
                p.organizationId.equals(organizationId),
          )
        : <UserModuleProgress>[];

    bool effective(String moduleId, bool orgDefault) {
      try {
        return userProgress.firstWhere((p) => p.moduleId == moduleId).isEnabled;
      } catch (_) {
        return orgDefault;
      }
    }

    return ModuleConfigPublic(
      configId:       'ORG${organizationId}_v1.0.0',
      lastUpdated:    _dateString(DateTime.now()),
      contentVersion: org?.contentVersion ?? 1,
      subscriptionModules: SubscriptionModules(
        theoryModule:        effective('theory',        config.theoryModule),
        aiExpertModule:      effective('aiExpert',      config.aiExpertModule),
        smartTrainingModule: effective('smartTraining', config.smartTrainingModule),
        assessmentModule:    effective('assessment',    config.assessmentModule),
      ),
      languages: LanguagesConfig(
        defaultLanguage: config.defaultLanguage,
        supported:       config.supportedLanguages ?? [],
      ),
      passingPercentage: config.passingPercentage,
      aiChatPrompt:      config.aiChatPrompt,
    );
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

    ModuleConfigPublic? moduleConfig;
    if (organization?.id != null && appUser != null) {
      moduleConfig = await _buildModuleConfigPublic(
          session, organization!.id!, appUser);
    }

    return LoginResponse(
      success:      true,
      userInfo:     authResult.userInfo,
      organization: organization,
      moduleConfig: moduleConfig,
      keyId:        authResult.keyId,
      key:          authResult.key,
    );
  }

  // ── Content Bundle (GET) ────────────────────────────────────────────────────

  /// Returns theory, training parameters, and assessment parameters for
  /// [organizationId] in a single call.
  Future<Map<String, dynamic>> getContentBundle(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    final org = await Organization.db.findById(session, organizationId);
    if (org == null) throw Exception('Organization not found.');

    final results = await Future.wait([
      TheoryChapter.db.find(
        session,
        where:   (c) => c.organizationId.equals(organizationId),
        orderBy: (c) => c.chapterOrder,
      ),
      TrainingParameter.db.find(
        session,
        where: (p) => p.organizationId.equals(organizationId),
      ),
      AssessmentParameter.db.find(
        session,
        where: (p) => p.organizationId.equals(organizationId),
      ),
    ]);

    return {
      'theorySection': {
        'moduleTitle': org.name,
        'chapters': (results[0] as List<TheoryChapter>)
            .map((c) => _clean(c.toJson()))
            .toList(),
      },
      'trainingParameters': (results[1] as List<TrainingParameter>)
          .map((p) => _clean(p.toJson()))
          .toList(),
      'assessmentParameters': (results[2] as List<AssessmentParameter>)
          .map((p) => _clean(p.toJson()))
          .toList(),
    };
  }

  // ── Theory Section (GET) ────────────────────────────────────────────────────

  Future<Map<String, dynamic>> getTheorySection(
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

    return {
      'moduleTitle': org.name,
      'chapters':    chapters.map((c) => _clean(c.toJson())).toList(),
    };
  }

  // ── Smart Training (GET) ────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> getTrainingParameters(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    final params = await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    return params.map((p) => _clean(p.toJson())).toList();
  }

  // ── Assessment (GET) ────────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> getAssessmentParameters(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    final params = await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    return params.map((p) => _clean(p.toJson())).toList();
  }

  // ── Module Configuration (GET) ──────────────────────────────────────────────

  Future<Map<String, dynamic>> getModuleConfig(
    Session session,
    int organizationId,
    String apiKey,
    String userId,
  ) async {
    _validateApiKey(session, apiKey);

    final parsedId = int.tryParse(userId);
    final appUser =
        parsedId != null ? await AppUser.db.findById(session, parsedId) : null;

    final config =
        await _buildModuleConfigPublic(session, organizationId, appUser);
    if (config == null) {
      throw Exception('Module configuration not found for this organization.');
    }
    return _clean(config.toJson());
  }

  // ── Language (GET) ──────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> getLanguages(
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

    return {
      'defaultLanguage': config.defaultLanguage,
      'supported': (config.supportedLanguages ?? [])
          .map((l) => _clean(l.toJson()))
          .toList(),
    };
  }

  // ── Assets (GET) ────────────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> getAssets(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    final assets = await Asset.db.find(
      session,
      where: (a) => a.organizationId.equals(organizationId),
    );
    return assets.map((a) => _clean(a.toJson())).toList();
  }

  // ── Module Status (POST) ────────────────────────────────────────────────────

  Future<bool> updateModuleStatus(
    Session session,
    int organizationId,
    String apiKey,
    String userId,
    String moduleId,
    ModuleProgressStatus status,
  ) async {
    _validateApiKey(session, apiKey);

    final org = await Organization.db.findById(session, organizationId);
    if (org == null) throw Exception('Organization not found.');

    final parsedId = int.tryParse(userId);
    final appUser =
        parsedId != null ? await AppUser.db.findById(session, parsedId) : null;
    if (appUser == null) throw Exception('User not found.');

    final now = DateTime.now().toUtc();

    final existing = await UserModuleProgress.db.findFirstRow(
      session,
      where: (p) =>
          p.appUserId.equals(appUser.id) &
          p.organizationId.equals(organizationId) &
          p.moduleId.equals(moduleId),
    );

    if (existing != null) {
      existing.status = status;
      if (status == ModuleProgressStatus.inProgress &&
          existing.startedAt == null) {
        existing.startedAt = now;
      } else if (status == ModuleProgressStatus.completed &&
          existing.completedAt == null) {
        existing.completedAt = now;
      }
      await UserModuleProgress.db.updateRow(session, existing);
    } else {
      // Derive the org-level default for isEnabled from ModuleConfig.
      final config = await ModuleConfig.db.findFirstRow(
        session,
        where: (c) => c.organizationId.equals(organizationId),
      );
      final isEnabled = switch (moduleId) {
        'theory'        => config?.theoryModule        ?? true,
        'aiExpert'      => config?.aiExpertModule      ?? true,
        'smartTraining' => config?.smartTrainingModule ?? true,
        'assessment'    => config?.assessmentModule    ?? true,
        _               => true,
      };

      await UserModuleProgress.db.insertRow(
        session,
        UserModuleProgress(
          appUserId:      appUser.id!,
          organizationId: organizationId,
          moduleId:       moduleId,
          isEnabled:      isEnabled,
          status:         status,
          startedAt:
              status == ModuleProgressStatus.inProgress ? now : null,
          completedAt:
              status == ModuleProgressStatus.completed ? now : null,
        ),
      );
    }

    return true;
  }

  // ── Certificate / Training Result (POST) ────────────────────────────────────

  Future<Map<String, dynamic>> submitTrainingCertificate(
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

    return {
      'success':  true,
      'resultId': stored.id,
      'message':  'Training result recorded successfully.',
    };
  }
}
