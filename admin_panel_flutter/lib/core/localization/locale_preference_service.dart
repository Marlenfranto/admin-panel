import 'package:shared_preferences/shared_preferences.dart';

/// Local persistence for the user's preferred locale key. Server-side
/// `AppUser.preferredLocaleKey` is authoritative once the user is logged in;
/// this layer covers the pre-login boot path and offline state.
class LocalePreferenceService {
  static const String _key = 'preferred_locale_key';

  static Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  static Future<void> write(String localeKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, localeKey);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
