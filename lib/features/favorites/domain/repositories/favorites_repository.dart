abstract class FavoritesRepository {
  Set<String> getFavoriteIds();
  Future<Set<String>> toggleFavorite(String productId);
}
