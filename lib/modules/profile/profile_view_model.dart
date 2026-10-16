import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/user_repository.dart';

/// Profile menu state.
class ProfileViewModel extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  final AuthRepository _authRepository = AuthRepository();

  final avatarUrl = ''.obs;

  String get userName => _userRepository.user.value.fullName;
  String get email => _userRepository.user.value.email;
  String get memberSince =>
      'Member since Oct ${_userRepository.user.value.memberSince.year}';
  String get avatar => _userRepository.user.value.avatarUrl;

  void openOrders() => Get.toNamed(AppRoutes.orders);
  void openAddresses() => Get.toNamed(AppRoutes.addresses);
  void openWishlist() => Get.toNamed(AppRoutes.wishlist);
  void openPaymentMethods() => Get.toNamed(AppRoutes.payment);
  void openNotifications() => Get.toNamed(AppRoutes.notifications);
  void openSettings() => Get.toNamed(AppRoutes.settings);
  void openHelp() => Get.toNamed(AppRoutes.chat);
  void openEditProfile() => Get.toNamed(AppRoutes.editProfile);

  void logout() async {
    await _authRepository.logout();
    Get.offAllNamed(AppRoutes.login);
  }
}
