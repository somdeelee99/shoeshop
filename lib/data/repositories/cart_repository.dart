import 'package:get/get.dart';

import '../mock/mock_data.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../providers/api_provider.dart';

/// Cart repository. In mock mode the cart is an in-memory store
/// exposed as a reactive list so the badge updates app-wide.
class CartRepository {
  final RxList<CartItemModel> items = <CartItemModel>[].obs;
  final RxList<CartItemModel> wishlist = <CartItemModel>[].obs;

  CartRepository() {
    items.assignAll(MockData.cartItems);
    wishlist.assignAll(
      MockData.products
          .where((p) => p.isWishlisted)
          .map((p) => CartItemModel(
                id: 'w-${p.id}',
                product: p,
                size: p.sizes.isEmpty ? 9 : p.sizes.first,
                colorValue: p.colors.isEmpty ? 0xFF17171B : p.colors.first,
              ))
          .toList(),
    );
  }

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.lineTotal);

  int get count => items.fold(0, (sum, item) => sum + item.quantity);

  CartItemModel? _findLine(ProductModel product, double size) {
    for (final item in items) {
      if (item.product.id == product.id && item.size == size) return item;
    }
    return null;
  }

  Future<void> addToCart(ProductModel product,
      {double size = 9, int colorValue = 0xFF17171B, int qty = 1}) async {
    final existing = _findLine(product, size);
    if (existing != null) {
      existing.quantity += qty;
      items.refresh();
    } else {
      items.add(CartItemModel(
        id: 'ci-${DateTime.now().microsecondsSinceEpoch}',
        product: product,
        size: size,
        colorValue: colorValue,
        quantity: qty,
      ));
    }
    if (!ApiProvider.useMock) {
      await ApiProvider.post('/cart', data: {
        'product_id': product.id,
        'size': size,
        'quantity': qty,
      });
    }
  }

  void updateQuantity(CartItemModel item, int delta) {
    item.quantity += delta;
    if (item.quantity < 1) item.quantity = 1;
    items.refresh();
  }

  void remove(CartItemModel item) {
    items.remove(item);
  }

  void clear() => items.clear();

  // ---------- Wishlist ----------
  bool isWishlisted(ProductModel product) {
    for (final item in wishlist) {
      if (item.product.id == product.id) return true;
    }
    return false;
  }

  void toggleWishlist(ProductModel product) {
    final index = wishlist.indexWhere((e) => e.product.id == product.id);
    if (index >= 0) {
      wishlist.removeAt(index);
    } else {
      wishlist.add(CartItemModel(
        id: 'w-${product.id}',
        product: product,
        size: product.sizes.isEmpty ? 9 : product.sizes.first,
        colorValue: product.colors.isEmpty ? 0xFF17171B : product.colors.first,
      ));
    }
    wishlist.refresh();
  }
}
