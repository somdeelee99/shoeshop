import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/cart_repository.dart';

/// Product details state: gallery, size/color selection, add to cart.
class ProductDetailsViewModel extends GetxController {
  final CartRepository _cartRepository = Get.find<CartRepository>();

  late final ProductModel product;

  final RxInt currentImage = 0.obs;
  final RxDouble selectedSize = 0.0.obs;
  final RxInt selectedColor = 0.obs;
  final RxInt quantity = 1.obs;
  final RxBool isWishlisted = false.obs;

  final PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    // Get.arguments must be a ProductModel (opened via a product card).
    // If the route is opened without valid arguments (deep link, hot
    // restart, back-navigation race), fall back to the first demo product
    // instead of crashing with an uninitialized `late` field.
    final dynamic args = Get.arguments;
    product = args is ProductModel ? args : MockData.products.first;
    selectedSize.value = product.sizes.isEmpty
        ? 9
        : product.sizes[product.sizes.length > 2 ? 2 : 0];
    selectedColor.value = 0;
    isWishlisted.value = _cartRepository.isWishlisted(product);
  }

  void onImageChanged(int index) => currentImage.value = index;

  void selectSize(double size) => selectedSize.value = size;
  void selectColor(int index) => selectedColor.value = index;

  void increaseQty() {
    if (quantity.value < product.stock) quantity.value++;
  }

  void decreaseQty() {
    if (quantity.value > 1) quantity.value--;
  }

  void toggleWishlist() {
    _cartRepository.toggleWishlist(product);
    isWishlisted.value = _cartRepository.isWishlisted(product);
  }

  void addToCart() {
    _cartRepository.addToCart(
      product,
      size: selectedSize.value,
      colorValue: product.colors.isEmpty
          ? 0xFF17171B
          : product.colors[selectedColor.value],
      qty: quantity.value,
    );
    Get.snackbar(
      'Added to cart',
      '${product.name} · Size ${selectedSize.value.toStringAsFixed(0)}',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      backgroundColor: Colors.green.withOpacity(0.12),
    );
  }

  void buyNow() {
    addToCart();
    Get.toNamed(AppRoutes.checkout);
  }

  void openCart() => Get.toNamed(AppRoutes.cart);

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
