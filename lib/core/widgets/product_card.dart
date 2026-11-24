import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/formatters.dart';
import 'app_network_image.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.price,
    this.originalPrice,
    this.subtitle,
    this.rating,
    this.reviewCount,
    this.isFavorite = false,
    this.inStock = true,
    this.badgeText,
    this.heroTag,
    this.width,
    required this.onTap,
    this.onFavoriteTap,
    this.onAddToBasketTap,
  });

  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final double price;
  final double? originalPrice;
  final String? subtitle;
  final double? rating;
  final int? reviewCount;
  final bool isFavorite;
  final bool inStock;
  final String? badgeText;
  final String? heroTag;
  final double? width;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onAddToBasketTap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _addPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkBeigeCard : AppColors.beigeCard;
    final hasDiscount =
        widget.originalPrice != null && widget.originalPrice! > widget.price;

    return SizedBox(
      width: widget.width,
      child: Material(
        color: cardBg,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Editorial product visual stage
              Expanded(
                flex: 6,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Hero(
                      tag: widget.heroTag ?? 'product-${widget.id}',
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: AppNetworkImage(
                            url: widget.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    if (hasDiscount || widget.badgeText != null)
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurface.withValues(alpha: 0.9)
                                : AppColors.ivory.withValues(alpha: 0.92),
                            borderRadius: AppSizes.rPill,
                          ),
                          child: Text(
                            hasDiscount
                                ? AppFormatters.discountPercent(
                                    widget.price,
                                    widget.originalPrice!,
                                  )
                                : widget.badgeText!,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: hasDiscount
                                  ? AppColors.sale
                                  : scheme.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    if (widget.onFavoriteTap != null)
                      Positioned(
                        top: 14,
                        right: 14,
                        child: _FavoriteCircleButton(
                          isFavorite: widget.isFavorite,
                          onTap: widget.onFavoriteTap!,
                        ),
                      ),
                  ],
                ),
              ),

              // Product metadata & circular olive add button
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.name,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.subtitle ?? widget.brand,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 11.5,
                        color: scheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppFormatters.price(widget.price),
                                style: AppText.price.copyWith(
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w700,
                                  color: scheme.onSurface,
                                ),
                              ),
                              if (hasDiscount)
                                Text(
                                  AppFormatters.price(widget.originalPrice!),
                                  style: AppText.priceOld.copyWith(
                                    fontSize: 11.5,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (widget.onAddToBasketTap != null)
                          GestureDetector(
                            onTapDown: widget.inStock
                                ? (_) => setState(() => _addPressed = true)
                                : null,
                            onTapUp: widget.inStock
                                ? (_) {
                                    setState(() => _addPressed = false);
                                    widget.onAddToBasketTap!();
                                  }
                                : null,
                            onTapCancel: () =>
                                setState(() => _addPressed = false),
                            child: AnimatedScale(
                              scale: _addPressed ? 0.88 : 1.0,
                              duration: AppMotion.fast,
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: widget.inStock
                                      ? (isDark
                                          ? AppColors.secondary
                                          : AppColors.oliveDark)
                                      : scheme.outline,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add_rounded,
                                  size: 19,
                                  color: isDark
                                      ? AppColors.primary
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteCircleButton extends StatelessWidget {
  const _FavoriteCircleButton({
    required this.isFavorite,
    required this.onTap,
  });

  final bool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: (isDark ? AppColors.darkSurface : AppColors.ivory)
          .withValues(alpha: 0.88),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 30,
          height: 30,
          child: AnimatedSwitcher(
            duration: AppMotion.fast,
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              key: ValueKey(isFavorite),
              size: 16,
              color: isFavorite ? scheme.primary : scheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
