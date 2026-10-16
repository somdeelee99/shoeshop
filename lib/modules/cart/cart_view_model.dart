import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../data/models/cart_model.dart';
import '../../data/repositories/cart_repository.dart';

/// Cart state: selection, quantities, promo code, totals.
class CartViewModel extends GetxController {
  final CartRepository _cartRepository = Get.find<CartRepository>();

  final RxList<CartItemModel> items = <CartItemModel>[].obs;
  final RxList<String> selectedIds = <String>[].obs;
  final RxBool selectAll = true.obs;
  final RxString promoCode = ''.obs;
  final RxDouble promoDiscount = 0.0.obs;

  final double shippingFee = 10;

  @override
  void onInit() {
    super.onInit();
    items.assignAll(_cartRepository.items);
    selectedIds.assignAll(items.map((e) => e.id).toList());
    ever(_cartRepository.items, (_) => items.assignAll(_cartRepository.items));
  }

  double get subtotal => items
      .where((e) => selectedIds.contains(e.id))
      .fold(0, (sum, e) => sum + e.lineTotal);

  double get total => (subtotal + shippingFee - promoDiscount.value)
      .clamp(0.0, double.infinity)
      .toDouble();

  bool isSelected(CartItemModel item) => selectedIds.contains(item.id);

  void toggleItem(CartItemModel item) {
    if (selectedIds.contains(item.id)) {
      selectedIds.remove(item.id);
    } else {
      selectedIds.add(item.id);
    }
    selectAll.value = selectedIds.length == items.length;
  }

  void toggleSelectAll() {
    if (selectAll.value) {
      selectedIds.clear();
      selectAll.value = false;
    } else {
      selectedIds.assignAll(items.map((e) => e.id).toList());
      selectAll.value = true;
    }
  }

  void increase(CartItemModel item) => _cartRepository.updateQuantity(item, 1);
  void decrease(CartItemModel item) => _cartRepository.updateQuantity(item, -1);

  void deleteItem(CartItemModel item) {
    _cartRepository.remove(item);
    selectedIds.remove(item.id);
  }

  void deleteSelected() {
    final toRemove = items.where((e) => selectedIds.contains(e.id)).toList();
    for (final item in toRemove) {
      _cartRepository.remove(item);
    }
    selectedIds.clear();
  }

  void applyPromo(String code) {
    promoCode.value = code.trim();
    if (promoCode.value.toUpperCase() == 'SAVE10') {
      promoDiscount.value = 10;
      Get.snackbar('Promo applied', 'You saved \$10 with code SAVE10',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12));
    } else {
      promoDiscount.value = 0;
      Get.snackbar('Invalid promo', 'Try SAVE10',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12));
    }
  }

  void checkout() {
    if (selectedIds.isEmpty) {
      Get.snackbar('Cart is empty', 'Select at least one item',
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12));
      return;
    }
    Get.toNamed(AppRoutes.checkout);
  }
}
