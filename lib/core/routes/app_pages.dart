import 'package:get/get.dart';

import '../../modules/addresses/addresses_view.dart';
import '../../modules/addresses/addresses_view_model.dart';
import '../../modules/auth/auth_view_model.dart';
import '../../modules/auth/login_view.dart';
import '../../modules/auth/register_view.dart';
import '../../modules/cart/cart_view.dart';
import '../../modules/cart/cart_view_model.dart';
import '../../modules/categories/categories_view.dart';
import '../../modules/categories/categories_view_model.dart';
import '../../modules/chat/chat_view.dart';
import '../../modules/chat/chat_view_model.dart';
import '../../modules/checkout/checkout_view.dart';
import '../../modules/checkout/checkout_view_model.dart';
import '../../modules/edit_profile/edit_profile_view.dart';
import '../../modules/edit_profile/edit_profile_view_model.dart';
import '../../modules/filter/filter_view.dart';
import '../../modules/filter/filter_view_model.dart';
import '../../modules/home/home_view.dart';
import '../../modules/home/home_view_model.dart';
import '../../modules/notifications/notifications_view.dart';
import '../../modules/notifications/notifications_view_model.dart';
import '../../modules/onboarding/onboarding_view.dart';
import '../../modules/onboarding/onboarding_view_model.dart';
import '../../modules/order_detail/order_detail_view.dart';
import '../../modules/order_detail/order_detail_view_model.dart';
import '../../modules/orders/orders_view.dart';
import '../../modules/orders/orders_view_model.dart';
import '../../modules/payment/payment_view.dart';
import '../../modules/payment/payment_view_model.dart';
import '../../modules/product_details/product_details_view.dart';
import '../../modules/product_details/product_details_view_model.dart';
import '../../modules/product_list/product_list_view.dart';
import '../../modules/product_list/product_list_view_model.dart';
import '../../modules/profile/profile_view.dart';
import '../../modules/profile/profile_view_model.dart';
import '../../modules/settings/settings_view.dart';
import '../../modules/settings/settings_view_model.dart';
import '../../modules/splash/splash_view.dart';
import '../../modules/splash/splash_view_model.dart';
import '../../modules/wishlist/wishlist_view.dart';
import '../../modules/wishlist/wishlist_view_model.dart';
import '../../modules/admin/admin_dashboard_view.dart';
import '../../modules/admin/admin_view_model.dart';
import 'app_routes.dart';

/// Route table. Every page lazily binds its ViewModel (MVVM + GetX).
class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: BindingsBuilder(() => Get.put(SplashViewModel())),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: BindingsBuilder(() => Get.put(OnboardingViewModel())),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder(() => Get.put(AuthViewModel())),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<AuthViewModel>()) {
          Get.put(AuthViewModel());
        }
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(() => Get.put(HomeViewModel())),
    ),
    GetPage(
      name: AppRoutes.categories,
      page: () => const CategoriesView(),
      binding: BindingsBuilder(() => Get.put(CategoriesViewModel())),
    ),
    GetPage(
      name: AppRoutes.productList,
      page: () => const ProductListView(),
      binding: BindingsBuilder(() => Get.put(ProductListViewModel())),
    ),
    GetPage(
      name: AppRoutes.filter,
      page: () => const FilterView(),
      binding: BindingsBuilder(() => Get.put(FilterViewModel())),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => ProductDetailsView(),
      binding: BindingsBuilder(() => Get.put(ProductDetailsViewModel())),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartView(),
      binding: BindingsBuilder(() => Get.put(CartViewModel())),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => const CheckoutView(),
      binding: BindingsBuilder(() => Get.put(CheckoutViewModel())),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentView(),
      binding: BindingsBuilder(() => Get.put(PaymentViewModel())),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrdersView(),
      binding: BindingsBuilder(() => Get.put(OrdersViewModel())),
    ),
    GetPage(
      name: AppRoutes.orderDetail,
      page: () => const OrderDetailView(),
      binding: BindingsBuilder(() => Get.put(OrderDetailViewModel())),
    ),
    GetPage(
      name: AppRoutes.wishlist,
      page: () => const WishlistView(),
      binding: BindingsBuilder(() => Get.put(WishlistViewModel())),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: BindingsBuilder(() => Get.put(ProfileViewModel())),
    ),
    GetPage(
      name: AppRoutes.addresses,
      page: () => const AddressesView(),
      binding: BindingsBuilder(() => Get.put(AddressesViewModel())),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileView(),
      binding: BindingsBuilder(() => Get.put(EditProfileViewModel())),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      binding: BindingsBuilder(() => Get.put(NotificationsViewModel())),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: BindingsBuilder(() => Get.put(SettingsViewModel())),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => const ChatView(),
      binding: BindingsBuilder(() => Get.put(ChatViewModel())),
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const AdminDashboardView(),
      binding: BindingsBuilder(() => Get.put(AdminViewModel())),
    ),
  ];
}
