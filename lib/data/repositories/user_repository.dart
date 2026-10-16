import 'package:get/get.dart';

import '../mock/mock_data.dart';
import '../models/misc_models.dart';
import '../models/user_model.dart';
import '../providers/api_endpoints.dart';
import '../providers/api_provider.dart';

/// Profile, addresses & notifications repository.
class UserRepository {
  final Rx<UserModel> user = MockData.user.obs;
  final RxList<AddressModel> addresses = <AddressModel>[].obs;
  final RxList<AppNotificationModel> notifications =
      <AppNotificationModel>[].obs;

  UserRepository() {
    addresses.assignAll(MockData.addresses);
    notifications.assignAll(MockData.notifications);
  }

  Future<UserModel> fetchProfile() async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      return user.value;
    }
    final response = await ApiProvider.get(ApiEndpoints.profile);
    user.value =
        UserModel.fromJson(response.data['data'] as Map<String, dynamic>);
    return user.value;
  }

  Future<UserModel> updateProfile({
    String? fullName,
    String? email,
    String? phone,
    String? gender,
    String? avatarUrl,
  }) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      user.value = user.value.copyWith(
        fullName: fullName,
        email: email,
        phone: phone,
        gender: gender,
        avatarUrl: avatarUrl,
      );
      return user.value;
    }
    final response = await ApiProvider.put(
      ApiEndpoints.profile,
      data: {
        if (fullName != null) 'full_name': fullName,
        if (email != null) 'email': email,
        if (phone != null) 'phone': phone,
        if (gender != null) 'gender': gender,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
      },
    );
    user.value =
        UserModel.fromJson(response.data['data'] as Map<String, dynamic>);
    return user.value;
  }

  // ---------- Addresses ----------
  Future<void> addAddress(AddressModel address) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      addresses.add(address);
      return;
    }
    final response = await ApiProvider.post(
      ApiEndpoints.addresses,
      data: address.toJson(),
    );
    addresses.add(
        AddressModel.fromJson(response.data['data'] as Map<String, dynamic>));
  }

  Future<void> updateAddress(AddressModel address) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      final index = addresses.indexWhere((a) => a.id == address.id);
      if (index >= 0) {
        addresses[index] = address;
        addresses.refresh();
      }
      return;
    }
    await ApiProvider.put(
      '${ApiEndpoints.addresses}/${address.id}',
      data: address.toJson(),
    );
  }

  Future<void> deleteAddress(String id) async {
    if (ApiProvider.useMock) {
      addresses.removeWhere((a) => a.id == id);
      return;
    }
    await ApiProvider.delete('${ApiEndpoints.addresses}/$id');
  }

  Future<void> setDefaultAddress(String id) async {
    for (var i = 0; i < addresses.length; i++) {
      addresses[i] = addresses[i].copyWith(isDefault: addresses[i].id == id);
    }
    addresses.refresh();
    if (!ApiProvider.useMock) {
      await ApiProvider.post('${ApiEndpoints.addresses}/$id/default');
    }
  }

  // ---------- Notifications ----------
  Future<List<AppNotificationModel>> fetchNotifications() async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return notifications;
    }
    final response = await ApiProvider.get(ApiEndpoints.notifications);
    return (response.data['data'] as List<dynamic>)
        .map((e) => AppNotificationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  int get unreadCount => notifications.where((n) => !n.isRead).length;
}
