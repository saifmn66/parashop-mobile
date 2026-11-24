import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../domain/usecases/search_usecases.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.results = const [],
    this.recentSearches = const [],
    this.popularSearches = const [],
    this.suggestions = const [],
  });

  final String query;
  final List<ProductEntity> results;
  final List<String> recentSearches;
  final List<String> popularSearches;
  final List<String> suggestions;

  bool get hasQuery => query.trim().isNotEmpty;

  SearchState copyWith({
    String? query,
    List<ProductEntity>? results,
    List<String>? recentSearches,
    List<String>? popularSearches,
    List<String>? suggestions,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      recentSearches: recentSearches ?? this.recentSearches,
      popularSearches: popularSearches ?? this.popularSearches,
      suggestions: suggestions ?? this.suggestions,
    );
  }

  @override
  List<Object?> get props => [
        query,
        results,
        recentSearches,
        popularSearches,
        suggestions,
      ];
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.searchProducts,
    required this.recentSearchesUseCase,
  }) : super(
          SearchState(
            recentSearches: recentSearchesUseCase.getRecent(),
            popularSearches: recentSearchesUseCase.getPopular(),
          ),
        );

  final SearchProductsUseCase searchProducts;
  final ManageRecentSearchesUseCase recentSearchesUseCase;

  void onQueryChanged(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      emit(state.copyWith(query: '', results: const [], suggestions: const []));
      return;
    }
    final matches = searchProducts(trimmed);
    final suggestions = <String>{
      ...state.popularSearches
          .where((s) => s.toLowerCase().contains(trimmed.toLowerCase())),
      ...matches.map((p) => p.brand),
      ...matches.map((p) => p.subcategory),
    }.take(5).toList();

    emit(state.copyWith(
      query: query,
      results: matches,
      suggestions: suggestions,
    ));
  }

  Future<void> submitSearch(String query) async {
    onQueryChanged(query);
    if (query.trim().isEmpty) return;
    final updated = await recentSearchesUseCase.add(query);
    emit(state.copyWith(recentSearches: updated));
  }

  Future<void> removeRecent(String term) async {
    final updated = await recentSearchesUseCase.remove(term);
    emit(state.copyWith(recentSearches: updated));
  }

  Future<void> clearRecent() async {
    await recentSearchesUseCase.clear();
    emit(state.copyWith(recentSearches: const []));
  }

  void clearQuery() {
    emit(state.copyWith(query: '', results: const [], suggestions: const []));
  }
}
