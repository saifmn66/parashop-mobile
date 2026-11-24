import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';
import '../../features/auth/presentation/controllers/auth_bloc.dart';
import '../../features/basket/data/datasources/basket_local_datasource.dart';
import '../../features/basket/data/repositories/basket_repository_impl.dart';
import '../../features/basket/domain/repositories/basket_repository.dart';
import '../../features/basket/domain/usecases/basket_usecases.dart';
import '../../features/basket/presentation/controllers/basket_cubit.dart';
import '../../features/categories/data/datasources/category_mock_datasource.dart';
import '../../features/categories/data/repositories/category_repository_impl.dart';
import '../../features/categories/domain/repositories/category_repository.dart';
import '../../features/categories/domain/usecases/get_categories_usecase.dart';
import '../../features/categories/presentation/controllers/categories_cubit.dart';
import '../../features/favorites/data/datasources/favorites_local_datasource.dart';
import '../../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../../features/favorites/domain/repositories/favorites_repository.dart';
import '../../features/favorites/domain/usecases/favorites_usecases.dart';
import '../../features/favorites/presentation/controllers/favorites_cubit.dart';
import '../../features/home/data/datasources/home_mock_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_feed_usecase.dart';
import '../../features/home/presentation/controllers/home_cubit.dart';
import '../../features/onboarding/data/datasources/onboarding_local_datasource.dart';
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/onboarding_usecases.dart';
import '../../features/onboarding/presentation/controllers/onboarding_cubit.dart';
import '../../features/products/data/datasources/product_mock_datasource.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/domain/usecases/product_usecases.dart';
import '../../features/profile/data/datasources/profile_local_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/profile_usecases.dart';
import '../../features/profile/presentation/controllers/profile_cubit.dart';
import '../../features/search/data/datasources/search_local_datasource.dart';
import '../../features/search/data/repositories/search_repository_impl.dart';
import '../../features/search/domain/repositories/search_repository.dart';
import '../../features/search/domain/usecases/search_usecases.dart';
import '../../features/search/presentation/controllers/search_cubit.dart';
import '../network/api_client.dart';
import '../services/local_storage_service.dart';
import '../theme/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core services
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(sl()),
  );
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl()));

  // Onboarding
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSource(sl()),
  );
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetOnboardingStepsUseCase(sl()));
  sl.registerLazySingleton(() => CompleteOnboardingUseCase(sl()));
  sl.registerFactory(
    () => OnboardingCubit(
      getSteps: sl(),
      completeOnboarding: sl(),
    ),
  );

  // Auth
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SocialSignInUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(
    () => AuthBloc(
      getCurrentUser: sl(),
      signIn: sl(),
      signUp: sl(),
      socialSignIn: sl(),
      forgotPassword: sl(),
      updateProfile: sl(),
      signOut: sl(),
    ),
  );

  // Products
  sl.registerLazySingleton<ProductMockDataSource>(
    () => const ProductMockDataSource(),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => GetAllProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetFilteredProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductByIdUseCase(sl()));
  sl.registerLazySingleton(() => GetRelatedProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetRecentlyViewedUseCase(sl()));
  sl.registerLazySingleton(() => MarkProductViewedUseCase(sl()));

  // Categories
  sl.registerLazySingleton<CategoryMockDataSource>(
    () => const CategoryMockDataSource(),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerFactory(() => CategoriesCubit(sl()));

  // Home
  sl.registerLazySingleton<HomeMockDataSource>(() => const HomeMockDataSource());
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton(
    () => GetHomeFeedUseCase(
      homeRepository: sl(),
      categoryRepository: sl(),
      productRepository: sl(),
    ),
  );
  sl.registerFactory(() => HomeCubit(sl()));

  // Search
  sl.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSource(sl()),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton(() => SearchProductsUseCase(sl()));
  sl.registerLazySingleton(() => ManageRecentSearchesUseCase(sl()));
  sl.registerFactory(
    () => SearchCubit(
      searchProducts: sl(),
      recentSearchesUseCase: sl(),
    ),
  );

  // Favorites
  sl.registerLazySingleton<FavoritesLocalDataSource>(
    () => FavoritesLocalDataSource(sl()),
  );
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetFavoriteIdsUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavoriteUseCase(sl()));
  sl.registerLazySingleton(
    () => FavoritesCubit(
      getFavoriteIds: sl(),
      toggleFavoriteUseCase: sl(),
    ),
  );

  // Basket
  sl.registerLazySingleton<BasketLocalDataSource>(
    () => BasketLocalDataSource(sl()),
  );
  sl.registerLazySingleton<BasketRepository>(() => BasketRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoadBasketUseCase(sl()));
  sl.registerLazySingleton(() => PersistBasketUseCase(sl()));
  sl.registerLazySingleton(
    () => BasketCubit(
      loadBasket: sl(),
      persistBasket: sl(),
    ),
  );

  // Profile
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSource(sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => ManageAddressesUseCase(sl()));
  sl.registerLazySingleton(() => ManageProfilePreferencesUseCase(sl()));
  sl.registerLazySingleton(
    () => ProfileCubit(
      manageAddresses: sl(),
      managePreferences: sl(),
    ),
  );
}
