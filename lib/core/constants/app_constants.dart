/// App-wide constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'Shoe Store';
  static const String tagline = 'Step Your Style';

  static const Duration animationFast = Duration(milliseconds: 220);
  static const Duration animationMedium = Duration(milliseconds: 380);
  static const Duration animationSlow = Duration(milliseconds: 650);

  static const int splashDurationMs = 2600;

  static const String currencySymbol = r'$';
  static const String defaultLocale = 'en_US';

  // Storage keys
  static const String keyToken = 'auth_token';
  static const String keyUser = 'current_user';
  static const String keyOnboardingDone = 'onboarding_done';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyCurrency = 'currency';
  static const String keyPushEnabled = 'push_notifications';
  static const String keyEmailEnabled = 'email_notifications';
  static const String keyFcmToken = 'fcm_token';

  // Pagination
  static const int pageSize = 20;
}
