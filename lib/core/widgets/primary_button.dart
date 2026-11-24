import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.compact = false,
    this.backgroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final bool compact;
  final Color? backgroundColor;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height =
        widget.compact ? AppSizes.buttonHeightSmall : AppSizes.buttonHeight;
    final bg = widget.backgroundColor ?? theme.colorScheme.primary;

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
          child: FilledButton(
            onPressed: _enabled ? widget.onPressed : null,
            style: FilledButton.styleFrom(
              backgroundColor: bg,
              foregroundColor: theme.colorScheme.onPrimary,
              minimumSize: Size(widget.isFullWidth ? double.infinity : 0, height),
              padding: EdgeInsets.symmetric(
                horizontal: widget.compact ? AppSizes.md : AppSizes.lg,
              ),
              shape: RoundedRectangleBorder(borderRadius: AppSizes.rMd),
            ),
            child: AnimatedSwitcher(
              duration: AppMotion.fast,
              child: widget.isLoading
                  ? SizedBox(
                      key: const ValueKey('loading'),
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        color: theme.colorScheme.onPrimary,
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
            ),
          ),
        ),
      ),
    );
  }
}
