import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: const CustomAppBar(title: 'About ParaShop'),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.screenPadding),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.lg),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: AppSizes.rLg,
              border: Border.all(color: scheme.outline),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: AppSizes.rMd,
                  ),
                  child: Icon(
                    Icons.spa_rounded,
                    size: 32,
                    color: scheme.onPrimary,
                  ),
                ),
                const SizedBox(height: AppSizes.md),
                Text(
                  AppConstants.appName,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  AppConstants.appTagline,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.xs),
                Text(
                  'Version ${AppConstants.appVersion}',
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          Text(
            'Our Commitment',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: AppSizes.xs),
          Text(
            'ParaShop partners directly with certified European dermatological laboratories to guarantee authentic, fresh, temperature-monitored skincare, vitamins, baby care, and health essentials.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
