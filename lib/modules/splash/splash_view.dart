import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'splash_view_model.dart';

/// Screen 1 — Splash: dark hero shoe with neon red glow + brand lockup.
class SplashView extends GetView<SplashViewModel> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Hero shoe image
          Image.asset(AppAssets.splashShoe, fit: BoxFit.cover)
              .animate()
              .fadeIn(duration: 700.ms)
              .scale(begin: const Offset(1.06, 1.06), end: const Offset(1, 1)),

          // Dark gradient for text legibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.55),
                  Colors.transparent,
                  Colors.black.withOpacity(0.35),
                  Colors.black.withOpacity(0.85),
                ],
                stops: const [0, 0.28, 0.55, 1],
              ),
            ),
          ),

          // Skip
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Obx(
                () => controller.showSkip.value
                    ? TextButton(
                        onPressed: controller.skip,
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ).animate().fadeIn(delay: 400.ms)
                    : const SizedBox.shrink(),
              ),
            ),
          ),

          // Brand lockup
          Positioned(
            left: 0,
            right: 0,
            bottom: 120.h,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'SHOE ',
                    style: AppTextStyles.splash.copyWith(
                      letterSpacing: 2,
                      fontSize: 38.sp,
                    ),
                    children: [
                      TextSpan(
                        text: 'STORE',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 38.sp,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms)
                    .slideY(begin: 0.25, end: 0),
                SizedBox(height: 10.h),
                Text(
                  'Step Your Style',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ).animate().fadeIn(delay: 550.ms, duration: 600.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
