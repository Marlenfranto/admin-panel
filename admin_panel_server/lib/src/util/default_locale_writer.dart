import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Shared helpers used by the legacy upsert endpoints after the Phase 5c-2
/// root-field drop. Each helper:
///   1. Resolves the org's default locale key from ModuleConfig.
///   2. Upserts the matching `*Localization` row with the provided content.
///
/// The legacy upsert endpoints orchestrate (a) structural insert/update on
/// the parent table, then (b) call the matching writer to persist the
/// default-locale content. Non-default locales go through the per-locale CRUD
/// endpoints (Phase 3).

const String _systemDefaultLocaleKey = 'US-en';

Future<String> resolveOrgDefaultLocaleKey(
  Session session,
  int organizationId,
) async {
  final cfg = await ModuleConfig.db.findFirstRow(
    session,
    where: (c) => c.organizationId.equals(organizationId),
  );
  final key = cfg?.defaultLocaleKey;
  if (key == null || key.isEmpty) return _systemDefaultLocaleKey;
  return key;
}

Future<TheoryChapterLocalization> writeTheoryChapterDefaultContent(
  Session session,
  int chapterId,
  int organizationId, {
  String? title,
  String? description,
  String? thumbnailUrl,
  String? videoUrl,
  VideoMetadata? videoMetadata,
}) async {
  final localeKey =
      await resolveOrgDefaultLocaleKey(session, organizationId);
  final safeTitle = title ?? '';
  final existing = await TheoryChapterLocalization.db.findFirstRow(
    session,
    where: (l) =>
        l.chapterId.equals(chapterId) & l.localeKey.equals(localeKey),
  );
  if (existing != null) {
    existing.title = safeTitle;
    existing.description = description;
    existing.thumbnailUrl = thumbnailUrl;
    existing.videoUrl = videoUrl;
    existing.videoMetadata = videoMetadata;
    return await TheoryChapterLocalization.db.updateRow(session, existing);
  }
  return await TheoryChapterLocalization.db.insertRow(
    session,
    TheoryChapterLocalization(
      chapterId: chapterId,
      localeKey: localeKey,
      title: safeTitle,
      description: description,
      thumbnailUrl: thumbnailUrl,
      videoUrl: videoUrl,
      videoMetadata: videoMetadata,
    ),
  );
}

Future<TrainingParameterLocalization> writeTrainingParameterDefaultContent(
  Session session,
  int parameterId,
  int organizationId, {
  String? name,
  String? description,
  List<String>? scoringFeedbacks,
}) async {
  final localeKey =
      await resolveOrgDefaultLocaleKey(session, organizationId);
  final safeName = name ?? '';
  final safeDescription = description ?? '';
  final existing = await TrainingParameterLocalization.db.findFirstRow(
    session,
    where: (l) =>
        l.parameterId.equals(parameterId) & l.localeKey.equals(localeKey),
  );
  if (existing != null) {
    existing.name = safeName;
    existing.description = safeDescription;
    existing.scoringFeedbacks = scoringFeedbacks;
    return await TrainingParameterLocalization.db.updateRow(session, existing);
  }
  return await TrainingParameterLocalization.db.insertRow(
    session,
    TrainingParameterLocalization(
      parameterId: parameterId,
      localeKey: localeKey,
      name: safeName,
      description: safeDescription,
      scoringFeedbacks: scoringFeedbacks,
    ),
  );
}

Future<AssessmentParameterLocalization>
    writeAssessmentParameterDefaultContent(
  Session session,
  int parameterId,
  int organizationId, {
  String? name,
  String? description,
  List<String>? scoringFeedbacks,
}) async {
  final localeKey =
      await resolveOrgDefaultLocaleKey(session, organizationId);
  final safeName = name ?? '';
  final safeDescription = description ?? '';
  final existing = await AssessmentParameterLocalization.db.findFirstRow(
    session,
    where: (l) =>
        l.parameterId.equals(parameterId) & l.localeKey.equals(localeKey),
  );
  if (existing != null) {
    existing.name = safeName;
    existing.description = safeDescription;
    existing.scoringFeedbacks = scoringFeedbacks;
    return await AssessmentParameterLocalization.db
        .updateRow(session, existing);
  }
  return await AssessmentParameterLocalization.db.insertRow(
    session,
    AssessmentParameterLocalization(
      parameterId: parameterId,
      localeKey: localeKey,
      name: safeName,
      description: safeDescription,
      scoringFeedbacks: scoringFeedbacks,
    ),
  );
}

