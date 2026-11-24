import '../entities/category_entity.dart';

abstract class CategoryRepository {
  List<CategoryEntity> getCategories();
}
