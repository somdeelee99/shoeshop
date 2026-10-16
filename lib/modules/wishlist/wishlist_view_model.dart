import 'package:get/get.dart';

import '../../data/models/cart_model.dart';
import '../../data/repositories/cart_repository.dart';

/// Wishlist state.
class WishlistViewModel extends GetxController {
  final CartRepository _cartRepository = Get.find<CartRepository>();

  RxList<CartItemModel> get items => _cartRepository.wishlist;

  void remove(CartItemModel item) =>
      _cartRepository.toggleWishlist(item.product);

  void moveToCart(CartItemModel item) {
    _cartRepository.addToCart(
      item.product,
      size: item.size,
      colorValue: item.colorValue,
    );
    _cartRepository.toggleWishlist(item.product);
  }
}
