import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoe_store/app.dart';
import 'core/services/notification_service.dart';
import 'core/services/storage_service.dart';
import 'data/providers/api_provider.dart';

/// Shoe Store — Step Your Style
/// Architecture: MVVM with GetX (View ⇄ ViewModel ⇄ Repository ⇄ Provider)
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Core services
  await StorageService.init();
  await ApiProvider.init();

  // Push notifications (safe to fail when Firebase is not configured)
  await NotificationService.init();

  runApp(const App());
}
