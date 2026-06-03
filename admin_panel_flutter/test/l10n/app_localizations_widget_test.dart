import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:admin_panel_flutter/l10n/generated/app_localizations.dart';

/// Helper: wraps [child] in a minimal [MaterialApp] with the project's
/// localizations delegates and forces it to render in [locale]. Verifies
/// (a) the right ARB lookup happens and (b) the ambient Directionality.
Widget _wrap(Widget child, Locale locale) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

class _Probe extends StatelessWidget {
  const _Probe();
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Column(
      children: [
        Text(t.navMyModules, key: const Key('modules')),
        Text(t.statusCompleted, key: const Key('completed')),
        Text(t.modulesSummaryAssigned(2), key: const Key('plural-2')),
        Text(t.modulesSummaryAssigned(1), key: const Key('plural-1')),
        Text(t.modulesSummaryAssigned(0), key: const Key('plural-0')),
        Text(
          'dir:${Directionality.of(context).name}',
          key: const Key('direction'),
        ),
      ],
    );
  }
}

void main() {
  group('AppLocalizations — English (en)', () {
    testWidgets('renders English strings + LTR direction',
        (tester) async {
      await tester.pumpWidget(_wrap(const _Probe(), const Locale('en')));
      await tester.pumpAndSettle();

      expect(find.text('My Modules'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
      expect(find.text('2 modules assigned'), findsOneWidget);
      expect(find.text('1 module assigned'), findsOneWidget);
      expect(find.text('No modules assigned'), findsOneWidget);
      expect(
        (tester.widget(find.byKey(const Key('direction'))) as Text).data,
        'dir:ltr',
      );
    });
  });

  group('AppLocalizations — Arabic (ar)', () {
    testWidgets('renders Arabic strings + RTL direction', (tester) async {
      await tester.pumpWidget(_wrap(const _Probe(), const Locale('ar')));
      await tester.pumpAndSettle();

      // Spot-check translated strings.
      expect(find.text('وحداتي'), findsOneWidget);
      expect(find.text('مكتمل'), findsOneWidget);

      // Arabic plural forms — `one` rule resolves to "وحدة واحدة مُخصّصة".
      expect(find.text('وحدة واحدة مُخصّصة'), findsOneWidget);

      expect(
        (tester.widget(find.byKey(const Key('direction'))) as Text).data,
        'dir:rtl',
      );
    });
  });

  group('AppLocalizations — Tamil (ta)', () {
    testWidgets('renders Tamil strings + LTR direction', (tester) async {
      await tester.pumpWidget(_wrap(const _Probe(), const Locale('ta')));
      await tester.pumpAndSettle();

      expect(find.text('என் தொகுதிகள்'), findsOneWidget);
      expect(find.text('நிறைவடைந்தது'), findsOneWidget);
      expect(
        (tester.widget(find.byKey(const Key('direction'))) as Text).data,
        'dir:ltr',
      );
    });
  });

  group('AppLocalizations — fallback', () {
    testWidgets('unsupported locale still resolves to one of the supported '
        'locales (Flutter basicLocaleListResolution picks the first match)',
        (tester) async {
      await tester.pumpWidget(
        _wrap(const _Probe(), const Locale('xx')),
      );
      await tester.pumpAndSettle();

      // We don't assert *which* supported locale wins — that depends on
      // Flutter's resolution policy and the order of supportedLocales —
      // just that some localized "My Modules" surface renders.
      final modulesLabel =
          (tester.widget(find.byKey(const Key('modules'))) as Text).data!;
      expect(modulesLabel.isNotEmpty, isTrue);
      // Should be one of our three known translations.
      expect(
        ['My Modules', 'وحداتي', 'என் தொகுதிகள்'],
        contains(modulesLabel),
      );
    });
  });
}
