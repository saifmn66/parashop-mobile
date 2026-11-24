import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../../../core/widgets/price_widget.dart';
import '../../../../core/widgets/quantity_selector.dart';
import '../../domain/entities/basket_item_entity.dart';

class BasketItemTile extends StatelessWidget {
  const BasketItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onSaveForLater,
  });

  final BasketItemEntity item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final VoidCallback onSaveForLater;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Dismissible(
      key: ValueKey(item.itemKey),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSizes.lg),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.14),
          borderRadius: AppSizes.rMd,
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: AppColors.error,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: AppSizes.rMd,
          border: Border.all(color: scheme.outline),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppNetworkImage(
                  url: item.imageUrl,
                  width: 82,
                  height: 82,
                  borderRadius: AppSizes.rSm,
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.brand.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: scheme.tertiary,
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.name,
                        style: theme.textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surfaceContainerHighest,
                          borderRadius: AppSizes.rXs,
                        ),
                        child: Text(
                          item.variantLabel,
                          style: theme.textTheme.labelSmall,
                        ),
                      ),
                      const SizedBox(height: AppSizes.xs),
                      Row(
                        children: [
                          Expanded(
                            child: PriceWidget(
                              price: item.lineTotal,
                              originalPrice: item.originalPrice != null
                                  ? item.originalPrice! * item.quantity
                                  : null,
                              fontSize: 16,
                            ),
                          ),
                          QuantitySelector(
                            quantity: item.quantity,
                            compact: true,
                            min: 0,
                            onDecrement: onDecrement,
                            onIncrement: onIncrement,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.xs),
            Divider(color: scheme.outline),
            Row(
              children: [
                TextButton.icon(
                  onPressed: onSaveForLater,
                  icon: const Icon(Icons.bookmark_border_rounded, size: 17),
                  label: const Text('Save for later'),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    foregroundColor: scheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline_rounded, size: 17),
                  label: const Text('Remove'),
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                    foregroundColor: AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
