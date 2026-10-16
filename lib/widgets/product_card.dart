import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';
import '../core/constants/app_text_styles.dart';
import '../core/routes/app_routes.dart';
import '../core/utils/formatters.dart';
import '../data/models/product_model.dart';
import '../data/repositories/cart_repository.dart';
import 'cached_image.dart';
import 'rating_stars.dart';

/// Grid card used in Home flash sale, Product list & search results.
class ProductCard extends StatelessWidget {
  final ProductModel product;
  final double width;

  const ProductCard({super.key, required this.product, this.width = 160});

  @override
  Widget build(BuildContext context) {
    final cartRepo = Get.find<CartRepository>();

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.productDetails, arguments: product),
      child: Container(
        width: width.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.rLg),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image + badges
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppDimens.rLg),
                  ),
                  child: AppCachedImage(
                    url: product.imageUrl,
                    width: double.infinity,
                    height: 110.h,
                  ),
                ),
                if (product.discountPercent > 0)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        Formatters.discount(product.discountPercent),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 6.h,
                  right: 6.w,
                  child: Obx(() {
                    final wished = cartRepo.isWishlisted(product);
                    return InkWell(
                      onTap: () => cartRepo.toggleWishlist(product),
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          wished ? Icons.favorite : Icons.favorite_border,
                          size: 15.r,
                          color:
                              wished ? AppColors.primary : AppColors.textHint,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.captionBold.copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        Formatters.price(product.price),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (product.oldPrice != null) ...[
                        SizedBox(width: 5.w),
                        Text(
                          Formatters.price(product.oldPrice!),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.textHint,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  RatingStars(
                    rating: product.rating,
                    reviewCount: product.reviewCount,
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

/// Horizontal list card used in Wishlist / Cart.
class ProductListTile extends StatelessWidget {
  final ProductModel product;
  final Widget? trailing;
  final String? subtitle;
  final VoidCallback? onTap;

  const ProductListTile({
    super.key,
    required this.product,
    this.trailing,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () => Get.toNamed(AppRoutes.productDetails, arguments: product),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.rLg),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            AppCachedImage(
              url: product.imageUrl,
              width: 72.w,
              height: 72.w,
              radius: AppDimens.rMd,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    subtitle ?? product.brand,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    Formatters.price(product.price),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
