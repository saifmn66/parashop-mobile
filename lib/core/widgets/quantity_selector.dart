import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.min = 1,
    this.max = 99,
    this.compact = false,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int min;
  final int max;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final btnSize = compact ? 30.0 : 38.0;
    final iconSize = compact ? 16.0 : 18.0;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: AppSizes.rPill,
        border: Border.all(color: scheme.outline),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyButton(
            icon: Icons.remove_rounded,
            size: btnSize,
            iconSize: iconSize,
            enabled: quantity > min,
            onTap: onDecrement,
            tooltip: 'Decrease quantity',
          ),
          SizedBox(
            width: compact ? 28 : 36,
            height: btnSize,
            child: Center(
              child: AnimatedSwitcher(
                duration: AppMotion.fast,
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: Text(
                  '$quantity',
                  key: ValueKey(quantity),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontSize: compact ? 13 : 15,
                      ),
                ),
              ),
            ),
          ),
          _QtyButton(
            icon: Icons.add_rounded,
            size: btnSize,
            iconSize: iconSize,
            enabled: quantity < max,
            onTap: onIncrement,
            tooltip: 'Increase quantity',
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.icon,
    required this.size,
    required this.iconSize,
    required this.enabled,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final bool enabled;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: enabled ? scheme.surface : Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: enabled ? onTap : null,
        customBorder: const CircleBorder(),
        child: Tooltip(
          message: tooltip,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(
              icon,
              size: iconSize,
              color: enabled
                  ? scheme.onSurface
                  : scheme.onSurfaceVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
      ),
    );
  }
}
