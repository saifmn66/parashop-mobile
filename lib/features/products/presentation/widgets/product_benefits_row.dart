import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ProductBenefitsRow extends StatelessWidget {
  const ProductBenefitsRow({super.key, required this.benefits});

  final List<String> benefits;

  static const _defaultItems = [
    (icon: Icons.spa_outlined, label: 'Soothes\nredness'),
    (icon: Icons.water_drop_outlined, label: 'Deeply\nhydrates'),
    (icon: Icons.shield_outlined, label: 'Strengthens\nbarrier'),
    (icon: Icons.favorite_border_rounded, label: 'Sensitive\nskin safe'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final circleBg = isDark ? AppColors.darkBeigeCard : AppColors.beigeSoft;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_defaultItems.length, (i) {
        final item = _defaultItems[i];
        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: circleBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 21,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.label,
                textAlign: TextAlign.center,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: 11,
                  height: 1.25,
                  fontWeight: FontWeight.w500,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
