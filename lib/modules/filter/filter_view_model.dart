import 'package:get/get.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

/// Filter bottom-sheet/screen state: category, brand, price, size, color.
class FilterViewModel extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  final RxString selectedCategory = 'All'.obs;
  final RxList<String> selectedBrands = <String>[].obs;
  final RxDouble minPrice = 50.0.obs;
  final RxDouble maxPrice = 300.0.obs;
  final RxDouble selectedSize = 9.0.obs;
  final RxInt selectedColor = 0.obs;

  final RxList<BrandModel> brands = <BrandModel>[].obs;

  final List<String> categories = [
    'All',
    'Running',
    'Casual',
    'Basketball',
    'Training',
    'Lifestyle',
  ];

  final List<double> sizes = [6, 7, 8, 9, 10, 11, 12];

  @override
  void onInit() {
    super.onInit();
    _loadBrands();
  }

  Future<void> _loadBrands() async {
    final data = await _productRepository.getBrands();
    brands.assignAll(data);
  }

  void selectCategory(String category) => selectedCategory.value = category;

  void toggleBrand(String brand) {
    if (selectedBrands.contains(brand)) {
      selectedBrands.remove(brand);
    } else {
      selectedBrands.add(brand);
    }
  }

  void setPriceRange(double min, double max) {
    minPrice.value = min;
    maxPrice.value = max;
  }

  void selectSize(double size) => selectedSize.value = size;
  void selectColor(int index) => selectedColor.value = index;

  void reset() {
    selectedCategory.value = 'All';
    selectedBrands.clear();
    minPrice.value = 50;
    maxPrice.value = 300;
    selectedSize.value = 9;
    selectedColor.value = 0;
  }

  void apply() {
    Get.back(result: {
      'category': selectedCategory.value,
      'brands': selectedBrands.toList(),
      'minPrice': minPrice.value,
      'maxPrice': maxPrice.value,
      'size': selectedSize.value,
      'color': selectedColor.value,
    });
  }
}
