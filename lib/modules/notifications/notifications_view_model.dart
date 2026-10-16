import 'package:get/get.dart';

import '../../data/models/misc_models.dart';
import '../../data/repositories/user_repository.dart';

/// Notifications list state.
class NotificationsViewModel extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();

  final RxList<AppNotificationModel> notifications =
      <AppNotificationModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    final data = await _userRepository.fetchNotifications();
    notifications.assignAll(data);
    isLoading.value = false;
  }
}
