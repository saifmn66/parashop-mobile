import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'app_network_image.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.icon = Icons.spa_outlined,
    this.productCount,
    this.compact = false,
    required this.onTap,
  });

  final String name;
  final String imageUrl;
  final IconData icon;
  final int? productCount;
  final bool compact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    if (compact) {
      return SizedBox(
        width: 84,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSizes.rMd,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: scheme.secondaryContainer,
                  borderRadius: AppSizes.rMd,
                  border: Border.all(color: scheme.outline),
                ),
                clipBehavior: Clip.antiAlias,
                child: imageUrl.isNotEmpty
                    ? AppNetworkImage(
                        url: imageUrl,
                        width: 64,
                        height: 64,
                        fallbackIcon: icon,
                      )
                    : Icon(icon, color: scheme.primary, size: AppSizes.iconMd),
              ),
              const SizedBox(height: AppSizes.xs),
              Text(
                name,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }

    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppSizes.rMd,
        side: BorderSide(color: scheme.outline),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppNetworkImage(
                    url: imageUrl,
                    fit: BoxFit.cover,
                    fallbackIcon: icon,
                  ),
                  Positioned(
                    top: AppSizes.xs,
                    right: AppSizes.xs,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: scheme.surface.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 16, color: scheme.primary),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: theme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (productCount != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      '$productCount products',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
