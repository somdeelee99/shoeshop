import 'package:get/get.dart';

import '../../core/constants/app_constants.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/storage_service.dart';

/// Splash logic: decide between onboarding, login or home.
class SplashViewModel extends GetxController {
  final RxBool showSkip = true.obs;

  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future<void>.delayed(
      const Duration(milliseconds: AppConstants.splashDurationMs),
    );
    _next();
  }

  void _next() {
    if (!StorageService.isOnboardingDone) {
      // Get.offAllNamed(AppRoutes.onboarding);
      Get.offAllNamed(AppRoutes.home);
      return;
    }
    // Demo mode: always land on home for quick review of the UI.
    // In production check the auth token here instead.
    Get.offAllNamed(AppRoutes.home);
  }

  void skip() {
    Get.offAllNamed(AppRoutes.onboarding);
  }
}
