import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/common_ui.dart';
import 'settings_view_model.dart';

/// Screen 20 — Settings: preferences + notification toggles + dark mode.
class SettingsView extends GetView<SettingsViewModel> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SimpleAppBar(title: 'Settings'),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          children: [
            InfoTile(
              icon: Icons.language_rounded,
              title: 'Language',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(controller.language.value,
                      style: TextStyle(
                          fontSize: 12.5.sp, color: AppColors.textSecondary)),
                  Icon(Icons.chevron_right_rounded,
                      size: 22.r, color: AppColors.textHint),
                ],
              ),
              onTap: () => _pickLanguage(context),
            ),
            InfoTile(
              icon: Icons.currency_exchange_rounded,
              title: 'Currency',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(controller.currency.value,
                      style: TextStyle(
                          fontSize: 12.5.sp, color: AppColors.textSecondary)),
                  Icon(Icons.chevron_right_rounded,
                      size: 22.r, color: AppColors.textHint),
                ],
              ),
              onTap: () => _pickCurrency(context),
            ),
            InfoTile(
              icon: Icons.notifications_none_rounded,
              title: 'Push Notifications',
              trailing: Switch(
                value: controller.pushEnabled.value,
                activeColor: AppColors.primary,
                onChanged: controller.togglePush,
              ),
            ),
            InfoTile(
              icon: Icons.email_outlined,
              title: 'Email Notifications',
              trailing: Switch(
                value: controller.emailEnabled.value,
                activeColor: AppColors.primary,
                onChanged: controller.toggleEmail,
              ),
            ),
            InfoTile(
              icon: Icons.dark_mode_outlined,
              title: 'Dark Mode',
              trailing: Switch(
                value: controller.darkMode.value,
                activeColor: AppColors.primary,
                onChanged: controller.toggleDarkMode,
              ),
            ),
            InfoTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: controller.openPrivacyPolicy,
            ),
            InfoTile(
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              showDivider: false,
              onTap: controller.openTerms,
            ),
          ],
        ),
      ),
    );
  }

  void _pickLanguage(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Wrap(
          children: [
            for (final option in ['English', 'Lao', 'Thai'])
              ListTile(
                title: Text(option),
                trailing: controller.language.value == option
                    ? const Icon(Icons.check_rounded, color: AppColors.primary)
                    : null,
                onTap: () {
                  controller.setLanguage(option);
                  Get.back();
                },
              ),
          ],
        ),
      ),
    );
  }

  void _pickCurrency(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Wrap(
          children: [
            for (final option in ['USD (\$)', 'LAK (₭)', 'THB (฿)'])
              ListTile(
                title: Text(option),
                trailing: controller.currency.value == option
                    ? const Icon(Icons.check_rounded, color: AppColors.primary)
                    : null,
                onTap: () {
                  controller.setCurrency(option);
                  Get.back();
                },
              ),
          ],
        ),
      ),
    );
  }
}
