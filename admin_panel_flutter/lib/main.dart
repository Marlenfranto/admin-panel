import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import 'core/localization/locale_providers.dart';
import 'core/localization/ui_locale_resolver.dart';
import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'l10n/generated/app_localizations.dart';
import 'src/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  // Pre-create the container so we can initialize the session manager
  // before the first frame. This loads any stored session from disk
  // so the router's redirect can immediately check isSignedIn instead
  // of briefly showing the login screen.
  final container = ProviderContainer();
  final sessionManager = container.read(sessionManagerProvider);
  await sessionManager.initialize();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth        = ref.watch(authProvider);
    final router      = ref.watch(routerProvider);
    final localeKey   = ref.watch(currentLocaleProvider);
    final activeLocale = UiLocaleResolver.fromLocaleKey(localeKey);

    // While AuthNotifier is fetching AppUser after a restored session,
    // show a branded splash instead of briefly flashing the login screen.
    if (auth.isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        locale: activeLocale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const _SplashScreen(),
      );
    }

    return MaterialApp.router(
      title: 'FireSafeX',
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      locale: activeLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}

/// Minimal branded splash shown while the stored session is validated.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
