/// Catalog models: Product, Category, Brand.
class ProductModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final double price;
  final double? oldPrice;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final List<String> images;
  final List<double> sizes;
  final List<int> colors;
  final String description;
  final bool isWishlisted;
  final bool isFlashSale;
  final int stock;

  const ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    this.oldPrice,
    this.rating = 0,
    this.reviewCount = 0,
    required this.imageUrl,
    this.images = const [],
    this.sizes = const [],
    this.colors = const [],
    this.description = '',
    this.isWishlisted = false,
    this.isFlashSale = false,
    this.stock = 10,
  });

  int get discountPercent {
    if (oldPrice == null || oldPrice == 0 || oldPrice! <= price) return 0;
    return (((oldPrice! - price) / oldPrice!) * 100).round();
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        brand: json['brand'] as String? ?? '',
        category: json['category'] as String? ?? '',
        price: (json['price'] as num? ?? 0).toDouble(),
        oldPrice: (json['old_price'] as num?)?.toDouble(),
        rating: (json['rating'] as num? ?? 0).toDouble(),
        reviewCount: json['review_count'] as int? ?? 0,
        imageUrl: json['image_url'] as String? ?? '',
        images: (json['images'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        sizes: (json['sizes'] as List<dynamic>?)
                ?.map((e) => (e as num).toDouble())
                .toList() ??
            const [],
        colors:
            (json['colors'] as List<dynamic>?)?.map((e) => e as int).toList() ??
                const [],
        description: json['description'] as String? ?? '',
        isWishlisted: json['is_wishlisted'] as bool? ?? false,
        isFlashSale: json['is_flash_sale'] as bool? ?? false,
        stock: json['stock'] as int? ?? 10,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'brand': brand,
        'category': category,
        'price': price,
        'old_price': oldPrice,
        'rating': rating,
        'review_count': reviewCount,
        'image_url': imageUrl,
        'images': images,
        'sizes': sizes,
        'colors': colors,
        'description': description,
        'is_wishlisted': isWishlisted,
        'is_flash_sale': isFlashSale,
        'stock': stock,
      };

  ProductModel copyWith({
    double? price,
    double? oldPrice,
    bool? isWishlisted,
    int? stock,
    String? description,
  }) =>
      ProductModel(
        id: id,
        name: name,
        brand: brand,
        category: category,
        price: price ?? this.price,
        oldPrice: oldPrice ?? this.oldPrice,
        rating: rating,
        reviewCount: reviewCount,
        imageUrl: imageUrl,
        images: images,
        sizes: sizes,
        colors: colors,
        description: description ?? this.description,
        isWishlisted: isWishlisted ?? this.isWishlisted,
        isFlashSale: isFlashSale,
        stock: stock ?? this.stock,
      );
}

class CategoryModel {
  final String id;
  final String name;
  final String iconPath;
  final int colorValue;
  final String imageUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.colorValue,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        iconPath: json['icon_path'] as String? ?? '',
        colorValue: json['color_value'] as int? ?? 0xFFF4F4F6,
        imageUrl: json['image_url'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon_path': iconPath,
        'color_value': colorValue,
        'image_url': imageUrl,
      };
}

class BrandModel {
  final String id;
  final String name;
  final String logoUrl;

  const BrandModel({
    required this.id,
    required this.name,
    required this.logoUrl,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        logoUrl: json['logo_url'] as String? ?? '',
      );

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'logo_url': logoUrl};
}
