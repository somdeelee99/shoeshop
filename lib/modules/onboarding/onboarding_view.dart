import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'onboarding_view_model.dart';

class OnboardingView extends GetView<OnboardingViewModel> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      _page(
        image: AppAssets.onboarding1,
        title: controller.titles[0],
        subtitle: controller.subtitles[0],
        highlightIndex: 1,
      ),
      _page(
        image: AppAssets.onboarding2,
        title: controller.titles[1],
        subtitle: controller.subtitles[1],
        highlightIndex: 0,
      ),
      _page(
        image: AppAssets.onboarding1,
        title: controller.titles[2],
        subtitle: controller.subtitles[2],
        highlightIndex: 1,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F3F0),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: controller.skip,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: pages.length,
                onPageChanged: controller.onPageChanged,
                itemBuilder: (_, index) => pages[index],
              ),
            ),
            // Bottom bar
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 28.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // FIX 1: ບໍ່ຕ້ອງ Obx - SmoothPageIndicator ຟັງ pageController ເອງ
                  SmoothPageIndicator(
                    controller: controller.pageController,
                    count: pages.length,
                    effect: ExpandingDotsEffect(
                      dotWidth: 8.w,
                      dotHeight: 8.h,
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.primary.withOpacity(0.25),
                      expansionFactor: 3,
                    ),
                  ),
                  // FIX 2: Obx ຫຸ້ມສະເພາະ Icon ທີ່ໃຊ້ Rx
                  GestureDetector(
                    onTap: controller.next,
                    child: Container(
                      width: 56.r,
                      height: 56.r,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Obx(
                        () => Icon(
                          controller.currentPage.value ==
                                  OnboardingViewModel.pageCount - 1
                              ? Icons.check_rounded
                              : Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 24.r,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 200.ms)
                      .scale(begin: const Offset(0.8, 0.8)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _page({
    required String image,
    required String title,
    required String subtitle,
    int highlightIndex = -1,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(image, fit: BoxFit.contain)
                .animate()
                .fadeIn(duration: 450.ms)
                .scale(begin: const Offset(0.94, 0.94)),
          ),
          SizedBox(height: 12.h),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: highlightIndex >= 0
                  ? title.replaceFirst(RegExp(r'\S+\s*$'), '')
                  : title,
              style: AppTextStyles.h1.copyWith(height: 1.25),
              children: _titleChildren(title, highlightIndex),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyGrey.copyWith(fontSize: 15.sp),
          ),
          SizedBox(height: 36.h),
        ],
      ),
    );
  }

  List<InlineSpan> _titleChildren(String title, int highlightIndex) {
    if (highlightIndex < 0) return [];
    final match = RegExp(r'(\S+)\s*$').firstMatch(title);
    if (match == null) return [];
    final lastWord = match.group(0)!.trim();
    return [
      TextSpan(
        text: lastWord,
        style: const TextStyle(color: AppColors.primary),
      ),
    ];
  }
}
