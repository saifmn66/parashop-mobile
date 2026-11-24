import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/primary_button.dart';

class PromoCodeCard extends StatefulWidget {
  const PromoCodeCard({
    super.key,
    required this.appliedCode,
    required this.discountRate,
    required this.errorText,
    required this.onApply,
    required this.onRemove,
  });

  final String? appliedCode;
  final double discountRate;
  final String? errorText;
  final ValueChanged<String> onApply;
  final VoidCallback onRemove;

  @override
  State<PromoCodeCard> createState() => _PromoCodeCardState();
}

class _PromoCodeCardState extends State<PromoCodeCard> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: AppSizes.rMd,
        border: Border.all(color: scheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_offer_outlined, size: 18, color: scheme.primary),
              const SizedBox(width: AppSizes.xs),
              Text('Promo Code', style: theme.textTheme.titleSmall),
            ],
          ),
          const SizedBox(height: AppSizes.sm),
          if (widget.appliedCode != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.sm,
                vertical: AppSizes.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.12),
                borderRadius: AppSizes.rSm,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 18,
                    color: AppColors.success,
                  ),
                  const SizedBox(width: AppSizes.xs),
                  Expanded(
                    child: Text(
                      '${widget.appliedCode} applied (${(widget.discountRate * 100).round()}% off)',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 18),
                    visualDensity: VisualDensity.compact,
                    onPressed: widget.onRemove,
                  ),
                ],
              ),
            )
          else ...[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      hintText: 'Try PARA15 or WELCOME10',
                      isDense: true,
                    ),
                    onSubmitted: widget.onApply,
                  ),
                ),
                const SizedBox(width: AppSizes.xs),
                PrimaryButton(
                  label: 'Apply',
                  isFullWidth: false,
                  compact: true,
                  onPressed: () => widget.onApply(_controller.text),
                ),
              ],
            ),
            if (widget.errorText != null) ...[
              const SizedBox(height: AppSizes.xs),
              Text(
                widget.errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
