import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'app_network_image.dart';
import 'price_widget.dart';
import 'rating_widget.dart';

class ProductHorizontalCard extends StatelessWidget {
  const ProductHorizontalCard({
    super.key,
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.subtitle,
    this.rating,
    this.heroTag,
    this.trailing,
    required this.onTap,
  });

  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final String? subtitle;
  final double? rating;
  final String? heroTag;
  final Widget? trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppSizes.rMd,
        side: BorderSide(color: scheme.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.sm),
          child: Row(
            children: [
              Hero(
                tag: heroTag ?? 'product-h-$id',
                child: AppNetworkImage(
                  url: imageUrl,
                  width: 82,
                  height: 82,
                  borderRadius: AppSizes.rSm,
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      brand.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        letterSpacing: 0.6,
                        color: scheme.tertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      name,
                      style: theme.textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: AppSizes.xs),
                    Row(
                      children: [
                        Expanded(
                          child: PriceWidget(
                            price: price,
                            originalPrice: originalPrice,
                            fontSize: 15,
                          ),
                        ),
                        if (rating != null)
                          RatingWidget(rating: rating!, compact: true),
                      ],
                    ),
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: AppSizes.xs),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
