import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/cached_image.dart';
import '../../widgets/common_ui.dart';
import 'edit_profile_view_model.dart';

/// Screen 18 — Edit Profile: avatar, name/email/phone, gender, save.
class EditProfileView extends GetView<EditProfileViewModel> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SimpleAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: controller.formKey,
          child: Obx(
            () => Column(
              children: [
                SizedBox(height: 16.h),
                // Avatar with camera badge
                Stack(
                  children: [
                    ClipOval(
                      child: AppCachedImage(
                        url:
                            'https://i.pravatar.cc/300?img=47',
                        width: 110.r,
                        height: 110.r,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(7.r),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(Icons.photo_camera_rounded,
                            size: 15.r, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Full Name',
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary)),
                ),
                SizedBox(height: 6.h),
                AppTextField(
                  controller: controller.name,
                  hint: 'Full name',
                ),
                SizedBox(height: 14.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Email',
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary)),
                ),
                SizedBox(height: 6.h),
                AppTextField(
                  controller: controller.email,
                  hint: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 14.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Phone Number',
                      style: TextStyle(
                          fontSize: 11.5.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary)),
                ),
                SizedBox(height: 6.h),
                AppTextField(
                  controller: controller.phone,
                  hint: 'Phone number',
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 18.h),
                // Gender
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Gender', style: AppTextStyles.title),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    for (final option in ['Male', 'Female', 'Other'])
                      Expanded(
                        child: RadioListTile<String>(
                          value: option,
                          groupValue: controller.gender.value,
                          onChanged: (v) =>
                              controller.selectGender(v ?? 'Male'),
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          title: Text(option,
                              style: TextStyle(fontSize: 13.sp)),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 24.h),
                AppButton(
                  label: 'Save Changes',
                  loading: controller.isLoading.value,
                  onPressed: controller.save,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
