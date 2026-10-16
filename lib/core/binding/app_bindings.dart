import 'package:get/get.dart';
import 'package:shoe_store/data/repositories/cart_repository.dart';
import 'package:shoe_store/data/repositories/order_repository.dart';
import 'package:shoe_store/data/repositories/user_repository.dart';
import 'package:shoe_store/modules/addresses/addresses_view_model.dart';
import 'package:shoe_store/modules/auth/auth_view_model.dart';
import 'package:shoe_store/modules/cart/cart_view_model.dart';
import 'package:shoe_store/modules/categories/categories_view_model.dart';
import 'package:shoe_store/modules/checkout/checkout_view_model.dart';
import 'package:shoe_store/modules/home/home_view_model.dart';
import 'package:shoe_store/modules/notifications/notifications_view_model.dart';
import 'package:shoe_store/modules/onboarding/onboarding_view_model.dart';
import 'package:shoe_store/modules/order_detail/order_detail_view_model.dart';
import 'package:shoe_store/modules/orders/orders_view_model.dart';
import 'package:shoe_store/modules/payment/payment_view_model.dart';
import 'package:shoe_store/modules/product_list/product_list_view_model.dart';
import 'package:shoe_store/modules/profile/profile_view_model.dart';
import 'package:shoe_store/modules/settings/settings_view_model.dart';
import 'package:shoe_store/modules/splash/splash_view_model.dart';
import 'package:shoe_store/modules/wishlist/wishlist_view_model.dart';

/// Global bindings: shared repositories live for the whole session.
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // --- 1. Repositories -  ---
    Get.put(UserRepository(), permanent: true);
    Get.put(CartRepository(), permanent: true);
    Get.put(OrderRepository(), permanent: true);

    // --- 2. Global Controllers  ---
    Get.put(SplashViewModel(), permanent: true);
    Get.put(OnboardingViewModel(), permanent: true);
    Get.put(AuthViewModel(), permanent: true);

    // --- 3. ViewModels  ---
    Get.lazyPut(() => OrderDetailViewModel(), fenix: true);
    Get.lazyPut(() => HomeViewModel(), fenix: true);
    Get.lazyPut(() => CategoriesViewModel(), fenix: true);
    Get.lazyPut(() => ProductListViewModel(), fenix: true);
    Get.lazyPut(() => CartViewModel(), fenix: true);
    Get.lazyPut(() => WishlistViewModel(), fenix: true);
    Get.lazyPut(() => CheckoutViewModel(), fenix: true);
    Get.lazyPut(() => PaymentViewModel(), fenix: true);
    Get.lazyPut(() => OrdersViewModel(), fenix: true);
    Get.lazyPut(() => ProfileViewModel(), fenix: true);
    Get.lazyPut(() => SettingsViewModel(), fenix: true);
    Get.lazyPut(() => AddressesViewModel(), fenix: true);
    Get.lazyPut(() => NotificationsViewModel(), fenix: true);
  }
}
