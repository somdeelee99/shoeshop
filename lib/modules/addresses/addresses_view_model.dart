import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

/// Address book: list, add / edit bottom sheet.
class AddressesViewModel extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();

  RxList<AddressModel> get addresses => _userRepository.addresses;

  final RxInt selectedIndex = 0.obs;
  final RxBool isSaving = false.obs;

  // Bottom-sheet form controllers
  final labelController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();

  AddressModel? _editing;

  void select(int index) {
    selectedIndex.value = index;
    _userRepository.setDefaultAddress(addresses[index].id);
  }

  void openAddSheet() {
    _editing = null;
    labelController.text = '';
    streetController.text = '';
    cityController.text = '';
    phoneController.text = '';
    _showSheet();
  }

  void openEditSheet(AddressModel address) {
    _editing = address;
    labelController.text = address.label;
    streetController.text = address.street;
    cityController.text = address.city;
    phoneController.text = address.phone;
    _showSheet();
  }

  void _showSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Wrap(
          runSpacing: 12,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Text(
              _editing == null ? 'Add New Address' : 'Edit Address',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            _field(labelController, 'Label (Home / Office)'),
            _field(streetController, 'Street'),
            _field(cityController, 'City'),
            _field(phoneController, 'Phone number',
                keyboardType: TextInputType.phone),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: save,
              child: Text(_editing == null ? 'Add Address' : 'Save Changes'),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _field(TextEditingController controller, String hint,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hint),
    );
  }

  Future<void> save() async {
    if (labelController.text.trim().isEmpty ||
        streetController.text.trim().isEmpty) {
      Get.snackbar('Missing info', 'Please fill in label and street',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    isSaving.value = true;
    final address = AddressModel(
      id: _editing?.id ?? 'a-${DateTime.now().microsecondsSinceEpoch}',
      label: labelController.text.trim(),
      street: streetController.text.trim(),
      city: cityController.text.trim().isEmpty
          ? 'Vientiane, Laos'
          : cityController.text.trim(),
      phone: phoneController.text.trim().isEmpty
          ? '+856 20 0000 0000'
          : phoneController.text.trim(),
    );

    if (_editing == null) {
      await _userRepository.addAddress(address);
    } else {
      await _userRepository.updateAddress(address);
    }
    isSaving.value = false;
    Get.back();
    Get.snackbar('Saved', 'Your address has been updated.',
        snackPosition: SnackPosition.BOTTOM);
  }

  void delete(AddressModel address) async {
    await _userRepository.deleteAddress(address.id);
  }

  @override
  void onClose() {
    labelController.dispose();
    streetController.dispose();
    cityController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
