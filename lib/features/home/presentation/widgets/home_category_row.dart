import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../categories/domain/entities/category_entity.dart';

class HomeCategoryRow extends StatelessWidget {
  const HomeCategoryRow({
    super.key,
    required this.categories,
    required this.onCategoryTap,
  });

  final List<CategoryEntity> categories;
  final ValueChanged<CategoryEntity> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final discBg = isDark ? AppColors.darkBeigeCard : AppColors.beigeCard;
    final topFour = categories.take(4).toList();

    return Padding(
      padding: AppSizes.screenInsets,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(topFour.length, (index) {
          final cat = topFour[index];
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 0 : 6,
                right: index == topFour.length - 1 ? 0 : 6,
              ),
              child: GestureDetector(
                onTap: () => onCategoryTap(cat),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: discBg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        cat.icon,
                        size: 24,
                        color: scheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cat.name.split(' ').first,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
