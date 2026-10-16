import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/user_repository.dart';

/// Edit profile form state.
class EditProfileViewModel extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final RxString gender = 'Male'.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final user = _userRepository.user.value;
    name.text = user.fullName;
    email.text = user.email;
    phone.text = user.phone;
    gender.value = user.gender;
  }

  void selectGender(String value) => gender.value = value;

  Future<void> save() async {
    isLoading.value = true;
    try {
      await _userRepository.updateProfile(
        fullName: name.text.trim(),
        email: email.text.trim(),
        phone: phone.text.trim(),
        gender: gender.value,
      );
      Get.back();
      Get.snackbar('Profile updated', 'Your changes have been saved.',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.onClose();
  }
}