/// Writes per-question translations for [localeKey] onto [chapterId]'s
/// embedded `questions[].translations` list. Each entry in
/// [questionTranslations] applies to the question at the same index. Existing
/// translations for the same locale are replaced.
///
/// Updates the chapter row directly (no dual-write to the default-locale
/// localization row) since this method is for non-default content authoring.
Future<void> writeTheoryChapterQuizTranslations(
  Session session,
  int chapterId,
  String localeKey,
  List<LocalizedQuizContent> questionTranslations,
) async {
  final chapter = await TheoryChapter.db.findById(session, chapterId);
  if (chapter == null) {
    throw Exception('Theory chapter not found.');
  }
  final questions = chapter.questions;
  if (questions == null || questions.isEmpty) return;

  // Derive a legacy languageCode from the localeKey suffix ("US-en" -> "en")
  // so the deprecated field remains populated for any client still reading it.
  final dashIdx = localeKey.indexOf('-');
  final languageCode =
      dashIdx >= 0 ? localeKey.substring(dashIdx + 1) : localeKey;

  for (var i = 0; i < questions.length && i < questionTranslations.length; i++) {
    final q = questions[i];
    final incoming = questionTranslations[i];
    final translations =
        (q.translations ?? <LocalizedQuizContent>[]).toList(growable: true);
    translations.removeWhere(
      (t) => (t.localeKey ?? t.languageCode) == localeKey,
    );
    if (incoming.question.trim().isNotEmpty) {
      translations.add(
        LocalizedQuizContent(
          languageCode: languageCode,
          localeKey: localeKey,
          question: incoming.question,
          answers: incoming.answers,
        ),
      );
    }
    q.translations = translations.isEmpty ? null : translations;
  }
  chapter.questions = questions;
  await TheoryChapter.db.updateRow(session, chapter);
}

// ── Hydration helpers (populate transient fields on legacy reads) ─────────

Future<Map<int, String>> _orgDefaultLocaleMap(
  Session session,
  Iterable<int> orgIds,
) async {
  final ids = orgIds.toSet();
  if (ids.isEmpty) return const {};
  final cfgs = await ModuleConfig.db.find(
    session,
    where: (c) => c.organizationId.inSet(ids),
  );
  return {
    for (final cfg in cfgs)
      if (cfg.organizationId != null)
        cfg.organizationId!: cfg.defaultLocaleKey,
  };
}

/// Populates the non-persistent content fields on [chapters] from each
/// chapter's default-locale TheoryChapterLocalization row. Safe to call with
/// an empty list.
Future<void> hydrateTheoryChapters(
  Session session,
  List<TheoryChapter> chapters,
) async {
  if (chapters.isEmpty) return;
  final orgDefaults = await _orgDefaultLocaleMap(
    session,
    chapters.map((c) => c.organizationId).whereType<int>(),
  );
  final chapterIds = chapters.map((c) => c.id).whereType<int>().toSet();
  if (chapterIds.isEmpty) return;
  final locs = await TheoryChapterLocalization.db.find(
    session,
    where: (l) => l.chapterId.inSet(chapterIds),
  );
  final byKey = <(int, String), TheoryChapterLocalization>{
    for (final l in locs) (l.chapterId, l.localeKey): l,
  };
  for (final c in chapters) {
    final id = c.id;
    final orgId = c.organizationId;
    if (id == null || orgId == null) continue;
    final key = orgDefaults[orgId] ?? _systemDefaultLocaleKey;
    final loc = byKey[(id, key)];
    if (loc == null) continue;
    c.title = loc.title;
    c.description = loc.description;
    c.thumbnailUrl = loc.thumbnailUrl;
    c.videoUrl = loc.videoUrl;
    c.videoMetadata = loc.videoMetadata;
  }
}

