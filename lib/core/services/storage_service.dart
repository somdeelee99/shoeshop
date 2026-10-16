import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

/// Local persistence wrapper: SharedPreferences (light data) +
/// FlutterSecureStorage (tokens / secrets).
class StorageService {
  StorageService._();

  static late final SharedPreferences _prefs;
  static const FlutterSecureStorage _secure = FlutterSecureStorage();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ---------- SharedPreferences ----------
  static Future<bool> setBool(String key, bool value) =>
      _prefs.setBool(key, value);
  static bool getBool(String key, {bool fallback = false}) =>
      _prefs.getBool(key) ?? fallback;

  static Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
  static String getString(String key, {String fallback = ''}) =>
      _prefs.getString(key) ?? fallback;

  static Future<bool> setInt(String key, int value) =>
      _prefs.setInt(key, value);
  static int getInt(String key, {int fallback = 0}) =>
      _prefs.getInt(key) ?? fallback;

  static Future<bool> remove(String key) => _prefs.remove(key);

  // ---------- Secure storage ----------
  static Future<void> setToken(String token) =>
      _secure.write(key: AppConstants.keyToken, value: token);

  static Future<String?> getToken() => _secure.read(key: AppConstants.keyToken);

  static Future<void> deleteToken() =>
      _secure.delete(key: AppConstants.keyToken);

  static Future<void> setSecure(String key, String value) =>
      _secure.write(key: key, value: value);

  static Future<String?> getSecure(String key) => _secure.read(key: key);

  // ---------- Convenience ----------
  static bool get isOnboardingDone => getBool(AppConstants.keyOnboardingDone);

  static Future<void> completeOnboarding() =>
      setBool(AppConstants.keyOnboardingDone, true);

  static bool get isDarkMode =>
      getBool(AppConstants.keyThemeMode, fallback: false);

  static Future<void> setDarkMode(bool value) =>
      setBool(AppConstants.keyThemeMode, value);

  static Future<void> clearSession() async {
    await deleteToken();
    await remove(AppConstants.keyUser);
  }
}
