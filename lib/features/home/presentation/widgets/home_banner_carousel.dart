import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/promotional_banner.dart';
import '../../domain/entities/home_entities.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({
    super.key,
    required this.banners,
    required this.onBannerTap,
  });

  final List<PromoBannerEntity> banners;
  final ValueChanged<PromoBannerEntity> onBannerTap;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  final _controller = PageController();
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    if (widget.banners.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!mounted || !_controller.hasClients) return;
        final next = (_index + 1) % widget.banners.length;
        _controller.animateToPage(
          next,
          duration: AppMotion.slow,
          curve: AppMotion.curve,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(
          height: 204,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.banners.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              final banner = widget.banners[i];
              return Padding(
                padding: AppSizes.screenInsets,
                child: PromotionalBanner(
                  tag: banner.tag,
                  title: banner.title,
                  subtitle: banner.subtitle,
                  ctaLabel: banner.ctaLabel,
                  imageUrl: banner.imageUrl,
                  isLightSurface: banner.isLightSurface,
                  onTap: () => widget.onBannerTap(banner),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (i) {
            final active = i == _index;
            return AnimatedContainer(
              duration: AppMotion.normal,
              curve: AppMotion.curve,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 22 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: active
                    ? scheme.primary
                    : scheme.primary.withValues(alpha: 0.22),
                borderRadius: AppSizes.rPill,
              ),
            );
          }),
        ),
      ],
    );
  }
}
