import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_network_image.dart';

class ProductGalleryWidget extends StatefulWidget {
  const ProductGalleryWidget({
    super.key,
    required this.images,
    required this.heroTag,
    this.height = 420,
    this.indicatorBottomOffset = 42,
  });

  final List<String> images;
  final String heroTag;
  final double height;
  final double indicatorBottomOffset;

  @override
  State<ProductGalleryWidget> createState() => _ProductGalleryWidgetState();
}

class _ProductGalleryWidgetState extends State<ProductGalleryWidget> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imgs = widget.images.isNotEmpty ? widget.images : [''];

    return Container(
      height: widget.height,
      width: double.infinity,
      color: isDark ? AppColors.darkBeigeCard : AppColors.beigeCard,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: imgs.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              final img = AppNetworkImage(
                url: imgs[i],
                width: double.infinity,
                height: widget.height,
                fit: BoxFit.cover,
              );
              if (i == 0) {
                return Hero(tag: widget.heroTag, child: img);
              }
              return img;
            },
          ),
          if (imgs.length > 1)
            Positioned(
              bottom: widget.indicatorBottomOffset,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.darkSurface : AppColors.ivory)
                      .withValues(alpha: 0.85),
                  borderRadius: AppSizes.rPill,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(imgs.length, (i) {
                    final active = i == _index;
                    return AnimatedContainer(
                      duration: AppMotion.fast,
                      curve: AppMotion.curve,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: active ? 18 : 6,
                      height: 5,
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.primary
                            : AppColors.primary.withValues(alpha: 0.28),
                        borderRadius: AppSizes.rPill,
                      ),
                    );
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
