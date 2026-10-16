import '../../core/constants/app_assets.dart';
import '../models/cart_model.dart';
import '../models/misc_models.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';

/// Offline demo dataset. Repositories fall back to this when the API is
/// not configured (ApiProvider.useMock == true).
class MockData {
  MockData._();

  // ---------------- User ----------------
  static final UserModel user = UserModel(
    id: 'u1',
    fullName: 'Somdee Lee',
    email: 'somdee@example.com',
    phone: '+856 20 1234 5678',
    avatarUrl: AppImages.avatar1,
    gender: 'Male',
    memberSince: DateTime(2024, 10, 1),
  );

  // ---------------- Addresses ----------------
  static final List<AddressModel> addresses = [
    AddressModel(
      id: 'a1',
      label: 'Home',
      street: '123 Main Street',
      city: 'Vientiane, Laos',
      phone: '+856 20 1234 5678',
      isDefault: true,
    ),
    AddressModel(
      id: 'a2',
      label: 'Office',
      street: 'Unit 5, Business Center',
      city: 'Vientiane, Laos',
      phone: '+856 20 9876 5432',
    ),
  ];

  // ---------------- Categories ----------------
  static final List<CategoryModel> categories = [
    const CategoryModel(
      id: 'c1',
      name: 'Running',
      iconPath: 'directions_run',
      colorValue: 0xFFEAF3FF,
      imageUrl: AppImages.running,
    ),
    const CategoryModel(
      id: 'c2',
      name: 'Casual',
      iconPath: 'checkroom',
      colorValue: 0xFFFFF1E5,
      imageUrl: AppImages.casual,
    ),
    const CategoryModel(
      id: 'c3',
      name: 'Basketball',
      iconPath: 'sports_basketball',
      colorValue: 0xFFF0E9FF,
      imageUrl: AppImages.basketball,
    ),
    const CategoryModel(
      id: 'c4',
      name: 'Training',
      iconPath: 'fitness_center',
      colorValue: 0xFFE9F9EF,
      imageUrl: AppImages.training,
    ),
    const CategoryModel(
      id: 'c5',
      name: 'Hiking',
      iconPath: 'terrain',
      colorValue: 0xFFFFEDEB,
      imageUrl: AppImages.hiking,
    ),
    const CategoryModel(
      id: 'c6',
      name: 'Kids',
      iconPath: 'child_care',
      colorValue: 0xFFFFF6DC,
      imageUrl: AppImages.kids,
    ),
    const CategoryModel(
      id: 'c7',
      name: 'Lifestyle',
      iconPath: 'local_cafe',
      colorValue: 0xFFE8F1FE,
      imageUrl: AppImages.lifestyle,
    ),
    const CategoryModel(
      id: 'c8',
      name: 'Brands',
      iconPath: 'storefront',
      colorValue: 0xFFF4F4F6,
      imageUrl: AppImages.whiteSneaker,
    ),
  ];

  // ---------------- Brands ----------------
  static const List<BrandModel> brands = [
    BrandModel(id: 'b1', name: 'Nike', logoUrl: ''),
    BrandModel(id: 'b2', name: 'Adidas', logoUrl: ''),
    BrandModel(id: 'b3', name: 'Puma', logoUrl: ''),
    BrandModel(id: 'b4', name: 'New Balance', logoUrl: ''),
    BrandModel(id: 'b5', name: 'Vans', logoUrl: ''),
    BrandModel(id: 'b6', name: 'Converse', logoUrl: ''),
    BrandModel(id: 'b7', name: 'Reebok', logoUrl: ''),
    BrandModel(id: 'b8', name: 'Fila', logoUrl: ''),
  ];

