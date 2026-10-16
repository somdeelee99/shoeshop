import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/misc_models.dart';
import '../../widgets/common_ui.dart';
import 'notifications_view_model.dart';

/// Screen 19 — Notifications: order & promo updates.
class NotificationsView extends GetView<NotificationsViewModel> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const SimpleAppBar(title: 'Notifications'),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.notifications.isEmpty
                ? const EmptyState(
                    icon: Icons.notifications_none_rounded,
                    title: 'No notifications',
                    subtitle: 'You are all caught up!',
                  )
                : ListView.separated(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                    itemCount: controller.notifications.length,
                    separatorBuilder: (_, __) => SizedBox(height: 10.h),
                    itemBuilder: (_, index) =>
                        _tile(controller.notifications[index]),
                  ),
      ),
    );
  }

  Widget _tile(AppNotificationModel notification) {
    final (icon, color, bg) = switch (notification.type) {
      'order' => (
          Icons.local_shipping_rounded,
          const Color(0xFFF97316),
          const Color(0xFFFFF1E5)
        ),
      'promo' => (
          Icons.card_giftcard_rounded,
          const Color(0xFFE63B2E),
          const Color(0xFFFFEDEB)
        ),
      _ => (
          Icons.campaign_rounded,
          const Color(0xFF22C55E),
          const Color(0xFFE9F9EF)
        ),
    };

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration:
                BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Icon(icon, size: 20.r, color: color),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title,
                    style: TextStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.w700)),
                SizedBox(height: 3.h),
                Text(notification.body,
                    style: TextStyle(
                        fontSize: 11.5.sp,
                        color: AppColors.textSecondary,
                        height: 1.4)),
                SizedBox(height: 4.h),
                Text(
                  Formatters.timeAgo(notification.time),
                  style: TextStyle(
                      fontSize: 10.sp, color: AppColors.textHint),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
