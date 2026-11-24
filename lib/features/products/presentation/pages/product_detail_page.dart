import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/formatters.dart';
import '../../../basket/presentation/controllers/basket_cubit.dart';
import '../../../favorites/presentation/controllers/favorites_cubit.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/product_usecases.dart';
import '../widgets/product_benefits_row.dart';
import '../widgets/product_detail_tabs.dart';
import '../widgets/product_gallery_widget.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.heroTag,
  });

  final ProductEntity product;
  final String heroTag;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ProductVariant _selectedVariant;
  int _quantity = 1;
  bool _ctaPressed = false;

  @override
  void initState() {
    super.initState();
    _selectedVariant = widget.product.variants.isNotEmpty
        ? widget.product.variants.first
        : ProductVariant(
            id: '${widget.product.id}_default',
            label: 'Standard',
            price: widget.product.price,
            originalPrice: widget.product.originalPrice,
          );
    sl<MarkProductViewedUseCase>()(widget.product.id);
  }

  void _addToCart() {
    context.read<BasketCubit>().addProduct(
          widget.product,
          variant: _selectedVariant,
          quantity: _quantity,
        );
    context.showAppSnackBar(
      'Added $_quantity × ${widget.product.name} to cart',
      action: SnackBarAction(
        label: 'View Basket',
        textColor: AppColors.secondary,
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.basket),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final imageHeight = (screenHeight * 0.56).clamp(320.0, 480.0);
    const double overlap = 28;

    final panelBg = isDark ? AppColors.darkSurface : AppColors.ivory;
    final favIds = context.watch<FavoritesCubit>().state.favoriteIds;
    final isFav = favIds.contains(widget.product.id);

    return Scaffold(
      backgroundColor: panelBg,
      body: Stack(
        children: [
          // Scrollable immersive hero image + signature overlapping ivory panel
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Stack(
              children: [
                // A. Immersive product image (55-60% height)
                ProductGalleryWidget(
                  images: widget.product.images,
                  heroTag: widget.heroTag,
                  height: imageHeight,
                  indicatorBottomOffset: overlap + 16,
                ),

                // B. Signature overlapping warm ivory panel
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: imageHeight - overlap),
                  constraints: BoxConstraints(
                    minHeight: screenHeight - (imageHeight - overlap),
                  ),
                  decoration: BoxDecoration(
                    color: panelBg,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: isDark ? 0.28 : 0.08,
                        ),
                        blurRadius: 24,
                        offset: const Offset(0, -6),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      24,
                      26,
                      24,
                      MediaQuery.paddingOf(context).bottom + 28,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subtle brand label
                        Text(
                          widget.product.brand.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            letterSpacing: 1.2,
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // 1. Product Name
                        Text(
                          widget.product.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                            color: scheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // 2. Product Price
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              AppFormatters.price(_selectedVariant.price),
                              style: AppText.price.copyWith(
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                                color: scheme.onSurface,
                              ),
                            ),
                            if (_selectedVariant.originalPrice != null &&
                                _selectedVariant.originalPrice! >
                                    _selectedVariant.price) ...[
                              const SizedBox(width: 10),
                              Text(
                                AppFormatters.price(
                                  _selectedVariant.originalPrice!,
                                ),
                                style: AppText.priceOld.copyWith(fontSize: 14),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 10),

                        // 3. Compact olive stars + rating + muted review count
                        Row(
                          children: [
                            ...List.generate(5, (i) {
                              final filled =
                                  i < widget.product.rating.round();
                              return Icon(
                                filled
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                size: 16,
                                color: scheme.primary,
                              );
                            }),
                            const SizedBox(width: 6),
                            Text(
                              widget.product.rating.toStringAsFixed(1),
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '(${widget.product.reviewCount} reviews)',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),

                        // Subtle variant selector if multiple sizes
                        if (widget.product.variants.length > 1) ...[
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.product.variants.map((variant) {
                              final selected =
                                  variant.id == _selectedVariant.id;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedVariant = variant),
                                child: AnimatedContainer(
                                  duration: AppMotion.fast,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? (isDark
                                            ? AppColors.secondary
                                            : AppColors.oliveDark)
                                        : (isDark
                                            ? AppColors.darkBeigeCard
                                            : AppColors.beigeSoft),
                                    borderRadius: AppSizes.rPill,
                                  ),
                                  child: Text(
                                    variant.label,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: selected
                                          ? (isDark
                                              ? AppColors.primary
                                              : Colors.white)
                                          : scheme.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],

                        const SizedBox(height: 22),

                        // 4. Horizontal Purchase Row: Quantity + Pill Add to Cart
                        Row(
                          children: [
                            _MinimalQuantityControl(
                              quantity: _quantity,
                              onDecrement: _quantity > 1
                                  ? () => setState(() => _quantity--)
                                  : null,
                              onIncrement: () => setState(() => _quantity++),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: GestureDetector(
                                onTapDown: _selectedVariant.inStock
                                    ? (_) => setState(() => _ctaPressed = true)
                                    : null,
                                onTapUp: _selectedVariant.inStock
                                    ? (_) {
                                        setState(() => _ctaPressed = false);
                                        _addToCart();
                                      }
                                    : null,
                                onTapCancel: () =>
                                    setState(() => _ctaPressed = false),
                                child: AnimatedScale(
                                  scale: _ctaPressed ? 0.97 : 1.0,
                                  duration: AppMotion.fast,
                                  child: Container(
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: _selectedVariant.inStock
                                          ? (isDark
                                              ? AppColors.secondary
                                              : AppColors.oliveDark)
                                          : scheme.outline,
                                      borderRadius: AppSizes.rPill,
                                      boxShadow: isDark
                                          ? null
                                          : AppShadows.button,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      _selectedVariant.inStock
                                          ? 'Add to Cart'
                                          : 'Out of Stock',
                                      style: theme.textTheme.labelLarge
                                          ?.copyWith(
                                        color: isDark
                                            ? AppColors.primary
                                            : Colors.white,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 26),

                        // 5. Three minimal product information tabs
                        ProductDetailTabs(
                          description: widget.product.description,
                          usageInstructions: widget.product.usageInstructions,
                          ingredients: widget.product.ingredients,
                          rating: widget.product.rating,
                          reviewCount: widget.product.reviewCount,
                        ),

                        const SizedBox(height: 26),

                        // 6. Four product benefits with outline olive icons
                        ProductBenefitsRow(benefits: widget.product.benefits),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating minimal top-left Back & top-right Favorite buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  _FloatingIconCircle(
                    icon: Icons.arrow_back_ios_new_rounded,
                    tooltip: 'Back',
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  _FloatingIconCircle(
                    icon: isFav
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    iconColor: isFav ? scheme.primary : null,
                    tooltip: 'Favorite',
                    onTap: () => context
                        .read<FavoritesCubit>()
                        .toggle(widget.product.id),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingIconCircle extends StatelessWidget {
  const _FloatingIconCircle({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return Material(
      color: (isDark ? AppColors.darkSurface : AppColors.ivory)
          .withValues(alpha: 0.86),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
            width: 42,
            height: 42,
            child: Icon(
              icon,
              size: 19,
              color: iconColor ?? scheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _MinimalQuantityControl extends StatelessWidget {
  const _MinimalQuantityControl({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBeigeCard : AppColors.beigeSoft,
        borderRadius: AppSizes.rPill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrement,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.remove_rounded,
              size: 18,
              color: onDecrement != null
                  ? scheme.onSurface
                  : scheme.onSurfaceVariant.withValues(alpha: 0.35),
            ),
          ),
          SizedBox(
            width: 26,
            child: Center(
              child: AnimatedSwitcher(
                duration: AppMotion.fast,
                child: Text(
                  '$quantity',
                  key: ValueKey(quantity),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onIncrement,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.add_rounded,
              size: 18,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
