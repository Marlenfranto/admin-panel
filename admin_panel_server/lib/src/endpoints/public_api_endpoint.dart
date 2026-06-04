import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import '../generated/protocol.dart';
import '../util/default_locale_writer.dart';
import '../util/locale_resolver.dart';
import '../util/locale_validator.dart';

class PublicApiEndpoint extends Endpoint {
  // This endpoint does not require login for its methods.

  // ── Internal helpers ────────────────────────────────────────────────────────

  static const String _systemDefaultLocaleKey = 'US-en';

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

  /// Extracts the language code from a canonical locale key like
  /// `US-en` → `en`. Returns the whole key when no `-` separator is present.
  String _languageCodeFromLocaleKey(String localeKey) {
    final dash = localeKey.indexOf('-');
    return dash < 0 ? localeKey : localeKey.substring(dash + 1);
  }

  /// Minimal ISO-639-1 → English language-name lookup for the simplified
  /// `languages.supported` envelope returned by [getModuleConfig]. Extend
  /// this map when adding support for a new content language.
  static const Map<String, String> _languageNamesByCode = {
    'en': 'English',
    'ar': 'Arabic',
    'ta': 'Tamil',
    'hi': 'Hindi',
    'ur': 'Urdu',
    'bn': 'Bengali',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'pt': 'Portuguese',
    'it': 'Italian',
    'ru': 'Russian',
    'zh': 'Chinese',
    'ja': 'Japanese',
    'ko': 'Korean',
    'tr': 'Turkish',
    'fa': 'Persian',
    'he': 'Hebrew',
    'th': 'Thai',
    'vi': 'Vietnamese',
    'id': 'Indonesian',
    'ms': 'Malay',
    'nl': 'Dutch',
    'pl': 'Polish',
  };

  /// Returns a clean language name for the simplified `languages.supported`
  /// envelope. Prefers the canonical ISO name, then strips any `(REGION)`
  /// suffix from the admin-entered display name (`English (US)` → `English`),
  /// then falls back to the raw display name, then the code itself.
  String _languageNameFor(String languageCode, String? displayName) {
    final canonical = _languageNamesByCode[languageCode.toLowerCase()];
    if (canonical != null) return canonical;
    if (displayName != null && displayName.isNotEmpty) {
      final paren = displayName.indexOf('(');
      final cleaned = (paren > 0 ? displayName.substring(0, paren) : displayName)
          .trim();
      if (cleaned.isNotEmpty) return cleaned;
    }
    return languageCode;
  }

