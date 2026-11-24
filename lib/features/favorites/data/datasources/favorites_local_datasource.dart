import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';

class FavoritesLocalDataSource {
  const FavoritesLocalDataSource(this._storage);

  final LocalStorageService _storage;

  Set<String> getFavoriteIds() =>
      _storage.getStringList(AppConstants.keyFavoriteIds).toSet();

  Future<void> saveFavoriteIds(Set<String> ids) =>
      _storage.setStringList(AppConstants.keyFavoriteIds, ids.toList());
}
