import 'package:flutter/widgets.dart';

import 'locale_key.dart';

/// Bridges the project's regional [LocaleKey] (e.g. `US-en`, `AE-ar`, `IN-ta`)
/// to a Flutter [Locale] that gen_l10n's `AppLocalizations` can resolve.
///
/// The UI ARB files (`app_en.arb`, `app_ar.arb`, `app_ta.arb`) are keyed by
/// **language code only** — region-specific content variants (`US-en` vs
/// `UK-en`) share the same UI strings. This class extracts the language code
/// from a locale key and returns the matching [Locale].
///
/// Set of languages with RTL script — used when [textDirectionFor] decides
/// whether to apply RTL. Add other RTL languages here (he, fa, ur, …) as they
/// ship in the ARB catalog.
class UiLocaleResolver {
  static const Set<String> _rtlLanguages = {
    'ar', // Arabic
    'fa', // Persian
    'he', // Hebrew
    'iw', // Hebrew (legacy code)
    'ps', // Pashto
    'sd', // Sindhi
    'ur', // Urdu
  };

  /// Maps a [LocaleKey] (e.g. `AE-ar`) to a Flutter [Locale] (`ar`, `AE`).
  /// Returns `Locale('en', 'US')` if the key is malformed.
  static Locale fromLocaleKey(String key) {
    if (!LocaleKey.isValid(key)) return const Locale('en', 'US');
    final parts = LocaleKey.parse(key);
    return Locale(parts.languageCode, parts.regionCode);
  }

  /// True when [languageCode] is a known RTL script.
  static bool isRtlLanguage(String languageCode) =>
      _rtlLanguages.contains(languageCode.toLowerCase());

  /// True when the language portion of [localeKey] is an RTL script.
  static bool isRtlLocaleKey(String localeKey) {
    if (!LocaleKey.isValid(localeKey)) return false;
    return isRtlLanguage(LocaleKey.parse(localeKey).languageCode);
  }

  /// Returns the appropriate [TextDirection] for [localeKey].
  static TextDirection textDirectionFor(String localeKey) =>
      isRtlLocaleKey(localeKey) ? TextDirection.rtl : TextDirection.ltr;
}
