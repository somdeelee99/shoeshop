import '../mock/mock_data.dart';
import '../models/product_model.dart';
import '../providers/api_provider.dart';
import '../providers/api_endpoints.dart';

/// Catalog repository: products, categories, brands, banners.
class ProductRepository {
  Future<List<ProductModel>> getProducts({
    String? category,
    String? brand,
    double? minPrice,
    double? maxPrice,
    String? sortBy,
  }) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      var list = List<ProductModel>.from(MockData.products);
      if (category != null && category.toLowerCase() != 'all') {
        list = list
            .where((p) => p.category.toLowerCase() == category.toLowerCase())
            .toList();
      }
      if (brand != null && brand.toLowerCase() != 'all') {
        list = list
            .where((p) => p.brand.toLowerCase() == brand.toLowerCase())
            .toList();
      }
      if (minPrice != null) {
        list = list.where((p) => p.price >= minPrice).toList();
      }
      if (maxPrice != null) {
        list = list.where((p) => p.price <= maxPrice).toList();
      }
      return list;
    }

    final response = await ApiProvider.get(
      ApiEndpoints.products,
      query: {
        if (category != null) 'category': category,
        if (brand != null) 'brand': brand,
        if (minPrice != null) 'min_price': minPrice,
        if (maxPrice != null) 'max_price': maxPrice,
        if (sortBy != null) 'sort': sortBy,
      },
    );
    return (response.data['data'] as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductModel>> getFlashSale() async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      return MockData.flashSale;
    }
    final response = await ApiProvider.get(ApiEndpoints.flashSale);
    return (response.data['data'] as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ProductModel> getProductById(String id) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return MockData.productById(id);
    }
    final response = await ApiProvider.get('${ApiEndpoints.products}/$id');
    return ProductModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  Future<List<CategoryModel>> getCategories() async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
      return MockData.categories;
    }
    final response = await ApiProvider.get(ApiEndpoints.categories);
    return (response.data['data'] as List<dynamic>)
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<BrandModel>> getBrands() async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return MockData.brands;
    }
    final response = await ApiProvider.get(ApiEndpoints.brands);
    return (response.data['data'] as List<dynamic>)
        .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductModel>> search(String query) async {
    if (ApiProvider.useMock) {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      final q = query.toLowerCase();
      return MockData.products
          .where((p) =>
              p.name.toLowerCase().contains(q) ||
              p.brand.toLowerCase().contains(q) ||
              p.category.toLowerCase().contains(q))
          .toList();
    }
    final response =
        await ApiProvider.get(ApiEndpoints.products, query: {'q': query});
    return (response.data['data'] as List<dynamic>)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
