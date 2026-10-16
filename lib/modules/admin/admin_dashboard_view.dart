import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'admin_view_model.dart';

/// Screen 24 — Admin Dashboard (responsive web/app layout):
/// sidebar navigation, KPI cards, sales bar chart, recent orders table.
class AdminDashboardView extends GetView<AdminViewModel> {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 720;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      drawer: isWide ? null : Drawer(child: _sidebar()),
      appBar: AppBar(
        title: const Text('Shoe Store Admin'),
        leading: isWide
            ? null
            : Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded)),
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CircleAvatar(
              radius: 16.r,
              backgroundImage: const NetworkImage(
                  'https://i.pravatar.cc/100?img=12'),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (isWide) SizedBox(width: 230.w, child: _sidebar()),
          Expanded(
            child: Obx(
              () => ListView(
                padding: EdgeInsets.all(20.w),
                children: [
                  Text(controller.navItems[controller.selectedNav.value],
                      style: AppTextStyles.h2),
                  SizedBox(height: 16.h),
                  _kpiRow(),
                  SizedBox(height: 18.h),
                  _salesChart(),
                  SizedBox(height: 18.h),
                  _recentOrdersTable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Sidebar ----------------
  Widget _sidebar() {
    return Container(
      color: Colors.white,
      child: Obx(
        () => Column(
          children: [
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Container(
                    width: 34.r,
                    height: 34.r,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: SvgPicture.asset(
                      AppAssets.logoMark,
                      width: 18.r,
                      height: 18.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text('Shoe Store',
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            for (int i = 0; i < controller.navItems.length; i++)
              _navItem(i),
          ],
        ),
      ),
    );
  }

  Widget _navItem(int index) {
    final selected = controller.selectedNav.value == index;
    final icons = [
      Icons.dashboard_rounded,
      Icons.inventory_2_rounded,
      Icons.receipt_long_rounded,
      Icons.people_rounded,
      Icons.warehouse_rounded,
      Icons.swap_horiz_rounded,
      Icons.settings_rounded,
    ];

    return GestureDetector(
      onTap: () => controller.selectNav(index),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Icon(icons[index],
                size: 19.r,
                color: selected ? Colors.white : AppColors.textSecondary),
            SizedBox(width: 10.w),
            Text(
              controller.navItems[index],
              style: TextStyle(
                fontSize: 12.5.sp,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- KPI ----------------
  Widget _kpiRow() {
    final stats = controller.stats;
    final cards = [
      (
        'Total Orders',
        '${stats['total_orders']}',
        Icons.shopping_bag_rounded,
        const Color(0xFFE8F1FE),
        const Color(0xFF3B82F6),
        '+${stats['orders_growth']}%'
      ),
      (
        'Total Sales',
        '\$${stats['total_sales']}',
        Icons.attach_money_rounded,
        const Color(0xFFE9F9EF),
        const Color(0xFF22C55E),
        '+${stats['sales_growth']}%'
      ),
      (
        'Total Products',
        '${stats['total_products']}',
        Icons.inventory_2_rounded,
        const Color(0xFFFFF1E5),
        const Color(0xFFF97316),
        '+${stats['products_growth']}%'
      ),
    ];

    return Wrap(
      spacing: 14.w,
      runSpacing: 14.h,
      children: [
        for (final (label, value, icon, bg, color, growth) in cards)
          Container(
            width: 240.w,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, size: 22.r, color: color),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label,
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.textSecondary)),
                      SizedBox(height: 3.h),
                      Text(value,
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800)),
                      SizedBox(height: 2.h),
                      Text(growth,
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.success)),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ---------------- Sales chart ----------------
  Widget _salesChart() {
    return Container(
      padding: EdgeInsets.all(18.w),
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
              Text('Sales Overview', style: AppTextStyles.title),
              const Spacer(),
              Text('See All',
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary)),
            ],
          ),
          SizedBox(height: 18.h),
          SizedBox(
            height: 170.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (final entry in controller.sales)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedContainer(
                        duration:
                            Duration(milliseconds: 400 + (entry['value'] as num).toInt() * 200),
                        width: 26.w,
                        height: (entry['value'] as num).toDouble() * 120.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.primary,
                              AppColors.primary.withOpacity(0.55),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(entry['day'] as String,
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColors.textSecondary)),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Recent orders ----------------
  Widget _recentOrdersTable() {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Orders', style: AppTextStyles.title),
          SizedBox(height: 12.h),
          // Header
          _tableRow(['Order ID', 'Customer', 'Amount', 'Status'],
              isHeader: true),
          const Divider(),
          for (final order in controller.recentOrders) ...[
            _tableRow([
              order['id'] as String,
              order['customer'] as String,
              '\$${order['amount']}',
              order['status'] as String,
            ]),
            SizedBox(height: 8.h),
          ],
        ],
      ),
    );
  }

  Widget _tableRow(List<String> cells, {bool isHeader = false}) {
    final widths = [90.w, 120.w, 80.w, 100.w];
    return Row(
      children: [
        for (int i = 0; i < cells.length; i++)
          SizedBox(
            width: widths[i],
            child: isHeader
                ? Text(cells[i],
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textSecondary))
                : i == 3
                    ? _statusChip(cells[i])
                    : Text(cells[i],
                        style: TextStyle(fontSize: 11.5.sp)),
          ),
      ],
    );
  }

  Widget _statusChip(String status) {
    final color = switch (status) {
      'Completed' => AppColors.success,
      'Shipping' => AppColors.info,
      _ => AppColors.warning,
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(status,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: color)),
    );
  }
}