  // ---------------- Products ----------------
  static final List<ProductModel> products = [
    ProductModel(
      id: 'p1',
      name: 'Nike Air Jordan 1',
      brand: 'Nike',
      category: 'Basketball',
      price: 180,
      oldPrice: 220,
      rating: 4.8,
      reviewCount: 320,
      imageUrl: AppImages.airJordan,
      images: [
        AppImages.airJordan,
        AppImages.airMax270,
        AppImages.redSneaker,
        AppImages.whiteSneaker,
      ],
      sizes: const [7, 8, 9, 10, 11],
      colors: const [0xFF17171B, 0xFFE63B2E, 0xFFFFB020, 0xFFFFD700],
      description:
          'The Air Jordan 1 combines classic style with modern comfort. '
          'Perfect for everyday wear and sports.',
      isWishlisted: true,
      isFlashSale: true,
    ),
    ProductModel(
      id: 'p2',
      name: 'Adidas Ultraboost',
      brand: 'Adidas',
      category: 'Running',
      price: 150,
      oldPrice: 180,
      rating: 4.6,
      reviewCount: 280,
      imageUrl: AppImages.ultraboost,
      images: [AppImages.ultraboost, AppImages.whiteSneaker],
      sizes: const [7, 8, 9, 10, 11],
      colors: const [0xFFFFFFFF, 0xFF17171B, 0xFF3B82F6],
      description:
          'Responsive cushioning with a breathable knit upper. '
          'Built for runners who want energy return on every step.',
      isFlashSale: true,
    ),
    ProductModel(
      id: 'p3',
      name: 'Puma RS-X',
      brand: 'Puma',
      category: 'Lifestyle',
      price: 110,
      oldPrice: 140,
      rating: 4.5,
      reviewCount: 150,
      imageUrl: AppImages.rsx,
      images: [AppImages.rsx],
      sizes: const [6, 7, 8, 9, 10, 11],
      colors: const [0xFF3B82F6, 0xFF17171B],
      description:
          'Bold retro running design with chunky RS cushioning and '
          'mixed-material upper.',
      isWishlisted: true,
    ),
    ProductModel(
      id: 'p4',
      name: 'New Balance 574',
      brand: 'New Balance',
      category: 'Casual',
      price: 120,
      rating: 4.4,
      reviewCount: 98,
      imageUrl: AppImages.nb574,
      images: [AppImages.nb574],
      sizes: const [7, 8, 9, 10, 11, 12],
      colors: const [0xFF17171B, 0xFF8A8A8E],
      description:
          'An iconic silhouette with ENCAP midsole cushioning for '
          'all-day comfort.',
      isWishlisted: true,
    ),
    ProductModel(
      id: 'p5',
      name: 'Nike Air Max 270',
      brand: 'Nike',
      category: 'Running',
      price: 140,
      oldPrice: 200,
      rating: 4.8,
      reviewCount: 412,
      imageUrl: AppImages.airMax270,
      images: [AppImages.airMax270, AppImages.redSneaker],
      sizes: const [6, 7, 8, 9, 10, 11],
      colors: const [0xFFE63B2E, 0xFFFFFFFF, 0xFF17171B],
      description:
          'The Nike Air Max 270 delivers visible Air cushioning and '
          'all-day comfort.',
      isWishlisted: true,
      isFlashSale: true,
    ),
    ProductModel(
      id: 'p6',
      name: 'Adidas Samba',
      brand: 'Adidas',
      category: 'Casual',
      price: 100,
      rating: 4.6,
      reviewCount: 350,
      imageUrl: AppImages.samba,
      images: [AppImages.samba],
      sizes: const [6, 7, 8, 9, 10, 11],
      colors: const [0xFF17171B, 0xFFFFFFFF],
      description:
          'A timeless classic with soft leather upper and gum sole. '
          'A street-style favourite.',
      isWishlisted: true,
    ),
    ProductModel(
      id: 'p7',
      name: 'Nike Air Force 1',
      brand: 'Nike',
      category: 'Lifestyle',
      price: 120,
      rating: 4.8,
      reviewCount: 320,
      imageUrl: AppImages.airForce,
      images: [AppImages.airForce, AppImages.whiteSneaker],
      sizes: const [7, 8, 9, 10, 11],
      colors: const [0xFFFFFFFF, 0xFF17171B],
      description:
          'The radiance lives on. Crisp full-grain leather and Air '
          'cushioning for the streets.',
      isFlashSale: true,
    ),
    ProductModel(
      id: 'p8',
      name: 'Converse Chuck 70',
      brand: 'Converse',
      category: 'Casual',
      price: 85,
      oldPrice: 95,
      rating: 4.3,
      reviewCount: 76,
      imageUrl: AppImages.casual,
      images: [AppImages.casual],
      sizes: const [6, 7, 8, 9, 10, 11],
      colors: const [0xFF17171B, 0xFFE63B2E],
      description:
          'Vintage canvas high-top with enhanced cushioning and '
          'archival details.',
    ),
    ProductModel(
      id: 'p9',
      name: 'Trailblazer Hiking Boot',
      brand: 'Reebok',
      category: 'Hiking',
      price: 130,
      oldPrice: 160,
      rating: 4.2,
      reviewCount: 54,
      imageUrl: AppImages.hiking,
      images: [AppImages.hiking],
      sizes: const [7, 8, 9, 10, 11, 12],
      colors: const [0xFFA0522D, 0xFF17171B],
      description:
          'Waterproof hiking boot with aggressive outsole grip for '
          'any terrain.',
    ),
    ProductModel(
      id: 'p10',
      name: 'Kids Runner Flex',
      brand: 'Puma',
      category: 'Kids',
      price: 60,
      rating: 4.5,
      reviewCount: 41,
      imageUrl: AppImages.kids,
      images: [AppImages.kids],
      sizes: const [1, 2, 3, 4, 5, 6],
      colors: const [0xFFE63B2E, 0xFF3B82F6, 0xFFFFB020],
      description:
          'Lightweight and flexible shoes designed for active kids.',
    ),
    ProductModel(
      id: 'p11',
      name: 'Vans Old Skool',
      brand: 'Vans',
      category: 'Lifestyle',
      price: 75,
      rating: 4.7,
      reviewCount: 210,
      imageUrl: AppImages.redSneaker,
      images: [AppImages.redSneaker],
      sizes: const [6, 7, 8, 9, 10, 11],
      colors: const [0xFF17171B, 0xFFFFFFFF],
      description:
          'The classic side-stripe skate shoe with durable suede and '
          'canvas uppers.',
      isWishlisted: true,
    ),
    ProductModel(
      id: 'p12',
      name: 'Fila Disruptor II',
      brand: 'Fila',
      category: 'Training',
      price: 95,
      oldPrice: 115,
      rating: 4.1,
      reviewCount: 88,
      imageUrl: AppImages.training,
      images: [AppImages.training],
      sizes: const [6, 7, 8, 9, 10, 11],
      colors: const [0xFFFFFFFF, 0xFFE63B2E],
      description:
          'Chunky dad-shoe energy with lightweight EVA midsole.',
    ),
  ];

