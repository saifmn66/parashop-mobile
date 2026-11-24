import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_network_image.dart';
import '../../domain/entities/onboarding_step.dart';

class OnboardingSlideWidget extends StatelessWidget {
  const OnboardingSlideWidget({
    super.key,
    required this.step,
    required this.isActive,
  });

  final OnboardingStep step;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: AppSizes.screenInsets,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSizes.sm),
          Expanded(
            flex: 5,
            child: AnimatedScale(
              scale: isActive ? 1.0 : 0.94,
              duration: AppMotion.slow,
              curve: AppMotion.curve,
              child: AnimatedOpacity(
                opacity: isActive ? 1.0 : 0.6,
                duration: AppMotion.slow,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: AppSizes.rLg,
                        color: scheme.surfaceContainerHighest,
                        boxShadow: AppShadows.soft,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: AppNetworkImage(
                        url: step.imageUrl,
                        fit: BoxFit.cover,
                        fallbackIcon: step.icon,
                      ),
                    ),
                    Positioned(
                      left: AppSizes.md,
                      bottom: AppSizes.md,
                      right: AppSizes.md,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.sm + 2,
                          vertical: AppSizes.xs + 2,
                        ),
                        decoration: BoxDecoration(
                          color: scheme.surface.withValues(alpha: 0.94),
                          borderRadius: AppSizes.rPill,
                          border: Border.all(color: scheme.outline),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: scheme.secondaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                step.icon,
                                size: 16,
                                color: scheme.primary,
                              ),
                            ),
                            const SizedBox(width: AppSizes.xs),
                            Flexible(
                              child: Text(
                                step.highlightLabel,
                                style: theme.textTheme.labelMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.lg),
          AnimatedSlide(
            offset: isActive ? Offset.zero : const Offset(0, 0.08),
            duration: AppMotion.slow,
            curve: AppMotion.curve,
            child: AnimatedOpacity(
              opacity: isActive ? 1.0 : 0.0,
              duration: AppMotion.normal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.sm,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: scheme.secondaryContainer,
                      borderRadius: AppSizes.rPill,
                    ),
                    child: Text(
                      step.tag,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: scheme.onSecondaryContainer,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    step.title,
                    style: theme.textTheme.headlineMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    step.description,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSizes.sm),
        ],
      ),
    );
  }
}
