import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({
    super.key,
    required this.onGoogleTap,
    required this.onAppleTap,
    this.isLoading = false,
  });

  final VoidCallback onGoogleTap;
  final VoidCallback onAppleTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: scheme.outline)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: Text('or continue with', style: theme.textTheme.bodySmall),
            ),
            Expanded(child: Divider(color: scheme.outline)),
          ],
        ),
        const SizedBox(height: AppSizes.md),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isLoading ? null : onGoogleTap,
                icon: const Icon(Icons.g_mobiledata_rounded, size: 26),
                label: const Text('Google'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
                  backgroundColor: scheme.surface,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.sm),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isLoading ? null : onAppleTap,
                icon: const Icon(Icons.apple_rounded, size: 22),
                label: const Text('Apple'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(AppSizes.buttonHeight),
                  backgroundColor: scheme.surface,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
