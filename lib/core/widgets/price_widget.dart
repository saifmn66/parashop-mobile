import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/formatters.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.price,
    this.originalPrice,
    this.fontSize,
    this.showBadge = false,
  });

  final double price;
  final double? originalPrice;
  final double? fontSize;
  final bool showBadge;

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final priceStyle = AppText.price.copyWith(
      color: scheme.onSurface,
      fontSize: fontSize ?? 16,
    );
    final oldStyle = AppText.priceOld.copyWith(
      fontSize: (fontSize ?? 16) - 3,
    );

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: AppSizes.xs,
      runSpacing: AppSizes.xxs,
      children: [
        Text(AppFormatters.price(price), style: priceStyle),
        if (hasDiscount)
          Text(AppFormatters.price(originalPrice!), style: oldStyle),
        if (hasDiscount && showBadge)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.sale.withValues(alpha: 0.12),
              borderRadius: AppSizes.rXs,
            ),
            child: Text(
              AppFormatters.discountPercent(price, originalPrice!),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.sale,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
      ],
    );
  }
}
