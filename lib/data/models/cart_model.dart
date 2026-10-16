import 'product_model.dart';

/// A line item inside the shopping cart.
class CartItemModel {
  final String id;
  final ProductModel product;
  final double size;
  final int colorValue;
  int quantity;

  CartItemModel({
    required this.id,
    required this.product,
    required this.size,
    required this.colorValue,
    this.quantity = 1,
  });

  double get lineTotal => product.price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        id: json['id'] as String? ?? '',
        product:
            ProductModel.fromJson(json['product'] as Map<String, dynamic>),
        size: (json['size'] as num? ?? 0).toDouble(),
        colorValue: json['color_value'] as int? ?? 0xFF17171B,
        quantity: json['quantity'] as int? ?? 1,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'product': product.toJson(),
        'size': size,
        'color_value': colorValue,
        'quantity': quantity,
      };
}
