import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/validators.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import 'auth_view_model.dart';

/// Screen 4 — Login / Register: welcome back + social providers.
class LoginView extends GetView<AuthViewModel> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                // Hero sneaker
                Center(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1542291026-7eec264c27ff'
                    '?auto=format&fit=crop&w=600&q=80',
                    height: 170.h,
                    fit: BoxFit.contain,
                  ),
                ).animate().fadeIn(duration: 500.ms).moveY(begin: 12, end: 0),
                SizedBox(height: 18.h),
                Center(
                  child: Text('Welcome Back',
                      textAlign: TextAlign.center, style: AppTextStyles.h1),
                ),
                SizedBox(height: 6.h),
                Center(
                  child: Text(
                    'Sign in to continue',
                    style: AppTextStyles.bodyGrey,
                  ),
                ),
                SizedBox(height: 28.h),

                AppTextField(
                  controller: controller.loginIdentifier,
                  hint: 'Email or phone number',
                  prefixIcon: Icons.person_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.emailOrPhone,
                ),
                SizedBox(height: 14.h),
                Obx(
                  () => AppTextField(
                    controller: controller.loginPassword,
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

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.forgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),

                Obx(
                  () => AppButton(
                    label: 'Log In',
                    loading: controller.isLoading.value,
                    onPressed: controller.login,
                  ),
                ),
                SizedBox(height: 18.h),

                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.divider)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text('OR',
                          style: AppTextStyles.small
                              .copyWith(letterSpacing: 1.2)),
                    ),
                    const Expanded(child: Divider(color: AppColors.divider)),
                  ],
                ),
                SizedBox(height: 18.h),

                _socialButton(
                  icon: Icons.g_mobiledata_rounded,
                  label: 'Continue with Google',
                  onTap: controller.signInWithGoogle,
                ),
                SizedBox(height: 12.h),
                _socialButton(
                  icon: Icons.facebook_rounded,
                  label: 'Continue with Facebook',
                  iconColor: const Color(0xFF1877F2),
                  onTap: controller.signInWithFacebook,
                ),
                SizedBox(height: 12.h),
                _socialButton(
                  icon: Icons.apple_rounded,
                  label: 'Continue with Apple',
                  onTap: controller.signInWithApple,
                ),
                SizedBox(height: 24.h),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.caption,
                      ),
                      GestureDetector(
                        onTap: controller.goToRegister,
                        child: Text(
                          'Sign Up',
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

  Widget _socialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return SizedBox(
      height: 50.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 24.r, color: iconColor ?? AppColors.textPrimary),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            SizedBox(width: 24.w),
          ],
        ),
      ),
    );
  }
}
