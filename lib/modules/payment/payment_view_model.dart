import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
// import '../../data/repositories/cart_repository.dart';
import '../checkout/checkout_view_model.dart';

/// Payment step state: method selection + card form + pay.
class PaymentViewModel extends GetxController {
  /// Lazily resolves the checkout wizard (also reachable from Profile).
  final CheckoutViewModel checkout = Get.isRegistered<CheckoutViewModel>()
      ? Get.find<CheckoutViewModel>()
      : Get.put(CheckoutViewModel());
  // final CartRepository _cartRepository = Get.find<CartRepository>();

  final GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();

  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expiry = TextEditingController();
  final TextEditingController cvv = TextEditingController();
  final TextEditingController cardHolder = TextEditingController();

  final RxInt selectedMethod = 0.obs;
  final RxBool saveCard = true.obs;
  final RxBool isLoading = false.obs;

  final List<Map<String, dynamic>> methods = [
    {
      'title': 'Credit / Debit Card',
      'subtitle': 'Visa, Mastercard',
      'icon': Icons.credit_card_rounded,
    },
    {
      'title': 'Bank Transfer',
      'subtitle': 'BCEL, LDB, etc.',
      'icon': Icons.account_balance_rounded,
    },
    {
      'title': 'E-Wallet',
      'subtitle': 'LDB One, etc.',
      'icon': Icons.account_balance_wallet_rounded,
    },
    {
      'title': 'Cash on Delivery',
      'subtitle': 'Pay when you receive',
      'icon': Icons.payments_rounded,
    },
  ];

  double get amount => checkout.total;
  String get amountLabel => amount.toStringAsFixed(0);

  bool get isCardMethod => selectedMethod.value == 0;

  void selectMethod(int index) => selectedMethod.value = index;
  void toggleSaveCard(bool? value) => saveCard.value = value ?? true;

  Future<void> pay() async {
    if (isCardMethod && !(cardFormKey.currentState?.validate() ?? false)) {
      return;
    }
    isLoading.value = true;
    try {
      final order = await checkout.placeOrder();
      // Reset the stack to Home, then open the new order detail.
      Get.offNamedUntil(AppRoutes.home, (route) => false);
      Get.toNamed(AppRoutes.orderDetail, arguments: order);
      Get.snackbar(
        'Payment successful',
        'Order ${order.id} has been placed.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        backgroundColor: Colors.green.withOpacity(0.12),
      );
    } catch (e) {
      Get.snackbar('Payment failed', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    cardNumber.dispose();
    expiry.dispose();
    cvv.dispose();
    cardHolder.dispose();
    super.onClose();
  }
}
