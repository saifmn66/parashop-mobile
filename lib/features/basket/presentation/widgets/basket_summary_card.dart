import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../controllers/basket_cubit.dart';

class BasketSummaryCard extends StatelessWidget {
  const BasketSummaryCard({
    super.key,
    required this.state,
    required this.onCheckout,
    required this.onContinueShopping,
  });

  final BasketState state;
  final VoidCallback onCheckout;
  final VoidCallback onContinueShopping;

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
          // Free delivery progress
          Container(
            padding: const EdgeInsets.all(AppSizes.sm),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer.withValues(alpha: 0.65),
              borderRadius: AppSizes.rSm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      state.deliveryFee == 0
                          ? Icons.verified_rounded
                          : Icons.local_shipping_outlined,
                      size: 17,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: AppSizes.xs),
                    Expanded(
                      child: Text(
                        state.deliveryFee == 0
                            ? 'You unlocked complimentary delivery!'
                            : 'Add ${AppFormatters.price(state.amountUntilFreeDelivery)} for free delivery',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: scheme.onSecondaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.xs),
                ClipRRect(
                  borderRadius: AppSizes.rPill,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: state.freeDeliveryProgress),
                    duration: AppMotion.normal,
                    curve: AppMotion.curve,
                    builder: (context, value, _) => LinearProgressIndicator(
                      value: value,
                      minHeight: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.md),
          _SummaryRow(
            label: 'Subtotal (${state.totalCount} items)',
            value: AppFormatters.price(state.subtotal),
          ),
          const SizedBox(height: AppSizes.xs),
          _SummaryRow(
            label: 'Delivery',
            value: state.deliveryFee == 0
                ? 'Free'
                : AppFormatters.price(state.deliveryFee),
            valueColor: state.deliveryFee == 0 ? AppColors.success : null,
          ),
          if (state.discount > 0) ...[
            const SizedBox(height: AppSizes.xs),
            _SummaryRow(
              label: 'Discount (${state.promoCode})',
              value: '-${AppFormatters.price(state.discount)}',
              valueColor: AppColors.success,
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.sm),
            child: Divider(),
          ),
          Row(
            children: [
              Text('Total', style: theme.textTheme.titleMedium),
              const Spacer(),
              AnimatedSwitcher(
                duration: AppMotion.fast,
                child: Text(
                  AppFormatters.price(state.total),
                  key: ValueKey(state.total.toStringAsFixed(2)),
                  style: AppText.price.copyWith(
                    fontSize: 20,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),
          PrimaryButton(
            label: 'Proceed to Checkout',
            icon: Icons.lock_outline_rounded,
            onPressed: onCheckout,
          ),
          const SizedBox(height: AppSizes.xs),
          SecondaryButton(
            label: 'Continue Shopping',
            compact: true,
            onPressed: onContinueShopping,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(label, style: theme.textTheme.bodyMedium),
        const Spacer(),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(color: valueColor),
        ),
      ],
    );
  }
}
