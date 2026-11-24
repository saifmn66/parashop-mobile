import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/usecases/get_categories_usecase.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    required this.categories,
    this.selectedCategoryId,
  });

  final List<CategoryEntity> categories;
  final String? selectedCategoryId;

  CategoryEntity? get selectedCategory {
    if (selectedCategoryId == null) return null;
    for (final c in categories) {
      if (c.id == selectedCategoryId) return c;
    }
    return null;
  }

  CategoriesState copyWith({
    List<CategoryEntity>? categories,
    String? selectedCategoryId,
    bool clearSelection = false,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      selectedCategoryId: clearSelection
          ? null
          : (selectedCategoryId ?? this.selectedCategoryId),
    );
  }

  @override
  List<Object?> get props => [categories, selectedCategoryId];
}

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(GetCategoriesUseCase getCategories)
      : super(CategoriesState(categories: getCategories()));

  void selectCategory(String? id) {
    if (id == state.selectedCategoryId) {
      emit(state.copyWith(clearSelection: true));
    } else {
      emit(state.copyWith(selectedCategoryId: id));
    }
  }
}
