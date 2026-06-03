import 'package:admin_panel_client/admin_panel_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../src/providers.dart';
import 'locale_key.dart';
import 'locale_preference_service.dart';

/// The list of locales the user's org has enabled. Returns empty until login.
final supportedLocalesProvider =
    FutureProvider<List<LocaleConfig>>((ref) async {
  final auth = ref.watch(authProvider);
  if (!auth.isSignedIn) return [];
  return ref.watch(clientProvider).user.getMyLocales();
});

/// The currently active locale key. Resolution order on init:
///   1. `AppUser.preferredLocaleKey` (server-side preference)
///   2. SharedPreferences (offline cache)
///   3. System default (`US-en`)
final currentLocaleProvider =
    StateNotifierProvider<CurrentLocaleNotifier, String>((ref) {
  return CurrentLocaleNotifier(ref);
});

class CurrentLocaleNotifier extends StateNotifier<String> {
  CurrentLocaleNotifier(this.ref) : super(LocaleKey.systemDefault) {
    _bootstrap();
    // React to login: when AppUser arrives, sync.
    ref.listen<AuthState>(authProvider, (prev, next) {
      final key = next.appUser?.preferredLocaleKey;
      if (key != null && LocaleKey.isValid(key) && key != state) {
        state = key;
      }
    });
  }

  final Ref ref;

  Future<void> _bootstrap() async {
    final stored = await LocalePreferenceService.read();
    if (stored != null && LocaleKey.isValid(stored)) {
      state = stored;
    }
    // If logged in already, prefer server value.
    final auth = ref.read(authProvider);
    final key = auth.appUser?.preferredLocaleKey;
    if (key != null && LocaleKey.isValid(key)) {
      state = key;
    }
  }

  /// Updates the active locale, persists locally, and syncs to the server.
  /// Throws if the server rejects the value (e.g. not configured on the org).
  Future<void> set(String localeKey) async {
    if (!LocaleKey.isValid(localeKey)) {
      throw FormatException('Invalid locale key: "$localeKey"');
    }
    await LocalePreferenceService.write(localeKey);
    state = localeKey;
    final auth = ref.read(authProvider);
    if (auth.isSignedIn) {
      await ref.read(clientProvider).user.setPreferredLocale(localeKey);
    }
  }
}
