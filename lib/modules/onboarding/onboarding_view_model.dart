import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../core/services/storage_service.dart';

/// Onboarding carousel state (3 pages in the design; 2 art boards).
class OnboardingViewModel extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  static const int pageCount = 3;

  final List<String> titles = [
    'Find Your Style',
    'Premium Quality\nTrendy Collection',
    'Fast Delivery\nTo Your Door',
  ];

  final List<String> subtitles = [
    'Discover the latest shoes for every occasion',
    'Best shoes for your better tomorrow',
    'Free shipping on orders over \$100 in Laos',
  ];

  void onPageChanged(int index) => currentPage.value = index;

  void next() {
    if (currentPage.value < pageCount - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    } else {
      finish();
    }
  }

  void skip() => finish();

  Future<void> finish() async {
    await StorageService.completeOnboarding();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
