import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shoe_store/core/binding/app_bindings.dart';
import 'package:shoe_store/core/constants/app_constants.dart';
import 'package:shoe_store/core/routes/app_pages.dart';
import 'package:shoe_store/core/routes/app_routes.dart';
import 'package:shoe_store/core/services/storage_service.dart';
import 'package:shoe_store/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode:
              StorageService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          initialBinding: AppBindings(),
          initialRoute: AppRoutes.splash,
          getPages: AppPages.routes,
          defaultTransition: Transition.cupertino,
          transitionDuration: AppConstants.animationFast,
        );
      },
    );
  }
}
