import '../../domain/entities/home_entities.dart';

class HomeMockDataSource {
  const HomeMockDataSource();

  List<PromoBannerEntity> getBanners() => const [
        PromoBannerEntity(
          id: 'b_1',
          tag: 'CLINICAL GLOW',
          title: 'Up to 20% off\nBarrier Serums',
          subtitle: 'Hyaluronic, niacinamide & ceramide essentials.',
          ctaLabel: 'Shop Skincare',
          imageUrl:
              'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=700&q=80',
          targetCategoryId: 'skincare',
        ),
        PromoBannerEntity(
          id: 'b_2',
          tag: 'UV PROTECTION',
          title: 'Invisible Daily\nSPF50+ Fluids',
          subtitle: 'Zero white cast formulas for sensitive skin.',
          ctaLabel: 'Explore SPF',
          imageUrl:
              'https://images.unsplash.com/photo-1556228852-6d35a585d566?auto=format&fit=crop&w=700&q=80',
          targetCategoryId: 'sun_protection',
          isLightSurface: true,
        ),
        PromoBannerEntity(
          id: 'b_3',
          tag: 'MEMBER OFFER',
          title: 'Special Pharmacy\nBundle Deals',
          subtitle: 'Use code PARA15 for 15% off your basket.',
          ctaLabel: 'View Offers',
          imageUrl:
              'https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?auto=format&fit=crop&w=700&q=80',
          onSaleOnly: true,
        ),
      ];

  List<BrandEntity> getPopularBrands() => const [
        BrandEntity(
          name: 'La Roche-Posay',
          origin: 'France',
          tagline: 'Dermatological Skincare',
        ),
        BrandEntity(
          name: 'CeraVe',
          origin: 'USA',
          tagline: 'Essential Ceramides',
        ),
        BrandEntity(
          name: 'Avène',
          origin: 'France',
          tagline: 'Thermal Spring Care',
        ),
        BrandEntity(
          name: 'Bioderma',
          origin: 'France',
          tagline: 'Ecobiology Skin',
        ),
        BrandEntity(
          name: 'Nuxe',
          origin: 'France',
          tagline: 'Botanical Luxury',
        ),
        BrandEntity(
          name: 'Vichy',
          origin: 'France',
          tagline: 'Volcanic Mineral Care',
        ),
        BrandEntity(
          name: 'Mustela',
          origin: 'France',
          tagline: 'Baby & Maternity',
        ),
        BrandEntity(
          name: 'Solgar',
          origin: 'USA',
          tagline: 'Gold Standard Vitamins',
        ),
      ];
}
