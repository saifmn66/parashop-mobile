import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.spa_rounded,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: scheme.secondaryContainer,
            borderRadius: AppSizes.rMd,
            border: Border.all(color: scheme.outline),
          ),
          child: Icon(icon, color: scheme.primary, size: 26),
        ),
        const SizedBox(height: AppSizes.lg),
        Text(title, style: theme.textTheme.headlineLarge),
        const SizedBox(height: AppSizes.xs),
        Text(subtitle, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
