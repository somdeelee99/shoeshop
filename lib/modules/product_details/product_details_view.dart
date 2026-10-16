import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../widgets/app_button.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/common_ui.dart';
import '../../widgets/rating_stars.dart';
import 'product_details_view_model.dart';

/// Screen 9 — Product Details: gallery, price, size & color, add to cart.
class ProductDetailsView extends GetView<ProductDetailsViewModel> {
  // final product = Rxn<ProductModel>();
  ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = controller;
    final p = vm.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: Row(
                children: [
                  RoundIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    size: 38,
                    onTap: Get.back,
                  ),
                  const Spacer(),
                  Obx(
                    () => RoundIconButton(
                      icon: vm.isWishlisted.value
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 38,
                      iconColor: vm.isWishlisted.value
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      onTap: vm.toggleWishlist,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  RoundIconButton(
                    icon: Icons.shopping_cart_outlined,
                    size: 38,
                    onTap: vm.openCart,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gallery
                    SizedBox(
                      height: 240.h,
                      child: PageView.builder(
                        controller: vm.pageController,
                        itemCount: p.images.isEmpty ? 1 : p.images.length,
                        onPageChanged: vm.onImageChanged,
                        itemBuilder: (_, i) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: AppCachedImage(
                            url: p.images.isEmpty ? p.imageUrl : p.images[i],
                            radius: 16,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Thumbnails
                    SizedBox(
                      height: 56.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        itemCount: p.images.isEmpty
                            ? 1
                            : (p.images.length > 4 ? 4 : p.images.length),
                        separatorBuilder: (_, __) => SizedBox(width: 10.w),
                        itemBuilder: (_, i) => Obx(() {
                          final selected = vm.currentImage.value == i;
                          return GestureDetector(
                            onTap: () {
                              vm.pageController.animateToPage(
                                i,
                                duration: const Duration(milliseconds: 280),
                                curve: Curves.easeOut,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: selected
                                      ? AppColors.primary
                                      : AppColors.border,
                                  width: selected ? 1.8 : 1,
                                ),
                              ),
                              child: AppCachedImage(
                                url:
                                    p.images.isEmpty ? p.imageUrl : p.images[i],
                                width: 56.w,
                                height: 56.w,
                                radius: 10,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + share
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(p.name, style: AppTextStyles.h2),
                              ),
                              Icon(Icons.share_outlined,
                                  size: 20.r, color: AppColors.textSecondary),
                            ],
                          ),
                          SizedBox(height: 6.h),
                          RatingStars(
                            rating: p.rating,
                            reviewCount: p.reviewCount,
                          ),
                          SizedBox(height: 12.h),
                          // Price row
                          Row(
                            children: [
                              Text(
                                Formatters.price(p.price),
                                style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              if (p.oldPrice != null) ...[
                                SizedBox(width: 8.w),
                                Text(
                                  Formatters.price(p.oldPrice!),
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColors.textHint,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Text(
                                    Formatters.discount(p.discountPercent),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Text(
                            p.description,
                            style:
                                AppTextStyles.bodyGrey.copyWith(height: 1.55),
                          ),
                          SizedBox(height: 18.h),

                          // Size
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Size (US)', style: AppTextStyles.title),
                              Text('Size Guide', style: AppTextStyles.link),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Obx(
                            () => Wrap(
                              spacing: 10.w,
                              runSpacing: 10.h,
                              children: [
                                for (final size in p.sizes)
                                  GestureDetector(
                                    onTap: () => vm.selectSize(size),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 180),
                                      width: 46.r,
                                      height: 40.r,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: vm.selectedSize.value == size
                                            ? AppColors.primary
                                            : AppColors.lightGrey,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Text(
                                        size.toStringAsFixed(0),
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700,
                                          color: vm.selectedSize.value == size
                                              ? Colors.white
                                              : AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 18.h),

                          // Color
                          Text('Color', style: AppTextStyles.title),
                          SizedBox(height: 10.h),
                          Obx(
                            () => Wrap(
                              spacing: 10.w,
                              children: [
                                for (int i = 0; i < p.colors.length; i++)
                                  GestureDetector(
                                    onTap: () => vm.selectColor(i),
                                    child: Container(
                                      width: 34.r,
                                      height: 34.r,
                                      decoration: BoxDecoration(
                                        color: Color(p.colors[i]),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: vm.selectedColor.value == i
                                              ? AppColors.primary
                                              : AppColors.border,
                                          width: vm.selectedColor.value == i
                                              ? 2.4
                                              : 1,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bottom action bar
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Add to Cart',
                      icon: Icons.shopping_cart_outlined,
                      onPressed: vm.addToCart,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppButton(
                      label: 'Buy Now',
                      color: AppColors.dark,
                      onPressed: vm.buyNow,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
