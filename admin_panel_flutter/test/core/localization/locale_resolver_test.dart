import 'package:flutter_test/flutter_test.dart';

import 'package:admin_panel_flutter/core/localization/locale_resolver.dart';

void main() {
  group('LocaleResolver.resolveChain', () {
    test('orders: requested → orgDefault → systemDefault, deduplicated', () {
      final chain = LocaleResolver.resolveChain(
        requested: 'AE-ar',
        orgDefault: 'UK-en',
      );
      expect(chain, ['AE-ar', 'UK-en', 'US-en']);
    });

    test('drops duplicate orgDefault when it equals requested', () {
      final chain = LocaleResolver.resolveChain(
        requested: 'US-en',
        orgDefault: 'US-en',
      );
      expect(chain, ['US-en']);
    });

    test('drops null/empty entries silently', () {
      final chain = LocaleResolver.resolveChain(
        requested: 'AE-ar',
        orgDefault: null,
      );
      expect(chain, ['AE-ar', 'US-en']);

      final chain2 = LocaleResolver.resolveChain(
        requested: 'AE-ar',
        orgDefault: '',
      );
      expect(chain2, ['AE-ar', 'US-en']);
    });

    test('always ends at system default if not already present', () {
      final chain = LocaleResolver.resolveChain(
        requested: 'IN-ta',
        orgDefault: 'UK-en',
      );
      expect(chain.last, 'US-en');
    });
  });

  group('LocaleResolver.firstMatch', () {
    test('returns the first item whose key matches the earliest chain step',
        () {
      final items = [
        (key: 'UK-en', value: 'British'),
        (key: 'AE-ar', value: 'Arabic'),
        (key: 'US-en', value: 'American'),
      ];
      final hit = LocaleResolver.firstMatch<({String key, String value})>(
        chain: ['AE-ar', 'US-en'],
        items: items,
        keyOf: (it) => it.key,
      );
      expect(hit?.value, 'Arabic');
    });

    test('walks chain in order — picks the earliest matching step', () {
      final items = [
        (key: 'US-en', value: 'American'),
        (key: 'UK-en', value: 'British'),
      ];
      // Both items would match somewhere in the chain. The chain order
      // determines the winner — UK-en is first.
      final hit = LocaleResolver.firstMatch<({String key, String value})>(
        chain: ['UK-en', 'US-en'],
        items: items,
        keyOf: (it) => it.key,
      );
      expect(hit?.value, 'British');
    });

    test('returns null when no item key intersects the chain', () {
      final items = [(key: 'FR-fr', value: 'French')];
      final hit = LocaleResolver.firstMatch<({String key, String value})>(
        chain: ['US-en', 'AE-ar'],
        items: items,
        keyOf: (it) => it.key,
      );
      expect(hit, isNull);
    });
  });
}
