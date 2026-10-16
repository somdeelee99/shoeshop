import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';
import '../core/constants/app_text_styles.dart';

/// Section header with optional "See All" action.
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.h3),
          if (actionText != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionText!,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Standard icon app bar with optional trailing widgets.
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool showBack;
  final Widget? leading;
  final bool centerTitle;

  const SimpleAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.showBack = true,
    this.leading,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      automaticallyImplyLeading: showBack,
      leading: leading ??
          (showBack
              ? IconButton(
                  onPressed: Get.back,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                )
              : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppDimens.appBarHeight);
}

/// Circular icon button used on app bars & product details.
class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? background;
  final double size;

  const RoundIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.background,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.r,
        height: size.r,
        decoration: BoxDecoration(
          color: background ?? AppColors.lightGrey,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: size.r * 0.5,
          color: iconColor ?? AppColors.textPrimary,
        ),
      ),
    );
  }
}

/// Empty state placeholder.
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 90.r,
            height: 90.r,
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 42.r, color: AppColors.textHint),
          ),
          SizedBox(height: 16.h),
          Text(title, style: AppTextStyles.title),
          if (subtitle != null) ...[
            SizedBox(height: 6.h),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyGrey,
            ),
          ],
        ],
      ),
    );
  }
}

/// Info tile used in profile / settings lists.
class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final bool showDivider;

  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Icon(icon,
                    size: AppDimens.iconMd,
                    color: iconColor ?? AppColors.textSecondary),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.bodyBold),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: AppTextStyles.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                trailing ??
                    Icon(Icons.chevron_right_rounded,
                        size: 22.r, color: AppColors.textHint),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: AppColors.divider, indent: 38.w),
      ],
    );
  }
}
