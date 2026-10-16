import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Spacing / radius scale (responsive).
class AppDimens {
  AppDimens._();

  // Padding
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get base => 16.w;
  static double get lg => 20.w;
  static double get xl => 24.w;
  static double get xxl => 32.w;
  static double get gap => 40.w;

  // Radius
  static double get rSm => 8.r;
  static double get rMd => 12.r;
  static double get rLg => 16.r;
  static double get rXl => 20.r;
  static double get rPill => 100.r;

  // Sizes
  static double get buttonHeight => 54.h;
  static double get fieldHeight => 52.h;
  static double get iconSm => 18.r;
  static double get iconMd => 22.r;
  static double get iconLg => 28.r;
  static double get appBarHeight => 56.h;
  static double get bottomNavHeight => 64.h;
  static double get productImage => 140.h;
}
