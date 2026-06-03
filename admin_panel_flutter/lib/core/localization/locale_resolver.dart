import 'locale_key.dart';

/// Resolves embedded localizations (e.g. `LocalizedQuizContent`,
/// `LocalizedAiPrompt`) against a configurable fallback chain.
///
/// Server-side reads already apply this chain for top-level content via
/// `*Localized` endpoints. This client-side resolver covers content that
/// stays embedded in the parent JSON.
class LocaleResolver {
  /// Returns the ordered, deduplicated fallback chain:
  ///   1. [requested]
  ///   2. [orgDefault] (e.g. ModuleConfig.defaultLocaleKey)
  ///   3. system default (`US-en`)
  static List<String> resolveChain({
    required String requested,
    String? orgDefault,
  }) {
    final chain = <String>[];
    void add(String? key) {
      if (key == null || key.isEmpty) return;
      if (!chain.contains(key)) chain.add(key);
    }

    add(requested);
    add(orgDefault);
    add(LocaleKey.systemDefault);
    return chain;
  }

  /// Walks [chain] in order and returns the first [items] entry whose
  /// `keyOf` matches a step. Returns null if nothing matches.
  static T? firstMatch<T>({
    required List<String> chain,
    required Iterable<T> items,
    required String? Function(T) keyOf,
  }) {
    for (final key in chain) {
      for (final item in items) {
        if (keyOf(item) == key) return item;
      }
    }
    return null;
  }
}
