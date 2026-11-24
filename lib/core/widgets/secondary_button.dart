import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.compact = false,
    this.tonal = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final bool compact;
  final bool tonal;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height =
        widget.compact ? AppSizes.buttonHeightSmall : AppSizes.buttonHeight;

    final child = AnimatedSwitcher(
      duration: AppMotion.fast,
      child: widget.isLoading
          ? SizedBox(
              key: const ValueKey('loading'),
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                color: theme.colorScheme.primary,
              ),
            )
          : Row(
              key: const ValueKey('content'),
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: AppSizes.iconSm),
                  const SizedBox(width: AppSizes.xs),
                ],
                Flexible(
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );

    return GestureDetector(
      onTapDown: _enabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: _enabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: _enabled ? () => setState(() => _pressed = false) : null,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: AppMotion.fast,
        curve: AppMotion.curve,
        child: SizedBox(
          width: widget.isFullWidth ? double.infinity : null,
          height: height,
          child: widget.tonal
              ? FilledButton.tonal(
                  onPressed: _enabled ? widget.onPressed : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondaryContainer,
                    foregroundColor: theme.colorScheme.onSecondaryContainer,
                    minimumSize:
                        Size(widget.isFullWidth ? double.infinity : 0, height),
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.compact ? AppSizes.md : AppSizes.lg,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: AppSizes.rMd),
                  ),
                  child: child,
                )
              : OutlinedButton(
                  onPressed: _enabled ? widget.onPressed : null,
                  style: OutlinedButton.styleFrom(
                    minimumSize:
                        Size(widget.isFullWidth ? double.infinity : 0, height),
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.compact ? AppSizes.md : AppSizes.lg,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: AppSizes.rMd),
                  ),
                  child: child,
                ),
        ),
      ),
    );
  }
}
