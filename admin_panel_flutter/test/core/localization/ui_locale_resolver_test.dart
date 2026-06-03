import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:admin_panel_flutter/core/localization/ui_locale_resolver.dart';

void main() {
  group('UiLocaleResolver.fromLocaleKey', () {
    test('extracts language + region from a valid key', () {
      final locale = UiLocaleResolver.fromLocaleKey('AE-ar');
      expect(locale.languageCode, 'ar');
      expect(locale.countryCode, 'AE');
    });

    test('handles three-letter language codes (Tamil ta)', () {
      final locale = UiLocaleResolver.fromLocaleKey('IN-ta');
      expect(locale.languageCode, 'ta');
      expect(locale.countryCode, 'IN');
    });

    test('falls back to US-en when the key is malformed', () {
      final locale = UiLocaleResolver.fromLocaleKey('garbage');
      expect(locale.languageCode, 'en');
      expect(locale.countryCode, 'US');
    });
  });

  group('UiLocaleResolver.isRtlLanguage', () {
    test('returns true for ar/he/fa/ur', () {
      expect(UiLocaleResolver.isRtlLanguage('ar'), isTrue);
      expect(UiLocaleResolver.isRtlLanguage('he'), isTrue);
      expect(UiLocaleResolver.isRtlLanguage('fa'), isTrue);
      expect(UiLocaleResolver.isRtlLanguage('ur'), isTrue);
    });

    test('is case-insensitive', () {
      expect(UiLocaleResolver.isRtlLanguage('AR'), isTrue);
    });

    test('returns false for en/ta/es/fr', () {
      expect(UiLocaleResolver.isRtlLanguage('en'), isFalse);
      expect(UiLocaleResolver.isRtlLanguage('ta'), isFalse);
      expect(UiLocaleResolver.isRtlLanguage('es'), isFalse);
      expect(UiLocaleResolver.isRtlLanguage('fr'), isFalse);
    });
  });

  group('UiLocaleResolver.textDirectionFor', () {
    test('returns RTL for Arabic locale keys', () {
      expect(
        UiLocaleResolver.textDirectionFor('AE-ar'),
        TextDirection.rtl,
      );
      expect(
        UiLocaleResolver.textDirectionFor('SA-ar'),
        TextDirection.rtl,
      );
    });

    test('returns LTR for English/Tamil locale keys', () {
      expect(UiLocaleResolver.textDirectionFor('US-en'), TextDirection.ltr);
      expect(UiLocaleResolver.textDirectionFor('IN-ta'), TextDirection.ltr);
    });

    test('returns LTR when locale key is malformed', () {
      // Malformed keys are not RTL — we can't infer direction safely.
      expect(UiLocaleResolver.textDirectionFor('not-a-key'), TextDirection.ltr);
    });
  });
}
