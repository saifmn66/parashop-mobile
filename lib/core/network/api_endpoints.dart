class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.parashop.example/v1',
  );

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String forgotPassword = '/auth/forgot-password';
  static const String profile = '/auth/profile';

  // Catalog
  static const String products = '/products';
  static const String categories = '/categories';
  static const String search = '/products/search';
  static const String banners = '/promotions/banners';

  // Commerce
  static const String basket = '/basket';
  static const String favorites = '/favorites';
  static const String orders = '/orders';
  static const String addresses = '/addresses';
  static const String notifications = '/notifications';
}
