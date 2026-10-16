import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

/// Categories grid state.
class CategoriesViewModel extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    final data = await _productRepository.getCategories();
    categories.assignAll(data);
    isLoading.value = false;
  }

  void openCategory(CategoryModel category) {
    Get.toNamed(AppRoutes.productList, arguments: {
      'title': category.name,
      'category': category.name,
    });
  }
}
