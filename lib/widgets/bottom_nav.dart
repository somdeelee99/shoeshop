import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/constants/app_colors.dart';
import '../core/routes/app_routes.dart';
import '../data/repositories/cart_repository.dart';

/// Persistent bottom navigation bar (Home / Category / Cart / Orders / Profile).
class BottomNav extends StatelessWidget {
  final int currentIndex;

  const BottomNav({super.key, required this.currentIndex});

  void _go(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed(AppRoutes.home);
        break;
      case 1:
        Get.toNamed(AppRoutes.categories);
        break;
      case 2:
        Get.toNamed(AppRoutes.cart);
        break;
      case 3:
        Get.toNamed(AppRoutes.orders);
        break;
      case 4:
        Get.toNamed(AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartRepo = Get.find<CartRepository>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item(0, Icons.home_rounded, 'Home', currentIndex == 0, _go),
              _item(1, Icons.grid_view_rounded, 'Category', currentIndex == 1,
                  _go),
              Obx(() => _item(
                    2,
                    Icons.shopping_cart_rounded,
                    'Cart',
                    currentIndex == 2,
                    _go,
                    badge: cartRepo.count,
                  )),
              _item(3, Icons.receipt_long_rounded, 'Orders', currentIndex == 3,
                  _go),
              _item(4, Icons.person_rounded, 'Profile', currentIndex == 4, _go),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(
    int index,
    IconData icon,
    String label,
    bool selected,
    ValueChanged<int> onTap, {
    int badge = 0,
  }) {
    final color = selected ? AppColors.primary : AppColors.textHint;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: SizedBox(
        width: 62.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 24.r, color: color),
                if (badge > 0)
                  Positioned(
                    right: -6.w,
                    top: -4.h,
                    child: Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badge > 9 ? '9+' : '$badge',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 3.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