  // ---------------- Flash sale ----------------
  static List<ProductModel> get flashSale =>
      products.where((p) => p.isFlashSale).toList();

  // ---------------- Banners ----------------
  static final List<BannerModel> banners = [
    const BannerModel(
      id: 'bn1',
      title: 'New Collection',
      subtitle: 'Nike Air Max',
      buttonText: 'Step Beyond',
      imageUrl: AppImages.bannerAirMax,
    ),
    const BannerModel(
      id: 'bn2',
      title: 'Flash Sale',
      subtitle: 'Up to 40% Off',
      buttonText: 'Shop Now',
      imageUrl: AppImages.redSneaker,
    ),
    const BannerModel(
      id: 'bn3',
      title: 'Premium Quality',
      subtitle: 'Trendy Collection',
      buttonText: 'Explore',
      imageUrl: AppImages.whiteSneaker,
    ),
  ];

  // ---------------- Cart ----------------
  static final List<CartItemModel> cartItems = [
    CartItemModel(
      id: 'ci1',
      product: products[0],
      size: 8,
      colorValue: 0xFF17171B,
      quantity: 1,
    ),
    CartItemModel(
      id: 'ci2',
      product: products[1],
      size: 8,
      colorValue: 0xFFFFFFFF,
      quantity: 1,
    ),
    CartItemModel(
      id: 'ci3',
      product: products[2],
      size: 9,
      colorValue: 0xFF3B82F6,
      quantity: 1,
    ),
  ];

  // ---------------- Orders ----------------
  static final List<OrderModel> orders = [
    OrderModel(
      id: '#ORD20241015001',
      placedAt: DateTime(2024, 10, 15, 14, 30),
      status: OrderStatus.processing,
      items: [
        OrderItemModel(product: products[0], size: 9, quantity: 1),
        OrderItemModel(product: products[1], size: 8, quantity: 1),
      ],
      shippingAddress: addresses[0],
      shippingMethod: 'Standard Delivery',
      shippingFee: 10,
      total: 450,
    ),
    OrderModel(
      id: '#ORD20241010023',
      placedAt: DateTime(2024, 10, 10, 10, 12),
      status: OrderStatus.shipping,
      items: [
        OrderItemModel(product: products[4], size: 9, quantity: 1),
      ],
      shippingAddress: addresses[0],
      shippingMethod: 'Standard Delivery',
      shippingFee: 10,
      total: 120,
    ),
    OrderModel(
      id: '#ORD20241005018',
      placedAt: DateTime(2024, 10, 5, 10, 12),
      status: OrderStatus.completed,
      items: [
        OrderItemModel(product: products[6], size: 10, quantity: 1),
      ],
      shippingAddress: addresses[1],
      shippingMethod: 'Express Delivery',
      shippingFee: 20,
      total: 320,
    ),
    OrderModel(
      id: '#ORD20240928015',
      placedAt: DateTime(2024, 9, 28, 9, 40),
      status: OrderStatus.cancelled,
      items: [
        OrderItemModel(product: products[3], size: 8, quantity: 1),
      ],
      shippingAddress: addresses[0],
      shippingMethod: 'Standard Delivery',
      shippingFee: 10,
      total: 80,
    ),
    OrderModel(
      id: '#ORD20240920011',
      placedAt: DateTime(2024, 9, 20, 16, 5),
      status: OrderStatus.completed,
      items: [
        OrderItemModel(product: products[5], size: 9, quantity: 1),
        OrderItemModel(product: products[10], size: 8, quantity: 2),
      ],
      shippingAddress: addresses[0],
      shippingMethod: 'Standard Delivery',
      shippingFee: 10,
      total: 250,
    ),
  ];

