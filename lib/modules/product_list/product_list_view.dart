import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/common_ui.dart';
import '../../widgets/product_card.dart';
import 'product_list_view_model.dart';

/// Screen 7 — Product List: search header, tab chips, 2-column grid.
class ProductListView extends GetView<ProductListViewModel> {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: SimpleAppBar(
        title: controller.title,
        actions: [
          IconButton(
            onPressed: controller.openFilter,
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            onPressed: controller.openFilter,
            icon: const Icon(Icons.tune_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Badge(
              label: const Text('2'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            // Tabs
            SizedBox(
              height: 44.h,
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
                        color:
                            selected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: selected
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            // Count
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Text(
                    '${controller.title} (${controller.filtered.length})',
                    style: TextStyle(
                        fontSize: 13.sp, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Icon(Icons.swap_vert_rounded,
                      size: 18.r, color: AppColors.textSecondary),
                  SizedBox(width: 4.w),
                  Text('Sort',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary)),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            // Grid
            Expanded(
              child: controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.filtered.isEmpty
                      ? const EmptyState(
                          icon: Icons.search_off_rounded,
                          title: 'No shoes found',
                          subtitle: 'Try adjusting filters or search terms.',
                        )
                      : GridView.builder(
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12.h,
                            crossAxisSpacing: 12.w,
                            childAspectRatio: 0.68,
                          ),
                          itemCount: controller.filtered.length,
                          itemBuilder: (_, index) => ProductCard(
                            product: controller.filtered[index],
                            width: 170,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
