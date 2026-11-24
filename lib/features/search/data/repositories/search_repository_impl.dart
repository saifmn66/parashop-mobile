import '../../../products/domain/entities/product_entity.dart';
import '../../../products/domain/repositories/product_repository.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_local_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl(this._productRepository, this._localDataSource);

  final ProductRepository _productRepository;
  final SearchLocalDataSource _localDataSource;

  @override
  List<ProductEntity> search(String query) =>
      _productRepository.searchProducts(query);

  @override
  List<String> getRecentSearches() => _localDataSource.getRecentSearches();

  @override
  List<String> getPopularSearches() => _localDataSource.getPopularSearches();

  @override
  Future<List<String>> addRecentSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return getRecentSearches();
    final list = getRecentSearches().toList();
    list.removeWhere((e) => e.toLowerCase() == trimmed.toLowerCase());
    list.insert(0, trimmed);
    if (list.length > 8) list.removeRange(8, list.length);
    return _localDataSource.saveRecentSearches(list);
  }

  @override
  Future<List<String>> removeRecentSearch(String query) async {
    final list = getRecentSearches().where((e) => e != query).toList();
    return _localDataSource.saveRecentSearches(list);
  }

  @override
  Future<void> clearRecentSearches() async {
    await _localDataSource.saveRecentSearches(const []);
  }
}
