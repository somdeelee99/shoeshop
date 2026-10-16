import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/common_ui.dart';
import 'filter_view_model.dart';

/// Screen 8 — Filter: category chips, brand grid, price slider,
/// size & color pickers with "Apply Filter".
class FilterView extends GetView<FilterViewModel> {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SimpleAppBar(
        title: 'Filter',
        actions: [
          TextButton(
            onPressed: controller.reset,
            child: Text(
              'Reset',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category', style: AppTextStyles.title),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [
                  for (final category in controller.categories)
                    _chip(
                      label: category,
                      selected:
                          controller.selectedCategory.value == category,
                      onTap: () => controller.selectCategory(category),
                    ),
                ],
              ),
              SizedBox(height: 22.h),

              Text('Brand', style: AppTextStyles.title),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [
                  for (final brand in controller.brands)
                    _brandChip(brand.name),
                ],
              ),
              SizedBox(height: 22.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price Range', style: AppTextStyles.title),
                  Text(
                    '\$${controller.minPrice.value.round()} '
                    '- \$${controller.maxPrice.value.round()}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              RangeSlider(
                values: RangeValues(
                    controller.minPrice.value, controller.maxPrice.value),
                min: 50,
                max: 3000,
                divisions: 59,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.lightGrey,
                onChanged: (values) => controller.setPriceRange(
                    values.start, values.end),
              ),
              SizedBox(height: 10.h),

              Text('Size (US)', style: AppTextStyles.title),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [
                  for (final size in controller.sizes)
                    _chip(
                      label: size.toStringAsFixed(0),
                      selected: controller.selectedSize.value == size,
                      onTap: () => controller.selectSize(size),
                    ),
                ],
              ),
              SizedBox(height: 22.h),

              Text('Color', style: AppTextStyles.title),
              SizedBox(height: 12.h),
              Row(
                children: [
                  for (int i = 0; i < AppColors.swatches.length; i++)
                    _colorSwatch(i),
                ],
              ),
              SizedBox(height: 28.h),
              AppButton(
                label: 'Apply Filter',
                onPressed: controller.apply,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _brandChip(String name) {
    final selected = controller.selectedBrands.contains(name);
    return GestureDetector(
      onTap: () => controller.toggleBrand(name),
      child: Container(
        width: 78.w,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 1.6 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: selected ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _colorSwatch(int index) {
    final color = AppColors.swatches[index];
    final selected = controller.selectedColor.value == index;
    return GestureDetector(
      onTap: () => controller.selectColor(index),
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        width: 34.r,
        height: 34.r,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: selected ? 2.4 : 1,
          ),
        ),
        child: selected
            ? Icon(Icons.check_rounded,
                size: 16.r,
                color: index == 0 ? Colors.white : Colors.black54)
            : null,
      ),
    );
  }
}
