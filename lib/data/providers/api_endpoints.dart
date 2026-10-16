/// REST endpoint paths (relative to [ApiProvider.baseUrl]).
class ApiEndpoints {
  ApiEndpoints._();

  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String socialLogin = '/auth/social';
  static const String profile = '/users/me';
  static const String banners = '/banners';
  static const String categories = '/categories';
  static const String brands = '/brands';
  static const String products = '/products';
  static const String flashSale = '/products/flash-sale';
  static const String cart = '/cart';
  static const String checkout = '/orders/checkout';
  static const String orders = '/orders';
  static const String wishlist = '/wishlist';
  static const String addresses = '/addresses';
  static const String notifications = '/notifications';
  static const String chat = '/chat';
}
