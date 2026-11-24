import '../../../products/domain/entities/product_entity.dart';
import '../repositories/search_repository.dart';

class SearchProductsUseCase {
  const SearchProductsUseCase(this._repository);
  final SearchRepository _repository;
  List<ProductEntity> call(String query) => _repository.search(query);
}

class ManageRecentSearchesUseCase {
  const ManageRecentSearchesUseCase(this._repository);
  final SearchRepository _repository;

  List<String> getRecent() => _repository.getRecentSearches();
  List<String> getPopular() => _repository.getPopularSearches();
  Future<List<String>> add(String query) => _repository.addRecentSearch(query);
  Future<List<String>> remove(String query) =>
      _repository.removeRecentSearch(query);
  Future<void> clear() => _repository.clearRecentSearches();
}
