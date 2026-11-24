import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../basket/presentation/controllers/basket_cubit.dart';
import '../../../categories/domain/usecases/get_categories_usecase.dart';
import '../../../favorites/presentation/controllers/favorites_cubit.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/product_usecases.dart';
import '../controllers/product_list_cubit.dart';
import '../widgets/product_filter_sheet.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductListCubit>(
      create: (_) => ProductListCubit(
        getFilteredProducts: sl<GetFilteredProductsUseCase>(),
      ),
      child: const _ShopView(),
    );
  }
}

class _ShopView extends StatelessWidget {
  const _ShopView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final categories = sl<GetCategoriesUseCase>()();
    final favIds = context.watch<FavoritesCubit>().state.favoriteIds;
    final basketCount = context.watch<BasketCubit>().state.totalCount;

    return BlocBuilder<ProductListCubit, ProductListState>(
      builder: (context, state) {
        final cubit = context.read<ProductListCubit>();
        final selectedCategoryId = state.filter.categoryId;

        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Editorial Serif "Shop" Header + Search, Filter, Basket icons
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.screenPadding,
                    AppSizes.sm,
                    AppSizes.screenPadding - 4,
                    AppSizes.xs,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Shop',
                        style: AppText.editorialDisplay(
                          fontSize: 30,
                          color: scheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Search',
                        onPressed: () =>
                            Navigator.of(context).pushNamed(AppRoutes.search),
                        icon: Icon(
                          Icons.search_rounded,
                          color: scheme.onSurface,
                          size: 23,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Filter & Sort',
                        onPressed: () async {
                          final updated = await ProductFilterSheet.show(
                            context,
                            initialFilter: state.filter,
                            availableBrands:
                                sl<ProductRepository>().getAllBrands(),
                          );
                          if (updated != null && context.mounted) {
                            cubit.applyFilter(updated);
                          }
                        },
                        icon: Badge(
                          isLabelVisible: state.filter.activeFilterCount > 0,
                          label: Text('${state.filter.activeFilterCount}'),
                          backgroundColor: scheme.primary,
                          child: Icon(
                            Icons.tune_rounded,
                            color: scheme.onSurface,
                            size: 22,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Basket',
                        onPressed: () =>
                            Navigator.of(context).pushNamed(AppRoutes.basket),
                        icon: Badge(
                          isLabelVisible: basketCount > 0,
                          label: Text('$basketCount'),
                          backgroundColor: isDark
                              ? AppColors.secondary
                              : AppColors.oliveDark,
                          textColor: isDark ? AppColors.primary : Colors.white,
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: scheme.onSurface,
                            size: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. Horizontally scrollable editorial category filter chips
                SizedBox(
                  height: 46,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: AppSizes.screenInsets,
                    itemCount: categories.length + 1,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isAll = index == 0;
                      final id = isAll ? null : categories[index - 1].id;
                      final label = isAll ? 'All' : categories[index - 1].name;
                      final selected = selectedCategoryId == id;

                      return GestureDetector(
                        onTap: () => cubit.applyFilter(
                          isAll
                              ? state.filter.copyWith(clearCategory: true)
                              : state.filter.copyWith(categoryId: id),
                        ),
                        child: AnimatedContainer(
                          duration: AppMotion.fast,
                          curve: AppMotion.curve,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? (isDark
                                    ? AppColors.secondary
                                    : AppColors.oliveDark)
                                : (isDark
                                    ? AppColors.darkBeigeCard
                                    : AppColors.beigeCard),
                            borderRadius: AppSizes.rPill,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            label,
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontSize: 13,
                              fontWeight:
                                  selected ? FontWeight.w600 : FontWeight.w500,
                              color: selected
                                  ? (isDark ? AppColors.primary : Colors.white)
                                  : scheme.onSurface,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 14),

                // 3. Two-column warm beige product grid
                Expanded(
                  child: state.products.isEmpty
                      ? EmptyStateWidget(
                          icon: Icons.filter_alt_off_outlined,
                          title: 'No products match',
                          description:
                              'Try switching categories or clearing your active filters.',
                          actionLabel: 'Reset filters',
                          onActionTap: cubit.resetFilters,
                        )
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(
                            AppSizes.screenPadding,
                            0,
                            AppSizes.screenPadding,
                            AppSizes.xl,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: context.isTablet ? 3 : 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.67,
                          ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            final tag = 'shop-${product.id}';
                            return AnimatedFadeSlide(
                              delay: Duration(milliseconds: (index % 6) * 40),
                              child: ProductCard(
                                id: product.id,
                                heroTag: tag,
                                name: product.name,
                                brand: product.brand,
                                subtitle: product.subcategory,
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
                                  arguments: (product, tag),
                                ),
                                onFavoriteTap: () => context
                                    .read<FavoritesCubit>()
                                    .toggle(product.id),
                                onAddToBasketTap: () {
                                  context
                                      .read<BasketCubit>()
                                      .addProduct(product);
                                  context.showAppSnackBar(
                                    'Added ${product.name} to cart',
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
