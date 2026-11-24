import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/product_card.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../basket/presentation/controllers/basket_cubit.dart';
import '../../../favorites/presentation/controllers/favorites_cubit.dart';
import '../../../products/domain/entities/product_entity.dart';

class ProductHorizontalRail extends StatelessWidget {
  const ProductHorizontalRail({
    super.key,
    required this.title,
    this.subtitle,
    required this.sectionKey,
    required this.products,
    this.onSeeAllTap,
  });

  final String title;
  final String? subtitle;
  final String sectionKey;
  final List<ProductEntity> products;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();
    final favIds = context.watch<FavoritesCubit>().state.favoriteIds;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: title,
          subtitle: subtitle,
          actionLabel: onSeeAllTap != null ? 'See all' : null,
          onActionTap: onSeeAllTap,
        ),
        const SizedBox(height: AppSizes.sm),
        SizedBox(
          height: 294,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: AppSizes.screenInsets,
            itemCount: products.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSizes.sm),
            itemBuilder: (context, i) {
              final product = products[i];
              final tag = '$sectionKey-${product.id}';
              return ProductCard(
                id: product.id,
                heroTag: tag,
                width: 172,
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
                  arguments: (product, tag),
                ),
                onFavoriteTap: () =>
                    context.read<FavoritesCubit>().toggle(product.id),
                onAddToBasketTap: () {
                  context.read<BasketCubit>().addProduct(product);
                  context.showAppSnackBar('Added ${product.name} to basket');
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
