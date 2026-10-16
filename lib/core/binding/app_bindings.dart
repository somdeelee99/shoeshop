import 'package:get/get.dart';
import 'package:shoe_store/data/repositories/cart_repository.dart';
import 'package:shoe_store/data/repositories/order_repository.dart';
import 'package:shoe_store/data/repositories/user_repository.dart';
import 'package:shoe_store/modules/addresses/addresses_view_model.dart';
import 'package:shoe_store/modules/auth/auth_view_model.dart';
import 'package:shoe_store/modules/cart/cart_view_model.dart';
import 'package:shoe_store/modules/categories/categories_view_model.dart';
import 'package:shoe_store/modules/home/home_view_model.dart';
import 'package:shoe_store/modules/notifications/notifications_view_model.dart';
import 'package:shoe_store/modules/onboarding/onboarding_view_model.dart';
import 'package:shoe_store/modules/orders/orders_view_model.dart';
import 'package:shoe_store/modules/product_list/product_list_view_model.dart';
import 'package:shoe_store/modules/profile/profile_view_model.dart';
import 'package:shoe_store/modules/settings/settings_view_model.dart';
import 'package:shoe_store/modules/splash/splash_view_model.dart';
import 'package:shoe_store/modules/wishlist/wishlist_view_model.dart';

/// Global bindings: shared repositories live for the whole session.
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CartRepository(), permanent: true);
    Get.put(ProductListViewModel(), permanent: true);
    Get.put(SettingsViewModel(), permanent: true);
    Get.put(UserRepository(), permanent: true);
    Get.put(NotificationsViewModel(), permanent: true);
    Get.put(CartRepository(), permanent: true);
    Get.put(CartRepository(), permanent: true);
    Get.put(WishlistViewModel(), permanent: true);
    Get.put(UserRepository(), permanent: true);
    Get.put(AddressesViewModel(), permanent: true);
    Get.put(UserRepository(), permanent: true);
    Get.put(ProfileViewModel(), permanent: true);
    Get.put(OrderRepository(), permanent: true);
    Get.put(OrdersViewModel(), permanent: true);
    Get.put(CartRepository(), permanent: true);
    Get.put(CartViewModel(), permanent: true);
    Get.put(CategoriesViewModel(), permanent: true);
    Get.put(CartRepository(), permanent: true);
    Get.put(UserRepository(), permanent: true);
    Get.put(HomeViewModel(), permanent: true);
    Get.put(AuthViewModel(), permanent: true);
    Get.put(SplashViewModel(), permanent: true);
    Get.put(OnboardingViewModel(), permanent: true);
    Get.put(CartRepository(), permanent: true);
    Get.put(OrderRepository(), permanent: true);
    Get.put(UserRepository(), permanent: true);
  }
}
