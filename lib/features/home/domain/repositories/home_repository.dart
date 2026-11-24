import '../entities/home_entities.dart';

abstract class HomeRepository {
  List<PromoBannerEntity> getBanners();
  List<BrandEntity> getPopularBrands();
}
