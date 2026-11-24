import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.fallbackIcon = Icons.spa_outlined,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    Widget content;
    if (url.isEmpty) {
      content = _Placeholder(
        scheme: scheme,
        icon: fallbackIcon,
        width: width,
        height: height,
      );
    } else {
      content = Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) return child;
          return AnimatedOpacity(
            opacity: frame == null ? 0 : 1,
            duration: AppMotion.normal,
            curve: AppMotion.curve,
            child: child,
          );
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            width: width,
            height: height,
            color: scheme.surfaceContainerHighest,
            alignment: Alignment.center,
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: scheme.primary.withValues(alpha: 0.4),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => _Placeholder(
          scheme: scheme,
          icon: fallbackIcon,
          width: width,
          height: height,
        ),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: content);
    }
    return content;
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.scheme,
    required this.icon,
    this.width,
    this.height,
  });

  final ColorScheme scheme;
  final IconData icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: scheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: AppSizes.iconLg,
        color: scheme.primary.withValues(alpha: 0.35),
      ),
    );
  }
}
