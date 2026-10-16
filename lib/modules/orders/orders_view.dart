import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/formatters.dart';
import '../../data/models/order_model.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/common_ui.dart';
import 'orders_view_model.dart';

/// Screen 13 — My Orders: status tabs + order cards.
class OrdersView extends GetView<OrdersViewModel> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: SimpleAppBar(
        title: 'My Orders',
        showBack: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            // Tabs
            SizedBox(
              height: 42.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.tabs.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (_, index) {
                  final tab = controller.tabs[index];
                  final selected = controller.selectedTab.value == tab;
                  return GestureDetector(
                    onTap: () => controller.selectTab(tab),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color:
                              selected ? AppColors.primary : AppColors.border,
                        ),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w700,
                          color:
                              selected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.orders.isEmpty
                      ? const EmptyState(
                          icon: Icons.receipt_long_rounded,
                          title: 'No orders yet',
                          subtitle: 'Your orders will appear here.',
                        )
                      : ListView.separated(
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                          itemCount: controller.orders.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12.h),
                          itemBuilder: (_, index) =>
                              _orderCard(controller.orders[index]),
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 3),
    );
  }

  Widget _orderCard(OrderModel order) {
    final color = Color(order.status.colorValue);
    return GestureDetector(
      onTap: () => controller.openOrder(order),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.id,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    order.status.label,
                    style: TextStyle(
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w700,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Formatters.orderDate(order.placedAt),
                style: TextStyle(
                    fontSize: 10.5.sp, color: AppColors.textSecondary),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                AppCachedImage(
                  url: order.items.first.product.imageUrl,
                  width: 48.w,
                  height: 48.w,
                  radius: 8,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.items.first.product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${order.itemCount} item${order.itemCount > 1 ? 's' : ''}',
                        style: TextStyle(
                            fontSize: 10.5.sp, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          fontSize: 10.sp, color: AppColors.textSecondary),
                    ),
                    Text(
                      Formatters.price(order.total),
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
