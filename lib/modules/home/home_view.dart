import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/routes/app_routes.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/product_card.dart';
import 'home_view_model.dart';

/// Screen 5 — Home: location bar, search, banner carousel, shortcuts,
/// flash sale grid and bottom navigation.
class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: Lottie.asset(
                    AppAssets.loader,
                    width: 90.r,
                    height: 90.r,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: controller.load,
                  color: AppColors.primary,
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 16.h),
                    children: [
                      _header(),
                      _searchBar(),
                      SizedBox(height: 14.h),
                      _bannerCarousel(),
                      SizedBox(height: 18.h),
                      _shortcutRow(),
                      SizedBox(height: 20.h),
                      _flashSaleHeader(),
                      SizedBox(height: 12.h),
                      _flashSaleGrid(),
                      SizedBox(height: 20.h),
                      _bannerCarousel(second: true),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 0),
    );
  }

  // ---------- Header ----------
  Widget _header() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: Row(
        children: [
          const Icon(Icons.location_on_rounded,
              color: AppColors.primary, size: 20),
          SizedBox(width: 4.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Vientiane, Laos',
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700)),
              Icon(Icons.keyboard_arrow_down_rounded,
                  size: 16.r, color: AppColors.textSecondary),
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              GestureDetector(
                onTap: controller.openNotifications,
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: const Icon(Icons.notifications_none_rounded, size: 24),
                ),
              ),
              if (controller.unreadNotifications > 0)
                Positioned(
                  right: 6.w,
                  top: 6.h,
                  child: Container(
                    width: 9.r,
                    height: 9.r,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------- Search ----------
  Widget _searchBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: controller.openSearch,
              child: Container(
                height: 46.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded,
                        size: 20, color: AppColors.textHint),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Search shoes, brands...',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13.sp, color: AppColors.textHint),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.filter),
            child: Container(
              height: 46.h,
              width: 46.h,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child:
                  const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Banner ----------
  Widget _bannerCarousel({bool second = false}) {
    final pageController = PageController(viewportFraction: 0.92);
    final banners = controller.banners;

    return Column(
      children: [
        SizedBox(
          height: 150.h,
          child: PageView.builder(
            controller: pageController,
            itemCount: banners.length,
            onPageChanged: controller.onBannerChanged,
            itemBuilder: (_, i) {
              final b = banners[i];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                          imageUrl: b.imageUrl, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withOpacity(0.55),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              b.title,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              b.subtitle,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.w, vertical: 7.h),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                b.buttonText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        SmoothPageIndicator(
          controller: pageController,
          count: banners.length,
          effect: ExpandingDotsEffect(
            dotWidth: 6.w,
            dotHeight: 6.h,
            activeDotColor: AppColors.primary,
            dotColor: AppColors.primary.withOpacity(0.25),
            expansionFactor: 3,
          ),
        ),
      ],
    );
  }

  // ---------- Shortcuts ----------
  Widget _shortcutRow() {
    final items = [
      (Icons.male_rounded, 'Men'),
      (Icons.female_rounded, 'Women'),
      (Icons.child_care_rounded, 'Kids'),
      (Icons.percent_rounded, 'Sale'),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final (icon, label) in items)
            GestureDetector(
              onTap: () => controller.openCategory(label),
              child: Column(
                children: [
                  Container(
                    width: 58.r,
                    height: 58.r,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Icon(icon,
                        size: 26.r,
                        color: label == 'Sale'
                            ? AppColors.primary
                            : AppColors.textPrimary),
                  ),
                  SizedBox(height: 6.h),
                  Text(label,
                      style: TextStyle(
                          fontSize: 11.sp, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ---------- Flash sale ----------
  Widget _flashSaleHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Flash Sale', style: AppTextStyles.h3),
          GestureDetector(
            onTap: controller.seeAllFlashSale,
            child: Text(
              'See All',
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _flashSaleGrid() {
    final items = controller.flashSale.take(4).toList();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Wrap(
        spacing: 10.w,
        runSpacing: 12.h,
        children: [
          for (final product in items)
            ProductCard(product: product, width: 168),
        ],
      ),
    );
  }
}
