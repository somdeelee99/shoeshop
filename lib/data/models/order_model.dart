import 'product_model.dart';
import 'user_model.dart';

enum OrderStatus { processing, shipping, completed, cancelled }

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipping:
        return 'Shipping';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  int get colorValue {
    switch (this) {
      case OrderStatus.processing:
        return 0xFFF97316;
      case OrderStatus.shipping:
        return 0xFF3B82F6;
      case OrderStatus.completed:
        return 0xFF22C55E;
      case OrderStatus.cancelled:
        return 0xFFE63946;
    }
  }

  static OrderStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'shipping':
        return OrderStatus.shipping;
      case 'completed':
        return OrderStatus.completed;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.processing;
    }
  }
}

class OrderItemModel {
  final ProductModel product;
  final double size;
  final int quantity;

  const OrderItemModel({
    required this.product,
    required this.size,
    required this.quantity,
  });

  double get lineTotal => product.price * quantity;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      OrderItemModel(
        product:
            ProductModel.fromJson(json['product'] as Map<String, dynamic>),
        size: (json['size'] as num? ?? 0).toDouble(),
        quantity: json['quantity'] as int? ?? 1,
      );

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'size': size,
        'quantity': quantity,
      };
}

class OrderModel {
  final String id;
  final DateTime placedAt;
  final OrderStatus status;
  final List<OrderItemModel> items;
  final AddressModel shippingAddress;
  final String shippingMethod;
  final double shippingFee;
  final double total;

  const OrderModel({
    required this.id,
    required this.placedAt,
    required this.status,
    required this.items,
    required this.shippingAddress,
    this.shippingMethod = 'Standard Delivery',
    this.shippingFee = 10,
    required this.total,
  });

  int get itemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  /// 0 = Placed, 1 = Processing, 2 = Shipping, 3 = Delivered.
  int get timelineIndex {
    switch (status) {
      case OrderStatus.processing:
        return 1;
      case OrderStatus.shipping:
        return 2;
      case OrderStatus.completed:
        return 3;
      case OrderStatus.cancelled:
        return 1;
    }
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String? ?? '',
        placedAt: DateTime.parse(json['placed_at'] as String),
        status: OrderStatusX.fromString(json['status'] as String? ?? ''),
        items: (json['items'] as List<dynamic>? ?? [])
            .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        shippingAddress: AddressModel.fromJson(
            json['shipping_address'] as Map<String, dynamic>),
        shippingMethod: json['shipping_method'] as String? ?? 'Standard',
        shippingFee: (json['shipping_fee'] as num? ?? 0).toDouble(),
        total: (json['total'] as num? ?? 0).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'placed_at': placedAt.toIso8601String(),
        'status': status.name,
        'items': items.map((e) => e.toJson()).toList(),
        'shipping_address': shippingAddress.toJson(),
        'shipping_method': shippingMethod,
        'shipping_fee': shippingFee,
        'total': total,
      };
}