  /// Returns the org's region/locale catalog: the default locale key, the list
  /// of enabled `LocaleConfig` rows, and the list of enabled `Region` rows.
  /// Embedded into every public content response so external clients always
  /// see the available regions and locales alongside the content payload.
  Future<Map<String, dynamic>> _buildLocaleMeta(
    Session session,
    int organizationId,
  ) async {
    final config = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(organizationId),
    );
    final supportedLocales = await LocaleConfig.db.find(
      session,
      where: (l) =>
          l.organizationId.equals(organizationId) & l.enabled.equals(true),
      orderBy: (l) => l.localeKey,
    );
    final regions = await Region.db.find(
      session,
      where: (r) =>
          r.organizationId.equals(organizationId) & r.enabled.equals(true),
      orderBy: (r) => r.code,
    );
    return {
      'defaultLocaleKey': config?.defaultLocaleKey ?? _systemDefaultLocaleKey,
      'regions': regions.map((r) => _clean(r.toJson())).toList(),
      'supportedLocales':
          supportedLocales.map((l) => _clean(l.toJson())).toList(),
    };
  }

  /// Builds the locale-resolution envelope for a localized request: the org's
  /// `_buildLocaleMeta` payload PLUS the caller-supplied `requestedLocaleKey`
  /// and the ordered fallback chain that will be walked per item.
  Future<Map<String, dynamic>> _buildLocaleResolution(
    Session session,
    int organizationId,
    String requestedLocaleKey,
  ) async {
    final meta = await _buildLocaleMeta(session, organizationId);
    final chain = await LocaleResolver.resolveChain(
      session,
      organizationId,
      requestedLocaleKey,
    );
    return {
      ...meta,
      'requestedLocaleKey': requestedLocaleKey,
      'resolvedLocaleChain': chain,
    };
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

    final supportedLocales = await LocaleConfig.db.find(
      session,
      where: (l) =>
          l.organizationId.equals(organizationId) & l.enabled.equals(true),
      orderBy: (l) => l.localeKey,
    );

    // Drop legacy pre-Phase-2 rows whose `localeKey` is null or just the bare
    // language code (e.g. "ta"). Canonical entries use the REGION-language
    // form (e.g. "IN-ta"); the legacy concept was removed but old rows may
    // still sit in the DB next to the canonical one.
    final canonicalAiPromptTranslations =
        (config.aiChatPromptTranslations ?? const <LocalizedAiPrompt>[])
            .where((t) => isValidLocaleKeyFormat(t.localeKey))
            .toList();

    // Resolve the AR Expert AI prompt to the user's preferred regional locale.
    // Walks the fallback chain (preferred → LocaleConfig.fallbackLocaleKey →
    // org default) and picks the first matching translation. If nothing
    // matches, the root prompt (the default-locale baseline) is returned.
    final resolvedAiPrompt = await _resolveAiPrompt(
      session,
      organizationId,
      appUser?.preferredLocaleKey,
      config.aiChatPrompt,
      canonicalAiPromptTranslations,
    );

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
      defaultLocaleKey: config.defaultLocaleKey,
      supportedLocales: supportedLocales,
      passingPercentage: config.passingPercentage,
      // Coerce nullable fields to non-null defaults so the generated
      // `toJson()` always emits them. Serverpod omits nullable fields when
      // null (`if (x != null)`), which made these vanish from the login
      // response whenever an admin hadn't authored a prompt yet.
      aiChatPrompt:      resolvedAiPrompt ?? '',
      aiChatPromptTranslations: canonicalAiPromptTranslations,
    );
  }

  /// Picks the AR Expert AI prompt for [requestedLocaleKey] from
  /// [translations], walking the standard locale fallback chain. Falls back
  /// to [rootPrompt] (the default-locale baseline) if nothing matches.
  Future<String?> _resolveAiPrompt(
    Session session,
    int organizationId,
    String? requestedLocaleKey,
    String? rootPrompt,
    List<LocalizedAiPrompt>? translations,
  ) async {
    if (translations == null || translations.isEmpty) return rootPrompt;
    if (requestedLocaleKey == null || requestedLocaleKey.isEmpty) {
      return rootPrompt;
    }
    final chain = await LocaleResolver.resolveChain(
      session,
      organizationId,
      requestedLocaleKey,
    );
    for (final key in chain) {
      for (final t in translations) {
        // Match localeKey first (canonical), fall back to legacy languageCode
        // for any pre-Phase-2 rows that may still exist.
        final tKey = t.localeKey ?? t.languageCode;
        if (tKey == key && t.prompt.isNotEmpty) return t.prompt;
      }
    }
    return rootPrompt;
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
    int? teamOrgId;
    if (appUser != null) {
      final link = await OrganizationUserLink.db.findFirstRow(
        session,
        where: (l) => l.appUserId.equals(appUser.id),
      );
      if (link != null) {
        teamOrgId = link.organizationId;
        // Top-level (root) org becomes the `organization` block. If the user
        // is linked to a team (child org), the team is nested under
        // `children` so the response is shaped "top level → team".
        final topLevelOrgId =
            await _findTopLevelOrgId(session, teamOrgId);
        if (topLevelOrgId == teamOrgId) {
          organization = await Organization.db.findById(
            session,
            topLevelOrgId,
          );
        } else {
          final teamId = teamOrgId;
          organization = await Organization.db.findById(
            session,
            topLevelOrgId,
            include: Organization.include(
              children: Organization.includeList(
                where: (c) => c.id.equals(teamId),
              ),
            ),
          );
        }
      }
    }

    ModuleConfigPublic? moduleConfig;
    if (organization?.id != null) {
      // Walk up from the user's team to inherit the first ancestor's
      // ModuleConfig (so team members see the parent's prompt/passing
      // percentage/etc. even when the team itself has no config row).
      final lookupOrgId = teamOrgId ?? organization!.id!;
      final configOrgId = await _findConfigOrgId(session, lookupOrgId);
      if (configOrgId != null) {
        moduleConfig = await _buildModuleConfigPublic(
            session, configOrgId, appUser);
      }
      moduleConfig ??= await _defaultModuleConfigPublic(session, organization!);
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

  /// Walks the org parent chain starting at [orgId] and returns the id of
  /// the root (top-level) org — the first ancestor whose `parentId` is null.
  /// Returns [orgId] itself if that org has no parent. A `visited` set
  /// guards against accidental cycles in `parentId`.
  Future<int> _findTopLevelOrgId(Session session, int orgId) async {
    var currentId = orgId;
    final visited = <int>{};
    while (visited.add(currentId)) {
      final org = await Organization.db.findById(session, currentId);
      final parentId = org?.parentId;
      if (parentId == null) return currentId;
      currentId = parentId;
    }
    return currentId;
  }

  /// Walks the org parent chain starting at [orgId] and returns the id of
  /// the first ancestor that owns a [ModuleConfig] row, or null if none of
  /// the ancestors do. Used by [login] so that a user linked to a team
  /// inherits the parent org's module config.
  Future<int?> _findConfigOrgId(Session session, int orgId) async {
    var currentId = orgId;
    final visited = <int>{};
    while (visited.add(currentId)) {
      final config = await ModuleConfig.db.findFirstRow(
        session,
        where: (c) => c.organizationId.equals(currentId),
      );
      if (config != null) return currentId;
      final org = await Organization.db.findById(session, currentId);
      final parentId = org?.parentId;
      if (parentId == null) return null;
      currentId = parentId;
    }
    return null;
  }

  /// Builds a baseline [ModuleConfigPublic] for orgs that have no
  /// `ModuleConfig` row yet, so the login response always carries the
  /// moduleConfig envelope. Uses the org's own `supportedLocales` and
  /// `defaultLocaleKey` (falling back to the system default) and disables
  /// every subscription module until the admin opts in.
  Future<ModuleConfigPublic> _defaultModuleConfigPublic(
    Session session,
    Organization organization,
  ) async {
    final orgId = organization.id!;
    final supportedLocales = await LocaleConfig.db.find(
      session,
      where: (l) =>
          l.organizationId.equals(orgId) & l.enabled.equals(true),
      orderBy: (l) => l.localeKey,
    );
    return ModuleConfigPublic(
      configId:       'ORG${orgId}_v1.0.0',
      lastUpdated:    _dateString(DateTime.now()),
      contentVersion: organization.contentVersion,
      subscriptionModules: SubscriptionModules(
        theoryModule:        false,
        aiExpertModule:      false,
        smartTrainingModule: false,
        assessmentModule:    false,
      ),
      defaultLocaleKey: _systemDefaultLocaleKey,
      supportedLocales: supportedLocales,
      passingPercentage: 60,
      aiChatPrompt:      '',
      aiChatPromptTranslations: const <LocalizedAiPrompt>[],
    );
  }

  // ── Content Bundle (GET) ────────────────────────────────────────────────────

  /// Returns theory, training parameters, and assessment parameters for
  /// [organizationId] in a single call. Top-level fields include the org's
  /// region/locale catalog (`defaultLocaleKey`, `regions`, `supportedLocales`).
  /// Content fields inside each chapter/param/asset are populated from the
  /// org's default-locale `*Localization` rows.
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
    final chapters = results[0] as List<TheoryChapter>;
    final trainingParams = results[1] as List<TrainingParameter>;
    final assessmentParams = results[2] as List<AssessmentParameter>;
    await hydrateTheoryChapters(session, chapters);
    await hydrateTrainingParameters(session, trainingParams);
    await hydrateAssessmentParameters(session, assessmentParams);

    final theoryLocalizationsByChapter =
        await _theoryLocalizationsByChapter(session, chapters);
    final trainingLocalizationsByParam =
        await _trainingLocalizationsByParam(session, trainingParams);
    final assessmentLocalizationsByParam =
        await _assessmentLocalizationsByParam(session, assessmentParams);

    final meta = await _buildLocaleMeta(session, organizationId);

    return {
      ...meta,
      'organizationId': organizationId,
      'contentVersion': org.contentVersion,
      'theorySection': {
        'moduleTitle': org.name,
        'chapters': chapters.map((c) {
          final json = _clean(c.toJson());
          json['translations'] =
              theoryLocalizationsByChapter[c.id] ?? const <dynamic>[];
          return json;
        }).toList(),
      },
      'trainingParameters': trainingParams.map((p) {
        final json = _clean(p.toJson());
        json['translations'] =
            trainingLocalizationsByParam[p.id] ?? const <dynamic>[];
        return json;
      }).toList(),
      'assessmentParameters': assessmentParams.map((p) {
        final json = _clean(p.toJson());
        json['translations'] =
            assessmentLocalizationsByParam[p.id] ?? const <dynamic>[];
        return json;
      }).toList(),
    };
  }

  /// Batch-fetches every `TheoryChapterLocalization` row for [chapters] and
  /// returns a map keyed by `chapterId` with each value already serialized
  /// (and `__className__`-stripped) for embedding in the response.
  Future<Map<int, List<Map<String, dynamic>>>> _theoryLocalizationsByChapter(
    Session session,
    List<TheoryChapter> chapters,
  ) async {
    final chapterIds = chapters.map((c) => c.id).whereType<int>().toSet();
    if (chapterIds.isEmpty) return const {};
    final locs = await TheoryChapterLocalization.db.find(
      session,
      where: (l) => l.chapterId.inSet(chapterIds),
      orderBy: (l) => l.localeKey,
    );
    final out = <int, List<Map<String, dynamic>>>{};
    for (final l in locs) {
      final json = _clean(l.toJson());
      json['languageCode'] = _languageCodeFromLocaleKey(l.localeKey);
      out.putIfAbsent(l.chapterId, () => []).add(json);
    }
    return out;
  }

  /// Batch-fetches every `TrainingParameterLocalization` row for [params] and
  /// returns a map keyed by `parameterId` with each value already serialized
  /// (and `__className__`-stripped) for embedding in the response.
  Future<Map<int, List<Map<String, dynamic>>>> _trainingLocalizationsByParam(
    Session session,
    List<TrainingParameter> params,
  ) async {
    final paramIds = params.map((p) => p.id).whereType<int>().toSet();
    if (paramIds.isEmpty) return const {};
    final locs = await TrainingParameterLocalization.db.find(
      session,
      where: (l) => l.parameterId.inSet(paramIds),
      orderBy: (l) => l.localeKey,
    );
    final out = <int, List<Map<String, dynamic>>>{};
    for (final l in locs) {
      final json = _clean(l.toJson());
      json['languageCode'] = _languageCodeFromLocaleKey(l.localeKey);
      out.putIfAbsent(l.parameterId, () => []).add(json);
    }
    return out;
  }

  /// Batch-fetches every `AssessmentParameterLocalization` row for [params]
  /// and returns a map keyed by `parameterId` with each value already
  /// serialized (and `__className__`-stripped) for embedding in the response.
  Future<Map<int, List<Map<String, dynamic>>>> _assessmentLocalizationsByParam(
    Session session,
    List<AssessmentParameter> params,
  ) async {
    final paramIds = params.map((p) => p.id).whereType<int>().toSet();
    if (paramIds.isEmpty) return const {};
    final locs = await AssessmentParameterLocalization.db.find(
      session,
      where: (l) => l.parameterId.inSet(paramIds),
      orderBy: (l) => l.localeKey,
    );
    final out = <int, List<Map<String, dynamic>>>{};
    for (final l in locs) {
      final json = _clean(l.toJson());
      json['languageCode'] = _languageCodeFromLocaleKey(l.localeKey);
      out.putIfAbsent(l.parameterId, () => []).add(json);
    }
    return out;
  }

  // ── Theory Section (GET) ────────────────────────────────────────────────────

  /// Returns the theory chapters for [organizationId] populated with the
  /// org's default-locale content. The envelope includes the region/locale
  /// catalog so the caller can immediately offer a locale picker without a
  /// second round trip.
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
    await hydrateTheoryChapters(session, chapters);

    final meta = await _buildLocaleMeta(session, organizationId);

    return {
      ...meta,
      'organizationId': organizationId,
      'moduleTitle': org.name,
      'chapters':    chapters.map((c) => _clean(c.toJson())).toList(),
    };
  }

  // ── Smart Training (GET) ────────────────────────────────────────────────────

  /// Returns training parameters for [organizationId] populated with the
  /// org's default-locale content. Wrapped in an envelope that includes the
  /// region/locale catalog. Pre-existing callers that expected a bare list
  /// must read `parameters` from the envelope.
  Future<Map<String, dynamic>> getTrainingParameters(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    final params = await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    await hydrateTrainingParameters(session, params);

    final meta = await _buildLocaleMeta(session, organizationId);

    return {
      ...meta,
      'organizationId': organizationId,
      'parameters': params.map((p) => _clean(p.toJson())).toList(),
    };
  }

  // ── Assessment (GET) ────────────────────────────────────────────────────────

  /// Returns assessment parameters for [organizationId] populated with the
  /// org's default-locale content. Wrapped in an envelope that includes the
  /// region/locale catalog.
  Future<Map<String, dynamic>> getAssessmentParameters(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    final params = await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    await hydrateAssessmentParameters(session, params);

    final meta = await _buildLocaleMeta(session, organizationId);

    return {
      ...meta,
      'organizationId': organizationId,
      'parameters': params.map((p) => _clean(p.toJson())).toList(),
    };
  }

  // ── Module Configuration (GET) ──────────────────────────────────────────────

  /// Returns the public module configuration for [organizationId], augmented
  /// with the per-user `moduleStatuses` map when [userId] resolves to an
  /// `AppUser`. The response also exposes the org's `regions` list alongside
  /// the existing `defaultLocaleKey` and `supportedLocales` already on
  /// `ModuleConfigPublic`.
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

    final result = _clean(config.toJson());

    // The org's region catalog is not part of `ModuleConfigPublic`; merge it
    // in here so external clients see regions + locales in one response.
    final regions = await Region.db.find(
      session,
      where: (r) =>
          r.organizationId.equals(organizationId) & r.enabled.equals(true),
      orderBy: (r) => r.code,
    );
    result['regions'] = regions.map((r) => _clean(r.toJson())).toList();

    // Simplified `{defaultLanguage, supported: [{code, name}]}` envelope for
    // clients that only care about language (not region). Deduplicated by
    // `languageCode`, ordered by first appearance in supportedLocales.
    final supportedLanguages = <Map<String, String>>[];
    final seen = <String>{};
    for (final l in config.supportedLocales ?? const <LocaleConfig>[]) {
      if (!seen.add(l.languageCode)) continue;
      supportedLanguages.add({
        'code': l.languageCode,
        'name': _languageNameFor(l.languageCode, l.displayName),
      });
    }
    result['languages'] = {
      'defaultLanguage': _languageCodeFromLocaleKey(config.defaultLocaleKey),
      'supported': supportedLanguages,
    };

    if (appUser != null) {
      result['userId'] = appUser.id;
      result['preferredLocaleKey'] = appUser.preferredLocaleKey;

      final userProgress = await UserModuleProgress.db.find(
        session,
        where: (p) =>
            p.appUserId.equals(appUser.id) &
            p.organizationId.equals(organizationId),
      );

      final statuses = <String, String>{
        'theory': ModuleProgressStatus.notStarted.name,
        'aiExpert': ModuleProgressStatus.notStarted.name,
        'smartTraining': ModuleProgressStatus.notStarted.name,
        'assessment': ModuleProgressStatus.notStarted.name,
      };

      for (final p in userProgress) {
        statuses[p.moduleId] = p.status.name;
      }

      result['moduleStatuses'] = statuses;
    }

    return result;
  }

  // ── Language (GET) — DEPRECATED ────────────────────────────────────────────

  /// **DEPRECATED.** Returns the legacy `{defaultLanguage, supported}` envelope
  /// for external apps that have not migrated to the regional locale model.
  /// New integrations should call [getLocales] and [getRegions] instead.
  ///
  /// The response now also carries `defaultLocaleKey`, `supportedLocales`,
  /// and `regions` so a client can perform a one-shot migration if needed.
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
    final locales = await LocaleConfig.db.find(
      session,
      where: (l) =>
          l.organizationId.equals(organizationId) & l.enabled.equals(true),
      orderBy: (l) => l.localeKey,
    );
    final regions = await Region.db.find(
      session,
      where: (r) =>
          r.organizationId.equals(organizationId) & r.enabled.equals(true),
      orderBy: (r) => r.code,
    );

    // Backward-compat envelope for the external training app that hasn't
    // migrated to getLocales yet. `defaultLanguage` is derived from the
    // default LocaleConfig's languageCode (e.g. "US-en" → "en").
    final defaultLang = locales
            .firstWhere(
              (l) => l.localeKey == config.defaultLocaleKey,
              orElse: () => locales.isNotEmpty
                  ? locales.first
                  : LocaleConfig(
                      organizationId: organizationId,
                      regionCode: 'US',
                      languageCode: 'en',
                      localeKey: 'US-en',
                      displayName: 'English',
                    ),
            )
            .languageCode;
    return {
      'deprecated': true,
      'migrateTo': ['getLocales', 'getRegions'],
      'defaultLanguage': defaultLang,
      'supported': locales
          .map((l) => {
                'code': l.languageCode,
                'name': l.displayName,
                'contentUrl': null,
              })
          .toList(),
      // Forward-compat fields — present on every response so a client can
      // adopt the regional model without changing endpoints first.
      'defaultLocaleKey': config.defaultLocaleKey,
      'regions': regions.map((r) => _clean(r.toJson())).toList(),
      'supportedLocales': locales.map((l) => _clean(l.toJson())).toList(),
    };
  }

  // ── Assets (GET) ────────────────────────────────────────────────────────────

  /// Returns assets for [organizationId] populated with the org's
  /// default-locale content. Wrapped in an envelope that includes the
  /// region/locale catalog.
  Future<Map<String, dynamic>> getAssets(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);

    final assets = await Asset.db.find(
      session,
      where: (a) => a.organizationId.equals(organizationId),
    );
    await hydrateAssets(session, assets);

    final meta = await _buildLocaleMeta(session, organizationId);

    return {
      ...meta,
      'organizationId': organizationId,
      'assets': assets.map((a) => _clean(a.toJson())).toList(),
    };
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

  // ── Region / Locale catalog (GET) ───────────────────────────────────────────

  /// Lists the enabled `LocaleConfig` entries for [organizationId]. Use this to
  /// populate a locale picker on the external client before calling any of the
  /// `*Localized` reads below. Wrapped in an envelope that also includes
  /// `defaultLocaleKey` and `regions` so a single call powers a region+locale
  /// picker.
  Future<Map<String, dynamic>> getLocales(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);
    final meta = await _buildLocaleMeta(session, organizationId);
    return {
      ...meta,
      'organizationId': organizationId,
      // Alias: the canonical list is at `supportedLocales`. `locales` is kept
      // as a friendly synonym for clients that prefer the shorter name.
      'locales': meta['supportedLocales'],
    };
  }

  /// Lists the enabled `Region` entries for [organizationId]. Returned in the
  /// same envelope shape as [getLocales] so a client can build a region
  /// selector and then filter `supportedLocales` by the chosen region code.
  Future<Map<String, dynamic>> getRegions(
    Session session,
    int organizationId,
    String apiKey,
  ) async {
    _validateApiKey(session, apiKey);
    final meta = await _buildLocaleMeta(session, organizationId);
    return {
      'organizationId': organizationId,
      'defaultLocaleKey': meta['defaultLocaleKey'],
      'regions': meta['regions'],
      'supportedLocales': meta['supportedLocales'],
    };
  }

  // ── Locale-aware reads ──────────────────────────────────────────────────────
  //
  // External clients that send a [localeKey] get content resolved through the
  // server-side fallback chain. Every response includes the resolution
  // envelope (`requestedLocaleKey`, `resolvedLocaleChain`, `regions`,
  // `supportedLocales`, `defaultLocaleKey`) so the client can show which
  // locale was actually rendered without a second call.

  Future<Map<String, dynamic>> getTheorySectionLocalized(
    Session session,
    int organizationId,
    String apiKey,
    String localeKey,
  ) async {
    _validateApiKey(session, apiKey);
    validateLocaleKeyFormat(localeKey);

    final org = await Organization.db.findById(session, organizationId);
    if (org == null) throw Exception('Organization not found.');

    final chapters = await TheoryChapter.db.find(
      session,
      where:   (c) => c.organizationId.equals(organizationId),
      orderBy: (c) => c.chapterOrder,
    );
    final resolution = await _buildLocaleResolution(
      session,
      organizationId,
      localeKey,
    );
    final chain = List<String>.from(
        resolution['resolvedLocaleChain'] as List<dynamic>);

    final resolvedChapters = <Map<String, dynamic>>[];
    for (final c in chapters) {
      final id = c.id;
      if (id == null) {
        resolvedChapters.add({
          ..._clean(c.toJson()),
          'resolvedLocaleKey': null,
        });
        continue;
      }
      final loc = await LocaleResolver.theoryChapter(session, id, chain);
      final resolved = TheoryChapter(
        id: c.id,
        organizationId: c.organizationId,
        chapterOrder: c.chapterOrder,
        title: loc?.title ?? c.title,
        thumbnailUrl: loc?.thumbnailUrl ?? c.thumbnailUrl,
        videoUrl: loc?.videoUrl ?? c.videoUrl,
        videoMetadata: loc?.videoMetadata ?? c.videoMetadata,
        questions: c.questions,
      );
      resolvedChapters.add({
        ..._clean(resolved.toJson()),
        'resolvedLocaleKey': loc?.localeKey,
      });
    }
    return {
      ...resolution,
      'organizationId': organizationId,
      'moduleTitle': org.name,
      // Kept for backward compatibility with pre-envelope callers.
      'localeKey': localeKey,
      'chapters': resolvedChapters,
    };
  }

  Future<Map<String, dynamic>> getTrainingParametersLocalized(
    Session session,
    int organizationId,
    String apiKey,
    String localeKey,
  ) async {
    _validateApiKey(session, apiKey);
    validateLocaleKeyFormat(localeKey);

    final params = await TrainingParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    final resolution = await _buildLocaleResolution(
      session,
      organizationId,
      localeKey,
    );
    final chain = List<String>.from(
        resolution['resolvedLocaleChain'] as List<dynamic>);

    final out = <Map<String, dynamic>>[];
    for (final p in params) {
      final id = p.id;
      if (id == null) {
        out.add({
          ..._clean(p.toJson()),
          'resolvedLocaleKey': null,
        });
        continue;
      }
      final loc = await LocaleResolver.trainingParameter(session, id, chain);
      final resolved = TrainingParameter(
        id: p.id,
        organizationId: p.organizationId,
        paramId: p.paramId,
        name: loc?.name ?? p.name,
        description: loc?.description ?? p.description,
        maxScore: p.maxScore,
        scoringRules: p.scoringRules,
        translations: p.translations,
      );
      out.add({
        ..._clean(resolved.toJson()),
        'scoringFeedbacks': loc?.scoringFeedbacks,
        'resolvedLocaleKey': loc?.localeKey,
      });
    }
    return {
      ...resolution,
      'organizationId': organizationId,
      'parameters': out,
    };
  }

  Future<Map<String, dynamic>> getAssessmentParametersLocalized(
    Session session,
    int organizationId,
    String apiKey,
    String localeKey,
  ) async {
    _validateApiKey(session, apiKey);
    validateLocaleKeyFormat(localeKey);

    final params = await AssessmentParameter.db.find(
      session,
      where: (p) => p.organizationId.equals(organizationId),
    );
    final resolution = await _buildLocaleResolution(
      session,
      organizationId,
      localeKey,
    );
    final chain = List<String>.from(
        resolution['resolvedLocaleChain'] as List<dynamic>);

    final out = <Map<String, dynamic>>[];
    for (final p in params) {
      final id = p.id;
      if (id == null) {
        out.add({
          ..._clean(p.toJson()),
          'resolvedLocaleKey': null,
        });
        continue;
      }
      final loc =
          await LocaleResolver.assessmentParameter(session, id, chain);
      final resolved = AssessmentParameter(
        id: p.id,
        organizationId: p.organizationId,
        paramId: p.paramId,
        name: loc?.name ?? p.name,
        description: loc?.description ?? p.description,
        maxScore: p.maxScore,
        scoringRules: p.scoringRules,
        translations: p.translations,
      );
      out.add({
        ..._clean(resolved.toJson()),
        'scoringFeedbacks': loc?.scoringFeedbacks,
        'resolvedLocaleKey': loc?.localeKey,
      });
    }
    return {
      ...resolution,
      'organizationId': organizationId,
      'parameters': out,
    };
  }

  Future<Map<String, dynamic>> getAssetsLocalized(
    Session session,
    int organizationId,
    String apiKey,
    String localeKey,
  ) async {
    _validateApiKey(session, apiKey);
    validateLocaleKeyFormat(localeKey);

    final assets = await Asset.db.find(
      session,
      where: (a) => a.organizationId.equals(organizationId),
    );
    final resolution = await _buildLocaleResolution(
      session,
      organizationId,
      localeKey,
    );
    final chain = List<String>.from(
        resolution['resolvedLocaleChain'] as List<dynamic>);

    final out = <Map<String, dynamic>>[];
    for (final a in assets) {
      final id = a.id;
      if (id == null) {
        out.add({
          ..._clean(a.toJson()),
          'resolvedLocaleKey': null,
        });
        continue;
      }
      final loc = await LocaleResolver.asset(session, id, chain);
      final resolved = Asset(
        id: a.id,
        organizationId: a.organizationId,
        name: loc?.name ?? a.name,
        version: a.version,
        url: loc?.url ?? a.url,
        description: loc?.description ?? a.description,
        module: a.module,
      );
      out.add({
        ..._clean(resolved.toJson()),
        'resolvedLocaleKey': loc?.localeKey,
      });
    }
    return {
      ...resolution,
      'organizationId': organizationId,
      'assets': out,
    };
  }
}
