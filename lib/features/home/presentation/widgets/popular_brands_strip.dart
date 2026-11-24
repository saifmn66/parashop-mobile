import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/home_entities.dart';

class PopularBrandsStrip extends StatelessWidget {
  const PopularBrandsStrip({
    super.key,
    required this.brands,
    required this.onBrandTap,
  });

  final List<BrandEntity> brands;
  final ValueChanged<BrandEntity> onBrandTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: AppSizes.screenInsets,
        itemCount: brands.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSizes.sm),
        itemBuilder: (context, index) {
          final brand = brands[index];
          return Material(
            color: scheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: AppSizes.rMd,
              side: BorderSide(color: scheme.outline),
            ),
            child: InkWell(
              onTap: () => onBrandTap(brand),
              borderRadius: AppSizes.rMd,
              child: Container(
                width: 152,
                padding: const EdgeInsets.all(AppSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      brand.name,
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      brand.tagline,
                      style: theme.textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      brand.origin.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: scheme.tertiary,
                        letterSpacing: 0.7,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
