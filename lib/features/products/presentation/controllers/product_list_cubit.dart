import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/product_usecases.dart';

class ProductListState extends Equatable {
  const ProductListState({
    required this.products,
    required this.filter,
    this.isLoading = false,
  });

  final List<ProductEntity> products;
  final ProductFilter filter;
  final bool isLoading;

  ProductListState copyWith({
    List<ProductEntity>? products,
    ProductFilter? filter,
    bool? isLoading,
  }) {
    return ProductListState(
      products: products ?? this.products,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [products, filter, isLoading];
}

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit({
    required this.getFilteredProducts,
    ProductFilter initialFilter = const ProductFilter(),
  }) : super(
          ProductListState(
            products: getFilteredProducts(initialFilter),
            filter: initialFilter,
          ),
        );

  final GetFilteredProductsUseCase getFilteredProducts;

  void applyFilter(ProductFilter filter) {
    emit(
      state.copyWith(
        filter: filter,
        products: getFilteredProducts(filter),
      ),
    );
  }

  void resetFilters() {
    final base = ProductFilter(categoryId: state.filter.categoryId);
    applyFilter(base);
  }
}
