import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../data/models/misc_models.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/cart_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/user_repository.dart';

/// Home feed: banners, shortcuts, flash sale + search.
class HomeViewModel extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  final UserRepository _userRepository = Get.find<UserRepository>();
  final CartRepository _cartRepository = Get.find<CartRepository>();

  final TextEditingController searchController = TextEditingController();

  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final RxList<ProductModel> flashSale = <ProductModel>[].obs;
  final RxList<ProductModel> recommended = <ProductModel>[].obs;
  final RxInt bannerIndex = 0.obs;
  final RxBool isLoading = true.obs;

  int get cartCount => _cartRepository.count;
  int get unreadNotifications => _userRepository.unreadCount;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    banners.assignAll([
      const BannerModel(
        id: 'bn1',
        title: 'New Collection',
        subtitle: 'Nike Air Max',
        buttonText: 'Step Beyond',
        imageUrl:
            'https://images.unsplash.com/photo-1552346154-21d32810aba3'
            '?auto=format&fit=crop&w=1000&q=80',
      ),
      const BannerModel(
        id: 'bn2',
        title: 'Flash Sale',
        subtitle: 'Up to 40% Off',
        buttonText: 'Shop Now',
        imageUrl:
            'https://images.unsplash.com/photo-1549298916-b41d501d3772'
            '?auto=format&fit=crop&w=1000&q=80',
      ),
      const BannerModel(
        id: 'bn3',
        title: 'Premium Quality',
        subtitle: 'Trendy Collection',
        buttonText: 'Explore',
        imageUrl:
            'https://images.unsplash.com/photo-1491553895911-0055eca6402d'
            '?auto=format&fit=crop&w=1000&q=80',
      ),
    ]);

    final flash = await _productRepository.getFlashSale();
    final all = await _productRepository.getProducts();
    flashSale.assignAll(flash);
    recommended.assignAll(all);
    isLoading.value = false;
  }

  void onBannerChanged(int index) => bannerIndex.value = index;

  void openSearch() {
    final query = searchController.text.trim();
    Get.toNamed(AppRoutes.productList, arguments: {
      'title': query.isEmpty ? 'All Shoes' : 'Results for "$query"',
      'query': query,
    });
  }

  void openCategory(String category) {
    Get.toNamed(AppRoutes.productList, arguments: {
      'title': category,
      'category': category,
    });
  }

  void seeAllFlashSale() {
    Get.toNamed(AppRoutes.productList, arguments: {
      'title': 'Flash Sale',
      'flashSaleOnly': true,
    });
  }

  void openNotifications() => Get.toNamed(AppRoutes.notifications);

  void openCart() => Get.toNamed(AppRoutes.cart);

  void toggleWishlist(ProductModel product) =>
      _cartRepository.toggleWishlist(product);
}
