import '../../domain/entities/home_entities.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_mock_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._mockDataSource);

  final HomeMockDataSource _mockDataSource;

  @override
  List<PromoBannerEntity> getBanners() => _mockDataSource.getBanners();

  @override
  List<BrandEntity> getPopularBrands() => _mockDataSource.getPopularBrands();
}
