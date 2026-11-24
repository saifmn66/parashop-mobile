import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/router/main_shell.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/controllers/auth_bloc.dart';
import '../../../basket/presentation/controllers/basket_cubit.dart';
import '../../../favorites/presentation/controllers/favorites_cubit.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/pages/product_list_page.dart';
import '../controllers/home_cubit.dart';
import '../widgets/home_banner_carousel.dart';
import '../widgets/home_category_row.dart';
import '../widgets/home_header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openProductList(
    BuildContext context, {
    required String title,
    ProductFilter filter = const ProductFilter(),
  }) {
    Navigator.of(context).pushNamed(
      AppRoutes.productList,
      arguments: ProductListPageArgs(title: title, initialFilter: filter),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => sl<HomeCubit>(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final theme = Theme.of(context);
          final scheme = theme.colorScheme;
          final user = context.watch<AuthBloc>().state.user;
          final basketCount = context.watch<BasketCubit>().state.totalCount;
          final favIds = context.watch<FavoritesCubit>().state.favoriteIds;
          final feed = state.feed;

          final bestForYou = [
            ...feed.bestSellers,
            ...feed.recommended.where(
              (p) => !feed.bestSellers.any((b) => b.id == p.id),
            ),
          ].take(8).toList();

          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async => context.read<HomeCubit>().refresh(),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // 1. Minimal header: avatar, rounded search, basket, notifications
                    SliverToBoxAdapter(
                      child: AnimatedFadeSlide(
                        child: HomeHeaderWidget(
                          initials: user?.initials ?? 'P',
                          basketCount: basketCount,
                          onAvatarTap: () => MainShell.of(context)?.switchTab(3),
                          onSearchTap: () =>
                              Navigator.of(context).pushNamed(AppRoutes.search),
                          onBasketTap: () =>
                              Navigator.of(context).pushNamed(AppRoutes.basket),
                          onNotificationTap: () => context.showAppSnackBar(
                            'You are all caught up on notifications.',
                          ),
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 8)),

                    // 2. Editorial serif promotional banner carousel
                    SliverToBoxAdapter(
                      child: AnimatedFadeSlide(
                        delay: const Duration(milliseconds: 50),
                        child: HomeBannerCarousel(
                          banners: feed.banners,
                          onBannerTap: (banner) => _openProductList(
                            context,
                            title: banner.ctaLabel,
                            filter: ProductFilter(
                              categoryId: banner.targetCategoryId,
                              onSaleOnly: banner.onSaleOnly,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 24)),

                    // 3. Four circular warm ivory category cards
                    SliverToBoxAdapter(
                      child: AnimatedFadeSlide(
                        delay: const Duration(milliseconds: 90),
                        child: HomeCategoryRow(
                          categories: feed.categories,
                          onCategoryTap: (cat) => _openProductList(
                            context,
                            title: cat.name,
                            filter: ProductFilter(categoryId: cat.id),
                          ),
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 28)),

                    // 4. "Best for You" heading + See All
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: AppSizes.screenInsets,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Expanded(
                              child: Text(
                                'Best for You',
                                style: AppText.editorialDisplay(
                                  fontSize: 24,
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  MainShell.of(context)?.switchTab(1),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'See All',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SliverToBoxAdapter(child: SizedBox(height: 14)),

                    // 5. Two-column warm beige product grid
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSizes.screenPadding,
                        0,
                        AppSizes.screenPadding,
                        AppSizes.xl,
                      ),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: context.isTablet ? 3 : 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.67,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = bestForYou[index];
                            final tag = 'home-best-${product.id}';
                            return AnimatedFadeSlide(
                              delay: Duration(milliseconds: (index % 4) * 45),
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
                          childCount: bestForYou.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
