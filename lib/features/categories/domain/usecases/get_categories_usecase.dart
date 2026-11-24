import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetCategoriesUseCase {
  const GetCategoriesUseCase(this._repository);
  final CategoryRepository _repository;
  List<CategoryEntity> call() => _repository.getCategories();
}
