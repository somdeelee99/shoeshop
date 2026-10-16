import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

/// Typography scale used across the app. All sizes are responsive via ScreenUtil.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base(Color color, double size, FontWeight weight) =>
      TextStyle(
        fontSize: size.sp,
        fontWeight: weight,
        color: color,
        height: 1.35,
      );

  // Headings
  static TextStyle get splash => _base(AppColors.white, 34, FontWeight.w800);

  static TextStyle get h1 => _base(AppColors.textPrimary, 28, FontWeight.w800);

  static TextStyle get h2 => _base(AppColors.textPrimary, 22, FontWeight.w700);

  static TextStyle get h3 => _base(AppColors.textPrimary, 18, FontWeight.w700);

  // Body
  static TextStyle get title => _base(AppColors.textPrimary, 16, FontWeight.w700);

  static TextStyle get bodyBold =>
      _base(AppColors.textPrimary, 14, FontWeight.w600);

  static TextStyle get body =>
      _base(AppColors.textPrimary, 14, FontWeight.w400);

  static TextStyle get bodyGrey =>
      _base(AppColors.textSecondary, 14, FontWeight.w400);

  static TextStyle get caption =>
      _base(AppColors.textSecondary, 12, FontWeight.w400);

  static TextStyle get captionBold =>
      _base(AppColors.textPrimary, 12, FontWeight.w600);

  static TextStyle get small =>
      _base(AppColors.textHint, 10, FontWeight.w500);

  // Special
  static TextStyle get button =>
      _base(AppColors.white, 16, FontWeight.w700);

  static TextStyle get buttonDark =>
      _base(AppColors.textPrimary, 16, FontWeight.w700);

  static TextStyle get price =>
      _base(AppColors.textPrimary, 16, FontWeight.w800);

  static TextStyle get priceLarge =>
      _base(AppColors.textPrimary, 24, FontWeight.w800);

  static TextStyle get link => _base(AppColors.primary, 13, FontWeight.w700);
}
