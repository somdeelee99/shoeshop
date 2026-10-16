import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';

/// Primary / secondary / loading button.
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool outlined;
  final IconData? icon;
  final double? height;
  final Color? color;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.outlined = false,
    this.icon,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final bg = color ?? AppColors.primary;
    final child = loading
        ? SizedBox(
            width: 22.r,
            height: 22.r,
            child: const CircularProgressIndicator(
              strokeWidth: 2.2,
              color: Colors.white,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppDimens.iconSm, color: Colors.white),
                SizedBox(width: 8.w),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: outlined ? bg : Colors.white,
                ),
              ),
            ],
          );

    return SizedBox(
      height: height ?? AppDimens.buttonHeight,
      child: outlined
          ? OutlinedButton(
              onPressed: loading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: bg, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.rMd),
                ),
              ),
              child: child,
            )
          : ElevatedButton(
              onPressed: loading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: bg,
                disabledBackgroundColor: bg.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.rMd),
                ),
              ),
              child: child,
            ),
    ).animate().fadeIn(duration: 300.ms).moveY(begin: 8, end: 0);
  }
}
