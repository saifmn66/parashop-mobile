import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    this.favoritesCount = 0,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final int favoritesCount;

  static const _items = [
    (
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    (
      label: 'Shop',
      icon: Icons.storefront_outlined,
      activeIcon: Icons.storefront_rounded,
    ),
    (
      label: 'Favorites',
      icon: Icons.favorite_outline_rounded,
      activeIcon: Icons.favorite_rounded,
    ),
    (
      label: 'Profile',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkSurface : AppColors.ivory;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: Border(
          top: BorderSide(
            color: scheme.outline.withValues(alpha: 0.7),
            width: 0.8,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final selected = index == currentIndex;
              final activeColor = scheme.primary;
              final inactiveColor = scheme.onSurfaceVariant.withValues(
                alpha: 0.65,
              );

              return Expanded(
                child: InkWell(
                  onTap: () => onDestinationSelected(index),
                  splashColor: activeColor.withValues(alpha: 0.08),
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: AppMotion.normal,
                        curve: AppMotion.curve,
                        width: selected ? 18 : 0,
                        height: 2,
                        margin: const EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: activeColor,
                          borderRadius: AppSizes.rPill,
                        ),
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          AnimatedSwitcher(
                            duration: AppMotion.fast,
                            child: Icon(
                              selected ? item.activeIcon : item.icon,
                              key: ValueKey('$index-$selected'),
                              size: 22,
                              color: selected ? activeColor : inactiveColor,
                            ),
                          ),
                          if (index == 2 && favoritesCount > 0)
                            Positioned(
                              right: -5,
                              top: -2,
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
                      const SizedBox(height: 3),
                      AnimatedDefaultTextStyle(
                        duration: AppMotion.fast,
                        style: (theme.textTheme.labelSmall ?? const TextStyle())
                            .copyWith(
                          fontSize: 11,
                          fontWeight:
                              selected ? FontWeight.w600 : FontWeight.w400,
                          color: selected ? activeColor : inactiveColor,
                        ),
                        child: Text(item.label),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
