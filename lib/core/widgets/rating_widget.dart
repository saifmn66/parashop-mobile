import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.rating,
    this.reviewCount,
    this.compact = false,
  });

  final double rating;
  final int? reviewCount;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star_rounded,
          size: compact ? 15 : 18,
          color: AppColors.rating,
        ),
        const SizedBox(width: 3),
        Text(
          rating.toStringAsFixed(1),
          style: (compact ? textTheme.labelSmall : textTheme.labelMedium)
              ?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (reviewCount != null) ...[
          const SizedBox(width: 3),
          Text(
            '($reviewCount)',
            style: textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