Future<void> hydrateTrainingParameters(
  Session session,
  List<TrainingParameter> params,
) async {
  if (params.isEmpty) return;
  final orgDefaults = await _orgDefaultLocaleMap(
    session,
    params.map((p) => p.organizationId).whereType<int>(),
  );
  final paramIds = params.map((p) => p.id).whereType<int>().toSet();
  if (paramIds.isEmpty) return;
  final locs = await TrainingParameterLocalization.db.find(
    session,
    where: (l) => l.parameterId.inSet(paramIds),
  );
  final byKey = <(int, String), TrainingParameterLocalization>{
    for (final l in locs) (l.parameterId, l.localeKey): l,
  };
  for (final p in params) {
    final id = p.id;
    final orgId = p.organizationId;
    if (id == null || orgId == null) continue;
    final key = orgDefaults[orgId] ?? _systemDefaultLocaleKey;
    final loc = byKey[(id, key)];
    if (loc == null) continue;
    p.name = loc.name;
    p.description = loc.description;
  }
}

Future<void> hydrateAssessmentParameters(
  Session session,
  List<AssessmentParameter> params,
) async {
  if (params.isEmpty) return;
  final orgDefaults = await _orgDefaultLocaleMap(
    session,
    params.map((p) => p.organizationId).whereType<int>(),
  );
  final paramIds = params.map((p) => p.id).whereType<int>().toSet();
  if (paramIds.isEmpty) return;
  final locs = await AssessmentParameterLocalization.db.find(
    session,
    where: (l) => l.parameterId.inSet(paramIds),
  );
  final byKey = <(int, String), AssessmentParameterLocalization>{
    for (final l in locs) (l.parameterId, l.localeKey): l,
  };
  for (final p in params) {
    final id = p.id;
    final orgId = p.organizationId;
    if (id == null || orgId == null) continue;
    final key = orgDefaults[orgId] ?? _systemDefaultLocaleKey;
    final loc = byKey[(id, key)];
    if (loc == null) continue;
    p.name = loc.name;
    p.description = loc.description;
  }
}

Future<void> hydrateAssets(
  Session session,
  List<Asset> assets,
) async {
  if (assets.isEmpty) return;
  final orgDefaults = await _orgDefaultLocaleMap(
    session,
    assets.map((a) => a.organizationId).whereType<int>(),
  );
  final assetIds = assets.map((a) => a.id).whereType<int>().toSet();
  if (assetIds.isEmpty) return;
  final locs = await AssetLocalization.db.find(
    session,
    where: (l) => l.assetId.inSet(assetIds),
  );
  final byKey = <(int, String), AssetLocalization>{
    for (final l in locs) (l.assetId, l.localeKey): l,
  };
  for (final a in assets) {
    final id = a.id;
    final orgId = a.organizationId;
    if (id == null || orgId == null) continue;
    final key = orgDefaults[orgId] ?? _systemDefaultLocaleKey;
    final loc = byKey[(id, key)];
    if (loc == null) continue;
    a.name = loc.name;
    a.description = loc.description;
    a.url = loc.url;
  }
}

Future<AssetLocalization> writeAssetDefaultContent(
  Session session,
  int assetId,
  int organizationId, {
  String? name,
  String? description,
  String? url,
}) async {
  final localeKey =
      await resolveOrgDefaultLocaleKey(session, organizationId);
  final safeName = name ?? '';
  final safeUrl = url ?? '';
  final existing = await AssetLocalization.db.findFirstRow(
    session,
    where: (l) =>
        l.assetId.equals(assetId) & l.localeKey.equals(localeKey),
  );
  if (existing != null) {
    existing.name = safeName;
    existing.description = description;
    existing.url = safeUrl;
    return await AssetLocalization.db.updateRow(session, existing);
  }
  return await AssetLocalization.db.insertRow(
    session,
    AssetLocalization(
      assetId: assetId,
      localeKey: localeKey,
      name: safeName,
      description: description,
      url: safeUrl,
    ),
  );
}
