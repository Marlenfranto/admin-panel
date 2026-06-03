import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

const String _systemDefaultLocaleKey = 'US-en';

/// Resolves locale content through the configured fallback chain.
///
/// Order:
///   1. Exact match on the requested locale key
///   2. The matching `LocaleConfig.fallbackLocaleKey`, if set
///   3. The organization's `ModuleConfig.defaultLocaleKey`
///   4. The system default (`US-en`)
class LocaleResolver {
  /// Returns the ordered list of locale keys to try for [organizationId],
  /// starting with [requestedLocaleKey] and ending at the system default.
  /// Deduplicated while preserving order.
  static Future<List<String>> resolveChain(
    Session session,
    int organizationId,
    String requestedLocaleKey,
  ) async {
    final chain = <String>[];
    void add(String? key) {
      if (key == null || key.isEmpty) return;
      if (!chain.contains(key)) chain.add(key);
    }

    add(requestedLocaleKey);

    final lc = await LocaleConfig.db.findFirstRow(
      session,
      where: (l) =>
          l.organizationId.equals(organizationId) &
          l.localeKey.equals(requestedLocaleKey),
    );
    add(lc?.fallbackLocaleKey);

    final cfg = await ModuleConfig.db.findFirstRow(
      session,
      where: (c) => c.organizationId.equals(organizationId),
    );
    add(cfg?.defaultLocaleKey);

    add(_systemDefaultLocaleKey);
    return chain;
  }

  /// Walks [chain] in order and returns the first non-null [lookup] result.
  static Future<T?> firstHit<T>(
    Iterable<String> chain,
    Future<T?> Function(String localeKey) lookup,
  ) async {
    for (final key in chain) {
      final hit = await lookup(key);
      if (hit != null) return hit;
    }
    return null;
  }

  static Future<TheoryChapterLocalization?> theoryChapter(
    Session session,
    int chapterId,
    Iterable<String> chain,
  ) {
    return firstHit(
      chain,
      (key) => TheoryChapterLocalization.db.findFirstRow(
        session,
        where: (l) =>
            l.chapterId.equals(chapterId) & l.localeKey.equals(key),
      ),
    );
  }

  static Future<TrainingParameterLocalization?> trainingParameter(
    Session session,
    int parameterId,
    Iterable<String> chain,
  ) {
    return firstHit(
      chain,
      (key) => TrainingParameterLocalization.db.findFirstRow(
        session,
        where: (l) =>
            l.parameterId.equals(parameterId) & l.localeKey.equals(key),
      ),
    );
  }

  static Future<AssessmentParameterLocalization?> assessmentParameter(
    Session session,
    int parameterId,
    Iterable<String> chain,
  ) {
    return firstHit(
      chain,
      (key) => AssessmentParameterLocalization.db.findFirstRow(
        session,
        where: (l) =>
            l.parameterId.equals(parameterId) & l.localeKey.equals(key),
      ),
    );
  }

  static Future<AssetLocalization?> asset(
    Session session,
    int assetId,
    Iterable<String> chain,
  ) {
    return firstHit(
      chain,
      (key) => AssetLocalization.db.findFirstRow(
        session,
        where: (l) => l.assetId.equals(assetId) & l.localeKey.equals(key),
      ),
    );
  }
}
