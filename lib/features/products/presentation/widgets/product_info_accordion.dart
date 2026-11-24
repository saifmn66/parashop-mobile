import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ProductInfoAccordion extends StatelessWidget {
  const ProductInfoAccordion({
    super.key,
    required this.benefits,
    required this.ingredients,
    required this.usageInstructions,
  });

  final List<String> benefits;
  final List<String> ingredients;
  final String usageInstructions;

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
      child: Column(
        children: [
          ExpansionTile(
            initiallyExpanded: true,
            shape: const Border(),
            collapsedShape: const Border(),
            leading: Icon(Icons.verified_outlined, color: scheme.primary),
            title: Text('Key Benefits', style: theme.textTheme.titleSmall),
            childrenPadding: const EdgeInsets.fromLTRB(
              AppSizes.md,
              0,
              AppSizes.md,
              AppSizes.md,
            ),
            children: benefits
                .map(
                  (b) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          size: 16,
                          color: scheme.primary,
                        ),
                        const SizedBox(width: AppSizes.xs),
                        Expanded(
                          child: Text(b, style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          Divider(height: 1, color: scheme.outline),
          ExpansionTile(
            shape: const Border(),
            collapsedShape: const Border(),
            leading: Icon(Icons.science_outlined, color: scheme.primary),
            title:
                Text('Active Ingredients', style: theme.textTheme.titleSmall),
            childrenPadding: const EdgeInsets.fromLTRB(
              AppSizes.md,
              0,
              AppSizes.md,
              AppSizes.md,
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: AppSizes.xs,
                  runSpacing: AppSizes.xs,
                  children: ingredients
                      .map(
                        (ing) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.sm,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: scheme.secondaryContainer,
                            borderRadius: AppSizes.rPill,
                          ),
                          child: Text(
                            ing,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: scheme.onSecondaryContainer,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          Divider(height: 1, color: scheme.outline),
          ExpansionTile(
            shape: const Border(),
            collapsedShape: const Border(),
            leading: Icon(Icons.spa_outlined, color: scheme.primary),
            title:
                Text('Usage Instructions', style: theme.textTheme.titleSmall),
            childrenPadding: const EdgeInsets.fromLTRB(
              AppSizes.md,
              0,
              AppSizes.md,
              AppSizes.md,
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  usageInstructions,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
