import '../../../categories/domain/entities/category_entity.dart';
import '../../../categories/domain/repositories/category_repository.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../entities/home_entities.dart';
import '../repositories/home_repository.dart';

class HomeFeedData {
  const HomeFeedData({
    required this.banners,
    required this.categories,
    required this.bestSellers,
    required this.recommended,
    required this.newArrivals,
    required this.specialOffers,
    required this.popularBrands,
    required this.recentlyViewed,
  });

  final List<PromoBannerEntity> banners;
  final List<CategoryEntity> categories;
  final List<ProductEntity> bestSellers;
  final List<ProductEntity> recommended;
  final List<ProductEntity> newArrivals;
  final List<ProductEntity> specialOffers;
  final List<BrandEntity> popularBrands;
  final List<ProductEntity> recentlyViewed;
}

class GetHomeFeedUseCase {
  const GetHomeFeedUseCase({
    required this.homeRepository,
    required this.categoryRepository,
    required this.productRepository,
  });

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;

  HomeFeedData call() {
    final all = productRepository.getAllProducts();
    return HomeFeedData(
      banners: homeRepository.getBanners(),
      categories: categoryRepository.getCategories(),
      bestSellers: all.where((p) => p.isBestSeller).toList(),
      recommended: all.where((p) => p.isRecommended).toList(),
      newArrivals: all.where((p) => p.isNewArrival).toList(),
      specialOffers: all.where((p) => p.hasDiscount).toList(),
      popularBrands: homeRepository.getPopularBrands(),
      recentlyViewed: productRepository.getRecentlyViewed(),
    );
  }
}
