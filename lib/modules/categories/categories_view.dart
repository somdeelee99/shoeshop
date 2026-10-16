import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/common_ui.dart';
import 'categories_view_model.dart';

/// Screen 6 — Categories: 2-column grid with tinted tiles.
class CategoriesView extends GetView<CategoriesViewModel> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SimpleAppBar(title: 'Categories'),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14.h,
                  crossAxisSpacing: 14.w,
                  childAspectRatio: 1.05,
                ),
                itemCount: controller.categories.length,
                itemBuilder: (_, index) {
                  final category = controller.categories[index];
                  return GestureDetector(
                    onTap: () => controller.openCategory(category),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(category.colorValue),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14.r),
                            child: AppCachedImage(
                              url: category.imageUrl,
                              width: 92.w,
                              height: 72.h,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(
                          delay: Duration(milliseconds: 60 * index),
                          duration: 320.ms,
                        )
                        .scale(begin: const Offset(0.95, 0.95)),
                  );
                },
              ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}
