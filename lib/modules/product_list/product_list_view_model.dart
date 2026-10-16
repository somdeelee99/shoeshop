import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

/// Product listing with tabs + filter integration.
class ProductListViewModel extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  late final String title;
  String? category;
  String? query;
  bool flashSaleOnly = false;

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<ProductModel> filtered = <ProductModel>[].obs;
  final RxString selectedTab = 'All'.obs;
  final RxBool isLoading = true.obs;

  final List<String> tabs = ['All', 'Men', 'Women', 'Kids', 'Sale'];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    title = args['title'] as String? ?? 'All Shoes';
    category = args['category'] as String?;
    query = args['query'] as String?;
    flashSaleOnly = args['flashSaleOnly'] as bool? ?? false;
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    List<ProductModel> data;
    if (query != null && query!.isNotEmpty) {
      data = await _productRepository.search(query!);
    } else if (category == 'Men' || category == 'Women') {
      // Shortcut chips: no gender split in demo catalog → show all.
      data = await _productRepository.getProducts();
    } else if (category == 'Sale') {
      data = await _productRepository.getProducts();
      data = data.where((p) => p.discountPercent > 0).toList();
    } else {
      data = await _productRepository.getProducts(category: category);
    }
    if (flashSaleOnly) {
      data = data.where((p) => p.isFlashSale).toList();
    }
    products.assignAll(data);
    applyTab();
    isLoading.value = false;
  }

  void selectTab(String tab) {
    selectedTab.value = tab;
    applyTab();
  }

  void applyTab() {
    final tab = selectedTab.value;
    var list = List<ProductModel>.from(products);
    switch (tab) {
      case 'Sale':
        list = list.where((p) => p.discountPercent > 0).toList();
        break;
      case 'Kids':
        list = list.where((p) => p.category == 'Kids').toList();
        break;
      case 'Men':
      case 'Women':
        // Demo: no gender attribute, show all.
        break;
    }
    filtered.assignAll(list);
  }

  void openFilter() async {
    final result = await Get.toNamed(AppRoutes.filter);
    if (result is Map<String, dynamic>) {
      final brands = (result['brands'] as List<dynamic>? ?? [])
          .map((e) => e as String)
          .toList();
      final maxPrice = (result['maxPrice'] as num?)?.toDouble();
      var list = List<ProductModel>.from(products);
      if (brands.isNotEmpty) {
        list = list.where((p) => brands.contains(p.brand)).toList();
      }
      if (maxPrice != null) {
        list = list.where((p) => p.price <= maxPrice).toList();
      }
      filtered.assignAll(list);
    }
  }
}
