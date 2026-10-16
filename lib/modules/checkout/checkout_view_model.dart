import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../data/models/order_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/cart_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/user_repository.dart';

/// Checkout wizard state: address + shipping method (step 1 of 3).
class CheckoutViewModel extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  final CartRepository _cartRepository = Get.find<CartRepository>();
  final OrderRepository _orderRepository = Get.find<OrderRepository>();

  final RxInt currentStep = 0.obs;
  final RxInt selectedAddressIndex = 0.obs;
  final RxInt selectedShipping = 0.obs;

  final List<String> steps = ['Shipping', 'Payment', 'Review'];

  final List<Map<String, dynamic>> shippingMethods = [
    {'name': 'Standard Delivery', 'eta': '3-5 days', 'fee': 10.0},
    {'name': 'Express Delivery', 'eta': '1-2 days', 'fee': 20.0},
  ];

  List<AddressModel> get addresses => _userRepository.addresses;

  AddressModel get selectedAddress {
    if (addresses.isEmpty) return MockAddress.fallback;
    final index = selectedAddressIndex.value < 0
        ? 0
        : (selectedAddressIndex.value >= addresses.length
            ? addresses.length - 1
            : selectedAddressIndex.value);
    return addresses[index];
  }

  double get shippingFee =>
      (shippingMethods[selectedShipping.value]['fee'] as num).toDouble();

  double get subtotal => _cartRepository.subtotal;
  double get total => subtotal + shippingFee;

  void selectAddress(int index) => selectedAddressIndex.value = index;
  void selectShipping(int index) => selectedShipping.value = index;

  void addNewAddress() => Get.toNamed(AppRoutes.addresses);

  void continueToPayment() {
    currentStep.value = 1;
    Get.toNamed(AppRoutes.payment);
  }

  Future<OrderModel> placeOrder() async {
    final order = await _orderRepository.placeOrder(
      items: _cartRepository.items,
      address: selectedAddress,
      shippingMethod:
          shippingMethods[selectedShipping.value]['name'] as String,
      shippingFee: shippingFee,
      total: total,
    );
    _cartRepository.clear();
    return order;
  }
}

/// Fallback address when the user has none.
class MockAddress {
  static final AddressModel fallback = AddressModel(
    id: 'fallback',
    label: 'Home',
    street: '123 Main Street',
    city: 'Vientiane, Laos',
    phone: '+856 20 1234 5678',
  );
}
