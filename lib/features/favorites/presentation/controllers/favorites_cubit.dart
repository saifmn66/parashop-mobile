import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/favorites_usecases.dart';

class FavoritesState extends Equatable {
  const FavoritesState({this.favoriteIds = const {}});

  final Set<String> favoriteIds;

  bool isFavorite(String productId) => favoriteIds.contains(productId);

  @override
  List<Object?> get props => [favoriteIds];
}

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({
    required GetFavoriteIdsUseCase getFavoriteIds,
    required this.toggleFavoriteUseCase,
  }) : super(FavoritesState(favoriteIds: getFavoriteIds()));

  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  Future<void> toggle(String productId) async {
    final updated = await toggleFavoriteUseCase(productId);
    emit(FavoritesState(favoriteIds: updated));
  }
}
