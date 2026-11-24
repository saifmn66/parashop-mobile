import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
    required this.initials,
    required this.onAvatarTap,
    required this.onSearchTap,
    required this.onNotificationTap,
    required this.onBasketTap,
    this.basketCount = 0,
    this.hasUnreadNotifications = true,
  });

  final String initials;
  final VoidCallback onAvatarTap;
  final VoidCallback onSearchTap;
  final VoidCallback onNotificationTap;
  final VoidCallback onBasketTap;
  final int basketCount;
  final bool hasUnreadNotifications;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final chipBg = isDark ? AppColors.darkBeigeCard : AppColors.beigeCard;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.screenPadding,
        AppSizes.sm,
        AppSizes.screenPadding,
        AppSizes.sm,
      ),
      child: Row(
        children: [
          // Small profile avatar
          GestureDetector(
            onTap: onAvatarTap,
            child: CircleAvatar(
              radius: 20,
              backgroundColor:
                  isDark ? AppColors.darkBeigeCard : AppColors.oliveDark,
              child: Text(
                initials,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isDark ? AppColors.secondary : Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Rounded search bar
          Expanded(
            child: Material(
              color: chipBg,
              borderRadius: AppSizes.rPill,
              child: InkWell(
                onTap: onSearchTap,
                borderRadius: AppSizes.rPill,
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 19,
                        color: scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Search skincare, serums...',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 13,
                            color: scheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Minimal basket icon with count badge
          _MinimalHeaderIcon(
            icon: Icons.shopping_bag_outlined,
            tooltip: 'Basket',
            badgeCount: basketCount,
            onTap: onBasketTap,
          ),
          const SizedBox(width: 4),

          // Minimal notification icon
          _MinimalHeaderIcon(
            icon: Icons.notifications_none_rounded,
            tooltip: 'Notifications',
            showDot: hasUnreadNotifications,
            onTap: onNotificationTap,
          ),
        ],
      ),
    );
  }
}

class _MinimalHeaderIcon extends StatelessWidget {
  const _MinimalHeaderIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.showDot = false,
    this.badgeCount = 0,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool showDot;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
            width: 38,
            height: 38,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, size: 22, color: scheme.onSurface),
                if (badgeCount > 0)
                  Positioned(
                    top: 4,
                    right: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      constraints:
                          const BoxConstraints(minWidth: 16, minHeight: 16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.secondary
                            : AppColors.oliveDark,
                        borderRadius: AppSizes.rPill,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        badgeCount > 9 ? '9+' : '$badgeCount',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: isDark ? AppColors.primary : Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  )
                else if (showDot)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
