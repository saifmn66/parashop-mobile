import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl(this._localDataSource);

  final FavoritesLocalDataSource _localDataSource;

  @override
  Set<String> getFavoriteIds() => _localDataSource.getFavoriteIds();

  @override
  Future<Set<String>> toggleFavorite(String productId) async {
    final ids = _localDataSource.getFavoriteIds().toSet();
    if (!ids.add(productId)) {
      ids.remove(productId);
    }
    await _localDataSource.saveFavoriteIds(ids);
    return ids;
  }
}
