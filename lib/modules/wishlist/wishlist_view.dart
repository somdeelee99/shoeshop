import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/common_ui.dart';
import '../../widgets/product_card.dart';
import 'wishlist_view_model.dart';

/// Screen 15 — Wishlist: saved products with heart toggle.
class WishlistView extends GetView<WishlistViewModel> {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: SimpleAppBar(
        title: 'My Wishlist',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Obx(
        () => controller.items.isEmpty
            ? const EmptyState(
                icon: Icons.favorite_border_rounded,
                title: 'Your wishlist is empty',
                subtitle: 'Tap the heart on any product to save it.',
              )
            : ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                itemCount: controller.items.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, index) {
                  final item = controller.items[index];
                  return ProductListTile(
                    product: item.product,
                    trailing: GestureDetector(
                      onTap: () => controller.remove(item),
                      child: Icon(
                        Icons.favorite_rounded,
                        size: 22.r,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
