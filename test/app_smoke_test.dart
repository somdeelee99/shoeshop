import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoe_store/app.dart';
import 'package:shoe_store/core/routes/app_routes.dart';
import 'package:shoe_store/core/services/storage_service.dart';

bool _storageReady = false;

Future<void> _initStorage(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  if (_storageReady) return;
  await StorageService.init();
  _storageReady = true;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app builds without crashing', (tester) async {
    // Match the 390x844 design size to avoid layout overflows in tests.
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await _initStorage({});

    await tester.pumpWidget(const App());
    await tester.pump(const Duration(seconds: 3));
    // Drain mock repository timers (Future.delayed in ProductRepository).
    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets('product details opens without arguments without crashing',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await _initStorage({'onboarding_done': true});

    await tester.pumpWidget(const App());
    // Splash -> Home
    await tester.pump(const Duration(seconds: 3));

    // Open product details with NO arguments (previously crashed with
    // "type 'Null' is not a subtype of type 'ProductModel' in type cast").
    Get.toNamed(AppRoutes.productDetails);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
  });
}
