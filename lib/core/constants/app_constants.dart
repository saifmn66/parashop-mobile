class AppConstants {
  AppConstants._();

  static const String appName = 'ParaShop';
  static const String appTagline = 'Curated Parapharmacy & Clinical Skincare';
  static const String appVersion = '1.0.0';

  // Currency & commerce defaults
  static const String currencySymbol = '€';
  static const double freeDeliveryThreshold = 49.0;
  static const double standardDeliveryFee = 4.90;
  static const double expressDeliveryFee = 9.90;

  // Promo codes (code -> discount percentage 0..1)
  static const Map<String, double> promoCodes = {
    'WELCOME10': 0.10,
    'PARA15': 0.15,
    'SKIN20': 0.20,
  };

  // Local storage keys
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keyThemeMode = 'theme_mode';
  static const String keyAuthUser = 'auth_user';
  static const String keyRememberMe = 'remember_me';
  static const String keyRecentSearches = 'recent_searches';
  static const String keyFavoriteIds = 'favorite_ids';
  static const String keyBasketItems = 'basket_items';
  static const String keySavedForLater = 'saved_for_later';
  static const String keyOrders = 'orders';
  static const String keyAddresses = 'addresses';
  static const String keyReadNotifications = 'read_notifications';
  static const String keyLanguageCode = 'language_code';
  static const String keyNotificationPrefs = 'notification_prefs';
  static const String keyRecentlyViewedIds = 'recently_viewed_ids';
}
