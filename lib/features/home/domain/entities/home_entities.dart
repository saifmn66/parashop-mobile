import 'package:equatable/equatable.dart';

class PromoBannerEntity extends Equatable {
  const PromoBannerEntity({
    required this.id,
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.imageUrl,
    this.targetCategoryId,
    this.onSaleOnly = false,
    this.isLightSurface = false,
  });

  final String id;
  final String tag;
  final String title;
  final String subtitle;
  final String ctaLabel;
  final String imageUrl;
  final String? targetCategoryId;
  final bool onSaleOnly;
  final bool isLightSurface;

  @override
  List<Object?> get props => [id, tag, title, targetCategoryId];
}

class BrandEntity extends Equatable {
  const BrandEntity({
    required this.name,
    required this.origin,
    required this.tagline,
  });

  final String name;
  final String origin;
  final String tagline;

  @override
  List<Object?> get props => [name, origin];
}
