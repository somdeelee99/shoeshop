import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/cached_image.dart';
import 'profile_view_model.dart';

/// Screen 16 — Profile: avatar header + account menu.
class ProfileView extends GetView<ProfileViewModel> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: controller.openSettings,
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          SizedBox(height: 8.h),
          // Avatar + name
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: AppCachedImage(
                        url: controller.avatar,
                        width: 96.r,
                        height: 96.r,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: controller.openEditProfile,
                        child: Container(
                          padding: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.edit_rounded,
                              size: 12.r, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(controller.userName, style: AppTextStyles.h3),
                SizedBox(height: 4.h),
                Text(controller.email, style: AppTextStyles.caption),
                SizedBox(height: 2.h),
                Text(controller.memberSince,
                    style: AppTextStyles.small
                        .copyWith(color: AppColors.textHint)),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          // Menu
          _menu(),
          SizedBox(height: 18.h),
          // Sign out
          TextButton(
            onPressed: controller.logout,
            child: Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 4),
    );
  }

  Widget _menu() {
    final items = [
      (Icons.receipt_long_rounded, 'My Orders', controller.openOrders),
      (Icons.location_on_outlined, 'My Addresses', controller.openAddresses),
      (Icons.favorite_border_rounded, 'My Wishlist', controller.openWishlist),
      (
        Icons.credit_card_rounded,
        'Payment Methods',
        controller.openPaymentMethods
      ),
      (
        Icons.notifications_none_rounded,
        'Notifications',
        controller.openNotifications
      ),
      (Icons.settings_outlined, 'Settings', controller.openSettings),
      (Icons.help_outline_rounded, 'Help & Support', controller.openHelp),
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          for (final (icon, label, onTap) in items)
            Column(
              children: [
                InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    child: Row(
                      children: [
                        Icon(icon, size: 22.r, color: AppColors.textSecondary),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Text(label,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                        ),
                        if (label == 'Notifications')
                          Container(
                            padding: EdgeInsets.all(5.r),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text('3',
                                style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white)),
                          ),
                        SizedBox(width: 6.w),
                        Icon(Icons.chevron_right_rounded,
                            size: 22.r, color: AppColors.textHint),
                      ],
                    ),
                  ),
                ),
                if (label != items.last.$2)
                  Divider(height: 1, color: AppColors.divider),
              ],
            ),
        ],
      ),
    );
  }
}
