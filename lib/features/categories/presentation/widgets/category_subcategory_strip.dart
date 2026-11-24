import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/category_entity.dart';

class CategorySubcategoryStrip extends StatelessWidget {
  const CategorySubcategoryStrip({
    super.key,
    required this.category,
    required this.onSubcategoryTap,
    required this.onViewAllTap,
  });

  final CategoryEntity category;
  final ValueChanged<String> onSubcategoryTap;
  final VoidCallback onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSizes.screenPadding,
        0,
        AppSizes.screenPadding,
        AppSizes.md,
      ),
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: 0.65),
        borderRadius: AppSizes.rMd,
        border: Border.all(color: scheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(category.icon, size: 18, color: scheme.primary),
              const SizedBox(width: AppSizes.xs),
              Expanded(
                child: Text(
                  '${category.name} Subcategories',
                  style: theme.textTheme.titleSmall,
                ),
              ),
              TextButton(
                onPressed: onViewAllTap,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Shop all'),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          Wrap(
            spacing: AppSizes.xs,
            runSpacing: AppSizes.xs,
            children: category.subcategories
                .map(
                  (sub) => ActionChip(
                    label: Text(sub),
                    backgroundColor: scheme.surface,
                    side: BorderSide(color: scheme.outline),
                    onPressed: () => onSubcategoryTap(sub),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
