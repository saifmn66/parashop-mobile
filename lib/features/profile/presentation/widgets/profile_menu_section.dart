import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ProfileMenuItemData {
  const ProfileMenuItemData({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;
}

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<ProfileMenuItemData> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: AppSizes.xs),
          child: Text(
            title.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              letterSpacing: 0.9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Material(
          color: scheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: AppSizes.rMd,
            side: BorderSide(color: scheme.outline),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: List.generate(items.length, (i) {
              final item = items[i];
              final iconColor =
                  item.isDestructive ? AppColors.error : scheme.primary;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: item.isDestructive
                            ? AppColors.error.withValues(alpha: 0.1)
                            : scheme.secondaryContainer,
                        borderRadius: AppSizes.rSm,
                      ),
                      child: Icon(item.icon, size: 19, color: iconColor),
                    ),
                    title: Text(
                      item.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: item.isDestructive ? AppColors.error : null,
                      ),
                    ),
                    subtitle: item.subtitle != null
                        ? Text(item.subtitle!, style: theme.textTheme.bodySmall)
                        : null,
                    trailing: item.trailing ??
                        Icon(
                          Icons.chevron_right_rounded,
                          color: scheme.onSurfaceVariant,
                        ),
                    onTap: item.onTap,
                  ),
                  if (i < items.length - 1)
                    Divider(height: 1, indent: 68, color: scheme.outline),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
