import 'package:get/get.dart';

import '../mock/mock_data.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';
import '../providers/api_provider.dart';
import '../providers/api_endpoints.dart';

/// Orders repository: history, detail, checkout.
class OrderRepository {
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  OrderRepository() {
    orders.assignAll(MockData.orders);
  }

  Future<List<OrderModel>> getOrders({OrderStatus? status}) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      if (status == null) return orders;
      return orders.where((o) => o.status == status).toList();
    }
    final response = await ApiProvider.get(
      ApiEndpoints.orders,
      query: {if (status != null) 'status': status.name},
    );
    return (response.data['data'] as List<dynamic>)
        .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<OrderModel> getOrderById(String id) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return orders.firstWhere((o) => o.id == id, orElse: () => orders.first);
    }
    final response = await ApiProvider.get('${ApiEndpoints.orders}/$id');
    return OrderModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  /// Creates an order from cart lines and returns the new order.
  Future<OrderModel> placeOrder({
    required List<CartItemModel> items,
    required AddressModel address,
    required String shippingMethod,
    required double shippingFee,
    required double total,
  }) async {
    final order = OrderModel(
      id: '#ORD${DateTime.now().millisecondsSinceEpoch}',
      placedAt: DateTime.now(),
      status: OrderStatus.processing,
      items: items
          .map((e) => OrderItemModel(
                product: e.product,
                size: e.size,
                quantity: e.quantity,
              ))
          .toList(),
      shippingAddress: address,
      shippingMethod: shippingMethod,
      shippingFee: shippingFee,
      total: total,
    );

    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 1200));
      orders.insert(0, order);
      return order;
    }

    final response = await ApiProvider.post(
      ApiEndpoints.checkout,
      data: order.toJson(),
    );
    final created =
        OrderModel.fromJson(response.data['data'] as Map<String, dynamic>);
    orders.insert(0, created);
    return created;
  }

  Future<void> cancelOrder(String id) async {
    if (ApiProvider.useMock) {
      final index = orders.indexWhere((o) => o.id == id);
      if (index >= 0) {
        final old = orders[index];
        orders[index] = OrderModel(
          id: old.id,
          placedAt: old.placedAt,
          status: OrderStatus.cancelled,
          items: old.items,
          shippingAddress: old.shippingAddress,
          shippingMethod: old.shippingMethod,
          shippingFee: old.shippingFee,
          total: old.total,
        );
        orders.refresh();
      }
      return;
    }
    await ApiProvider.post('${ApiEndpoints.orders}/$id/cancel');
  }
}
