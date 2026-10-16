import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoe_store/data/models/order_model.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/formatters.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/common_ui.dart';
import 'order_detail_view_model.dart';

/// Screen 14 — Order Detail: status timeline, address, items, total.
class OrderDetailView extends GetView<OrderDetailViewModel> {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const SimpleAppBar(title: 'Order Detail'),
      body: Obx(
        () {
          final order = controller.order.value;
          final statusColor = Color(order.status.colorValue);

          return ListView(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
            children: [
              // Header card
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(order.id,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            order.status.label,
                            style: TextStyle(
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w700,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Placed: ${Formatters.orderDate(order.placedAt)}',
                      style: TextStyle(
                          fontSize: 10.5.sp, color: AppColors.textSecondary),
                    ),
                    SizedBox(height: 14.h),
                    _timeline(order.timelineIndex),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Shipping address
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Shipping Address', style: AppTextStyles.title),
                    SizedBox(height: 8.h),
                    Text(order.shippingAddress.label,
                        style: TextStyle(
                            fontSize: 12.5.sp, fontWeight: FontWeight.w700)),
                    SizedBox(height: 2.h),
                    Text(
                      '${order.shippingAddress.street}, '
                      '${order.shippingAddress.city}',
                      style: TextStyle(
                          fontSize: 11.5.sp, color: AppColors.textSecondary),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      order.shippingAddress.phone,
                      style: TextStyle(
                          fontSize: 11.5.sp, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Items
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Items (${order.items.length})',
                        style: AppTextStyles.title),
                    SizedBox(height: 10.h),
                    for (final item in order.items) ...[
                      Row(
                        children: [
                          AppCachedImage(
                            url: item.product.imageUrl,
                            width: 56.w,
                            height: 56.w,
                            radius: 10,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.product.name,
                                    style: TextStyle(
                                        fontSize: 12.5.sp,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 2.h),
                                Text(
                                  '${item.product.brand} | '
                                  'Size ${item.size.toStringAsFixed(0)}',
                                  style: TextStyle(
                                      fontSize: 10.5.sp,
                                      color: AppColors.textSecondary),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  '${Formatters.price(item.product.price)} x '
                                  '${item.quantity}',
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            Formatters.price(item.lineTotal),
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: AppTextStyles.title),
                        Text(
                          Formatters.price(order.total),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // Reorder / help
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.toNamed('/chat'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        minimumSize: Size(double.infinity, 46.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text('Need Help?',
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed('/home'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 46.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text('Buy Again',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _timeline(int currentIndex) {
    final labels = controller.timelineLabels;
    return Row(
      children: [
        for (int i = 0; i < labels.length; i++) ...[
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 22.r,
                  height: 22.r,
                  decoration: BoxDecoration(
                    color: i <= currentIndex
                        ? AppColors.primary
                        : AppColors.lightGrey,
                    shape: BoxShape.circle,
                  ),
                  child: i <= currentIndex
                      ? Icon(Icons.check_rounded,
                          size: 13.r, color: Colors.white)
                      : null,
                ),
                SizedBox(height: 4.h),
                Text(
                  labels[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    fontWeight: FontWeight.w600,
                    color: i <= currentIndex
                        ? AppColors.textPrimary
                        : AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          if (i < labels.length - 1)
            Expanded(
              child: Container(
                height: 2,
                margin: EdgeInsets.only(bottom: 18.h),
                color: i < currentIndex ? AppColors.primary : AppColors.border,
              ),
            ),
        ],
      ],
    );
  }
}
