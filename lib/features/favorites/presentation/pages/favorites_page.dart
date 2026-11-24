import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/router/main_shell.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../basket/presentation/controllers/basket_cubit.dart';
import '../../../products/domain/usecases/product_usecases.dart';
import '../controllers/favorites_cubit.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key, this.showBack = true});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final allProducts = sl<GetAllProductsUseCase>()();
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: showBack
          ? const CustomAppBar(title: 'Favorites')
          : AppBar(
              centerTitle: false,
              automaticallyImplyLeading: false,
              titleSpacing: AppSizes.screenPadding,
              title: Text(
                'Favorites',
                style: AppText.editorialDisplay(
                  fontSize: 28,
                  color: scheme.onSurface,
                ),
              ),
            ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          final favProducts = allProducts
              .where((p) => state.favoriteIds.contains(p.id))
              .toList();

          if (favProducts.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.favorite_border_rounded,
              title: 'No favorites yet',
              description:
                  'Save your go-to skincare, serums, and pharmacy essentials for quick reordering.',
              actionLabel: 'Explore Shop',
              onActionTap: () {
                if (showBack && Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  MainShell.of(context)?.switchTab(1);
                }
              },
            );
          }

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(AppSizes.screenPadding),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isTablet ? 3 : 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.67,
            ),
            itemCount: favProducts.length,
            itemBuilder: (context, index) {
              final product = favProducts[index];
              final tag = 'fav-${product.id}';
              return AnimatedFadeSlide(
                delay: Duration(milliseconds: index * 45),
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
                  isFavorite: true,
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.productDetail,
                    arguments: (product, tag),
                  ),
                  onFavoriteTap: () =>
                      context.read<FavoritesCubit>().toggle(product.id),
                  onAddToBasketTap: () {
                    context.read<BasketCubit>().addProduct(product);
                    context.showAppSnackBar('Added ${product.name} to cart');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
