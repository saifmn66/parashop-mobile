import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../basket/presentation/controllers/basket_cubit.dart';
import '../../../favorites/presentation/controllers/favorites_cubit.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/product_usecases.dart';
import '../controllers/product_list_cubit.dart';
import '../widgets/product_filter_sheet.dart';

class ProductListPageArgs {
  const ProductListPageArgs({
    required this.title,
    this.initialFilter = const ProductFilter(),
  });

  final String title;
  final ProductFilter initialFilter;
}

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key, required this.args});

  final ProductListPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductListCubit>(
      create: (_) => ProductListCubit(
        getFilteredProducts: sl<GetFilteredProductsUseCase>(),
        initialFilter: args.initialFilter,
      ),
      child: _ProductListView(title: args.title),
    );
  }
}

class _ProductListView extends StatelessWidget {
  const _ProductListView({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return BlocBuilder<ProductListCubit, ProductListState>(
      builder: (context, state) {
        final favIds = context.watch<FavoritesCubit>().state.favoriteIds;
        final crossAxisCount = context.isTablet ? 3 : 2;

        return Scaffold(
          appBar: CustomAppBar(
            title: title,
            subtitle: '${state.products.length} products',
            actions: [
              IconButton(
                tooltip: 'Filter & Sort',
                onPressed: () async {
                  final updated = await ProductFilterSheet.show(
                    context,
                    initialFilter: state.filter,
                    availableBrands: sl<ProductRepository>().getAllBrands(),
                  );
                  if (updated != null && context.mounted) {
                    context.read<ProductListCubit>().applyFilter(updated);
                  }
                },
                icon: Badge(
                  isLabelVisible: state.filter.activeFilterCount > 0,
                  label: Text('${state.filter.activeFilterCount}'),
                  backgroundColor: scheme.primary,
                  child: const Icon(Icons.tune_rounded),
                ),
              ),
            ],
          ),
          body: state.products.isEmpty
              ? EmptyStateWidget(
                  icon: Icons.filter_alt_off_outlined,
                  title: 'No matching products',
                  description:
                      'Try adjusting your price range, brand filters, or sorting.',
                  actionLabel: 'Reset filters',
                  onActionTap: () =>
                      context.read<ProductListCubit>().resetFilters(),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(AppSizes.screenPadding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.67,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    final heroTag = 'list-${product.id}';
                    return AnimatedFadeSlide(
                      delay: Duration(milliseconds: (index % 6) * 45),
                      child: ProductCard(
                        id: product.id,
                        heroTag: heroTag,
                        name: product.name,
                        brand: product.brand,
                        imageUrl: product.primaryImage,
                        price: product.price,
                        originalPrice: product.originalPrice,
                        rating: product.rating,
                        reviewCount: product.reviewCount,
                        inStock: product.inStock,
                        badgeText: product.badgeText,
                        isFavorite: favIds.contains(product.id),
                        onTap: () => Navigator.of(context).pushNamed(
                          AppRoutes.productDetail,
                          arguments: (product, heroTag),
                        ),
                        onFavoriteTap: () =>
                            context.read<FavoritesCubit>().toggle(product.id),
                        onAddToBasketTap: () {
                          context.read<BasketCubit>().addProduct(product);
                          context.showAppSnackBar(
                            'Added ${product.name} to basket',
                          );
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
