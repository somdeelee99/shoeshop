import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/validators.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import 'auth_view_model.dart';

/// Screen 4b — Register: create a new account.
class RegisterView extends GetView<AuthViewModel> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: controller.goToLogin,
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create Account', style: AppTextStyles.h1),
                SizedBox(height: 6.h),
                Text(
                  'Sign up to start your style journey',
                  style: AppTextStyles.bodyGrey,
                ),
                SizedBox(height: 26.h),
                AppTextField(
                  controller: controller.registerName,
                  hint: 'Full name',
                  prefixIcon: Icons.person_outline_rounded,
                  validator: (v) => Validators.required(v, 'Full name'),
                ),
                SizedBox(height: 14.h),
                AppTextField(
                  controller: controller.registerEmail,
                  hint: 'Email address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                SizedBox(height: 14.h),
                AppTextField(
                  controller: controller.registerPhone,
                  hint: 'Phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: Validators.phone,
                ),
                SizedBox(height: 14.h),
                Obx(
                  () => AppTextField(
                    controller: controller.registerPassword,
                    hint: 'Password',
                    prefixIcon: Icons.lock_outline_rounded,
                    obscureText: controller.obscurePassword.value,
                    validator: Validators.password,
                    suffixIcon: IconButton(
                      onPressed: controller.toggleObscure,
                      icon: Icon(
                        controller.obscurePassword.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: AppColors.textHint,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 26.h),
                Obx(
                  () => AppButton(
                    label: 'Create Account',
                    loading: controller.isLoading.value,
                    onPressed: controller.register,
                  ),
                ),
                SizedBox(height: 18.h),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Already have an account? ',
                          style: AppTextStyles.caption),
                      GestureDetector(
                        onTap: controller.goToLogin,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
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
