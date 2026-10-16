import 'package:get/get.dart';

import '../../data/models/order_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/order_repository.dart';

/// Single order detail + tracking timeline.
class OrderDetailViewModel extends GetxController {
  final OrderRepository _orderRepository = Get.find<OrderRepository>();

  late final Rx<OrderModel> order;

  final List<String> timelineLabels = [
    'Placed',
    'Processing',
    'Shipping',
    'Delivered',
  ];

  static const AddressModel _fallbackAddress = AddressModel(
    id: 'fallback',
    label: 'Home',
    street: '123 Main Street',
    city: 'Vientiane, Laos',
    phone: '+856 20 1234 5678',
  );

  @override
  void onInit() {
    super.onInit();
    order = Rx<OrderModel>(_resolveOrder());
  }

  OrderModel _resolveOrder() {
    final arg = Get.arguments;
    if (arg is OrderModel) return arg;

    if (arg is String) {
      for (final o in _orderRepository.orders) {
        if (o.id == arg) return o;
      }
    }
    if (_orderRepository.orders.isNotEmpty) {
      return _orderRepository.orders.first;
    }
    return OrderModel(
      id: '#ORD000',
      placedAt: DateTime.now(),
      status: OrderStatus.processing,
      items: const [],
      shippingAddress: _fallbackAddress,
      total: 0,
    );
  }

  int get timelineIndex => order.value.timelineIndex;

  Future<void> refreshOrder() async {
    final data = await _orderRepository.getOrderById(order.value.id);
    order.value = data;
  }

  Future<void> cancelOrder() async {
    await _orderRepository.cancelOrder(order.value.id);
    await refreshOrder();
    Get.back();
  }
}