  // ---------------- Notifications ----------------
  static final List<AppNotificationModel> notifications = [
    AppNotificationModel(
      id: 'n1',
      title: 'Order Shipped',
      body: 'Your order #ORD20241010023 has been shipped.',
      type: 'order',
      time: DateTime(2024, 10, 12, 9, 0),
    ),
    AppNotificationModel(
      id: 'n2',
      title: 'Special Offer',
      body: 'Up to 30% off on Nike shoes!',
      type: 'promo',
      time: DateTime(2024, 10, 11, 15, 30),
    ),
    AppNotificationModel(
      id: 'n3',
      title: 'Order Delivered',
      body: 'Your order #ORD20241005018 has been delivered.',
      type: 'order',
      time: DateTime(2024, 10, 7, 18, 20),
    ),
    AppNotificationModel(
      id: 'n4',
      title: 'New Arrivals',
      body: 'Check out our latest collection.',
      type: 'system',
      time: DateTime(2024, 10, 6, 8, 0),
    ),
  ];

  // ---------------- Chat ----------------
  static final List<ChatMessageModel> chatMessages = [
    ChatMessageModel(
      id: 'm1',
      text: 'Hello! How can we help you today?',
      isFromAdmin: true,
      sentAt: DateTime(2024, 10, 16, 9, 41),
    ),
    ChatMessageModel(
      id: 'm2',
      text: 'Do you have this shoe in size 42?',
      isFromAdmin: false,
      sentAt: DateTime(2024, 10, 16, 9, 56),
      attachment: null,
    ),
    ChatMessageModel(
      id: 'm3',
      text: 'Yes, it is available. You can place the order now.',
      isFromAdmin: true,
      sentAt: DateTime(2024, 10, 16, 10, 0),
    ),
    ChatMessageModel(
      id: 'm4',
      text: 'Can you tell me when it will be restocked in white?',
      isFromAdmin: false,
      sentAt: DateTime(2024, 10, 16, 10, 12),
    ),
    ChatMessageModel(
      id: 'm5',
      text: 'We expect it to be restocked next week. We will notify you '
          'when it is available.',
      isFromAdmin: true,
      sentAt: DateTime(2024, 10, 16, 10, 27),
    ),
    ChatMessageModel(
      id: 'm6',
      text: 'Thank you!',
      isFromAdmin: false,
      sentAt: DateTime(2024, 10, 16, 10, 38),
    ),
  ];

  // ---------------- Admin stats ----------------
  static const Map<String, dynamic> adminStats = {
    'total_orders': 320,
    'total_sales': 12540,
    'total_products': 1250,
    'orders_growth': 12.5,
    'sales_growth': 8.3,
    'products_growth': 4.1,
  };

  static const List<Map<String, dynamic>> salesOverview = [
    {'day': 'Mon', 'value': 0.4},
    {'day': 'Tue', 'value': 0.6},
    {'day': 'Wed', 'value': 0.5},
    {'day': 'Thu', 'value': 0.8},
    {'day': 'Fri', 'value': 0.7},
    {'day': 'Sat', 'value': 1.0},
    {'day': 'Sun', 'value': 0.65},
  ];

  static const List<Map<String, dynamic>> recentOrders = [
    {
      'id': '#1001',
      'customer': 'Somdee Lee',
      'amount': 450,
      'status': 'Processing',
    },
    {
      'id': '#1002',
      'customer': 'Anna K.',
      'amount': 120,
      'status': 'Shipping',
    },
    {
      'id': '#1003',
      'customer': 'Khamla S.',
      'amount': 320,
      'status': 'Completed',
    },
    {
      'id': '#1004',
      'customer': 'Peter M.',
      'amount': 80,
      'status': 'Completed',
    },
    {
      'id': '#1005',
      'customer': 'Noy V.',
      'amount': 250,
      'status': 'Processing',
    },
  ];

  static ProductModel productById(String id) =>
      products.firstWhere((p) => p.id == id, orElse: () => products.first);
}
