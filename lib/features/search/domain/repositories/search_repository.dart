import '../../../products/domain/entities/product_entity.dart';

abstract class SearchRepository {
  List<ProductEntity> search(String query);
  List<String> getRecentSearches();
  List<String> getPopularSearches();
  Future<List<String>> addRecentSearch(String query);
  Future<List<String>> removeRecentSearch(String query);
  Future<void> clearRecentSearches();
}
