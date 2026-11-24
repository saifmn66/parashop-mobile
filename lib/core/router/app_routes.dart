class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signIn = '/auth/sign-in';
  static const String signUp = '/auth/sign-up';
  static const String forgotPassword = '/auth/forgot-password';
  static const String main = '/main';

  // Catalog & Products
  static const String productList = '/products';
  static const String productDetail = '/products/detail';
  static const String search = '/search';
  static const String basket = '/basket';

  // Commerce & Account
  static const String checkout = '/checkout';
  static const String favorites = '/favorites';
  static const String orders = '/orders';
  static const String orderDetail = '/orders/detail';
  static const String notifications = '/notifications';
  static const String editProfile = '/profile/edit';
  static const String addresses = '/profile/addresses';
  static const String settings = '/profile/settings';
  static const String about = '/profile/about';
}
