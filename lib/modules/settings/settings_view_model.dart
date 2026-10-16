import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/storage_service.dart';

/// Settings state: language, currency, notifications toggles, dark mode.
class SettingsViewModel extends GetxController {
  final RxString language = 'English'.obs;
  final RxString currency = 'USD (\$)'.obs;
  final RxBool pushEnabled = true.obs;
  final RxBool emailEnabled = true.obs;
  final RxBool darkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    language.value =
        StorageService.getString(AppConstants.keyLanguage, fallback: 'English');
    currency.value = StorageService.getString(AppConstants.keyCurrency,
        fallback: 'USD (\$)');
    pushEnabled.value =
        StorageService.getBool(AppConstants.keyPushEnabled, fallback: true);
    emailEnabled.value =
        StorageService.getBool(AppConstants.keyEmailEnabled, fallback: true);
    darkMode.value = StorageService.isDarkMode;
  }

  void setLanguage(String value) {
    language.value = value;
    StorageService.setString(AppConstants.keyLanguage, value);
  }

  void setCurrency(String value) {
    currency.value = value;
    StorageService.setString(AppConstants.keyCurrency, value);
  }

  void togglePush(bool value) {
    pushEnabled.value = value;
    StorageService.setBool(AppConstants.keyPushEnabled, value);
  }

  void toggleEmail(bool value) {
    emailEnabled.value = value;
    StorageService.setBool(AppConstants.keyEmailEnabled, value);
  }

  void toggleDarkMode(bool value) {
    darkMode.value = value;
    StorageService.setDarkMode(value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  void openPrivacyPolicy() {
    Get.snackbar('Privacy Policy', 'Open your privacy policy URL here.',
        snackPosition: SnackPosition.BOTTOM);
  }

  void openTerms() {
    Get.snackbar('Terms of Service', 'Open your terms URL here.',
        snackPosition: SnackPosition.BOTTOM);
  }
}
