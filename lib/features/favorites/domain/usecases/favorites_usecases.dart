import '../repositories/favorites_repository.dart';

class GetFavoriteIdsUseCase {
  const GetFavoriteIdsUseCase(this._repository);
  final FavoritesRepository _repository;
  Set<String> call() => _repository.getFavoriteIds();
}

class ToggleFavoriteUseCase {
  const ToggleFavoriteUseCase(this._repository);
  final FavoritesRepository _repository;
  Future<Set<String>> call(String productId) =>
      _repository.toggleFavorite(productId);
}
