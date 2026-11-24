import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ProductDetailTabs extends StatefulWidget {
  const ProductDetailTabs({
    super.key,
    required this.description,
    required this.usageInstructions,
    required this.ingredients,
    required this.rating,
    required this.reviewCount,
  });

  final String description;
  final String usageInstructions;
  final List<String> ingredients;
  final double rating;
  final int reviewCount;

  @override
  State<ProductDetailTabs> createState() => _ProductDetailTabsState();
}

class _ProductDetailTabsState extends State<ProductDetailTabs> {
  int _selectedIndex = 0;

  static const _tabs = ['Details', 'Ingredients', 'Reviews'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Minimal editorial tab bar with thin bottom underline
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: scheme.outline.withValues(alpha: 0.65),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: List.generate(_tabs.length, (index) {
              final selected = index == _selectedIndex;
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: AnimatedDefaultTextStyle(
                          duration: AppMotion.fast,
                          style: (theme.textTheme.titleSmall ?? const TextStyle())
                              .copyWith(
                            fontSize: 13.5,
                            fontWeight:
                                selected ? FontWeight.w600 : FontWeight.w400,
                            color: selected
                                ? scheme.onSurface
                                : scheme.onSurfaceVariant.withValues(alpha: 0.7),
                          ),
                          child: Text(
                            _tabs[index],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: AppMotion.normal,
                        curve: AppMotion.curve,
                        height: 2,
                        width: selected ? 44 : 0,
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          borderRadius: AppSizes.rPill,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: AppSizes.md),
        AnimatedSwitcher(
          duration: AppMotion.normal,
          switchInCurve: AppMotion.curve,
          switchOutCurve: AppMotion.curve,
          child: KeyedSubtree(
            key: ValueKey(_selectedIndex),
            child: switch (_selectedIndex) {
              0 => _DetailsContent(
                  description: widget.description,
                  usageInstructions: widget.usageInstructions,
                ),
              1 => _IngredientsContent(ingredients: widget.ingredients),
              _ => _ReviewsContent(
                  rating: widget.rating,
                  reviewCount: widget.reviewCount,
                ),
            },
          ),
        ),
      ],
    );
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({
    required this.description,
    required this.usageInstructions,
  });

  final String description;
  final String usageInstructions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 13.5,
            height: 1.55,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Text(
          'How to use',
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          usageInstructions,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _IngredientsContent extends StatelessWidget {
  const _IngredientsContent({required this.ingredients});

  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ingredients
          .map(
            (ing) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBeigeCard : AppColors.beigeSoft,
                borderRadius: AppSizes.rPill,
              ),
              child: Text(
                ing,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ReviewsContent extends StatelessWidget {
  const _ReviewsContent({
    required this.rating,
    required this.reviewCount,
  });

  final double rating;
  final int reviewCount;

  static const _sampleReviews = [
    (
      author: 'Camille D.',
      date: '2 days ago',
      comment:
          'Gentle, fast-absorbing texture. My sensitive skin felt calmer after the very first week.',
    ),
    (
      author: 'Nadia M.',
      date: '1 week ago',
      comment:
          'Authentic pharmacy quality and zero irritation. Already on my second bottle.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${rating.toStringAsFixed(1)} out of 5 • Based on $reviewCount verified reviews',
          style: theme.textTheme.labelMedium?.copyWith(
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        ..._sampleReviews.map(
          (r) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBeigeCard : AppColors.beigeCard,
              borderRadius: AppSizes.rSm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(r.author, style: theme.textTheme.labelMedium),
                    const Spacer(),
                    Text(r.date, style: theme.textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  r.comment,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.onSurface,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
