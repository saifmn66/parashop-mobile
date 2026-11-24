import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_mock_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._mockDataSource);

  final CategoryMockDataSource _mockDataSource;

  @override
  List<CategoryEntity> getCategories() => _mockDataSource.getCategories();
}
