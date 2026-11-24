import '../../domain/entities/product_entity.dart';

class ProductMockDataSource {
  const ProductMockDataSource();

  List<ProductEntity> getProducts() => _products;

  static const List<ProductEntity> _products = [
    ProductEntity(
      id: 'p_01',
      name: 'Hyalu B5 Pure Hyaluronic Acid Serum',
      brand: 'La Roche-Posay',
      categoryId: 'skincare',
      subcategory: 'Serums',
      description:
          'A concentrated dermatological anti-aging serum formulated with two molecular weights of pure hyaluronic acid, vitamin B5, and madecassoside to visibly plump and repair the skin barrier.',
      benefits: [
        'Intensely hydrates and plumps dehydrated skin',
        'Visibly reduces fine lines and restores elasticity',
        'Soothes and repairs compromised skin barrier',
        'Dermatologist tested for sensitive skin',
      ],
      ingredients: [
        'Pure Hyaluronic Acid (High & Low Molecular Weight)',
        'Vitamin B5 (Panthenol 5%)',
        'Madecassoside',
        'La Roche-Posay Thermal Spring Water',
      ],
      usageInstructions:
          'Apply 3–4 drops morning and evening to clean, slightly damp face and neck. Follow with moisturizer and SPF in the morning.',
      images: [
        'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1611930022073-b7a4ba5fcccd?auto=format&fit=crop&w=800&q=80',
      ],
      price: 34.90,
      originalPrice: 42.00,
      rating: 4.9,
      reviewCount: 418,
      isBestSeller: true,
      isRecommended: true,
      variants: [
        ProductVariant(
          id: 'p_01_30',
          label: '30 ml',
          price: 34.90,
          originalPrice: 42.00,
        ),
        ProductVariant(
          id: 'p_01_50',
          label: '50 ml',
          price: 49.90,
          originalPrice: 58.00,
        ),
      ],
    ),
    ProductEntity(
      id: 'p_02',
      name: 'Hydrating Facial Cleanser with Ceramides',
      brand: 'CeraVe',
      categoryId: 'skincare',
      subcategory: 'Cleansers',
      description:
          'Developed with dermatologists, this non-foaming lotion gently removes dirt, makeup, and excess oil without disrupting the protective skin barrier.',
      benefits: [
        'Cleanses without tightness or dryness',
        'Restores essential ceramides 1, 3, and 6-II',
        'MVE technology provides 24-hour hydration',
        'Fragrance-free & non-comedogenic',
      ],
      ingredients: [
        'Ceramide NP, AP, EOP',
        'Hyaluronic Acid',
        'Glycerin',
        'MVE Delivery System',
      ],
      usageInstructions:
          'Wet skin with lukewarm water. Massage cleanser onto skin in gentle circular motions, then rinse thoroughly.',
      images: [
        'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=800&q=80',
      ],
      price: 13.50,
      rating: 4.8,
      reviewCount: 625,
      isBestSeller: true,
      isRecommended: true,
      variants: [
        ProductVariant(id: 'p_02_236', label: '236 ml', price: 13.50),
        ProductVariant(id: 'p_02_473', label: '473 ml', price: 19.90),
      ],
    ),
    ProductEntity(
      id: 'p_03',
      name: 'Anthelios UVMune 400 Invisible Fluid SPF50+',
      brand: 'La Roche-Posay',
      categoryId: 'sun_protection',
      subcategory: 'Face SPF',
      description:
          'Ultra-light invisible sunscreen featuring Mexoryl 400 to shield against ultra-long UVA rays. Water, sweat, and sand resistant with zero white cast.',
      benefits: [
        'Broad-spectrum SPF50+ protection against ultra-long UVA',
        'Featherlight invisible finish with no white cast',
        'Anti-eye stinging formula for sensitive eyes',
        'Resistant to water, sweat, and sand',
      ],
      ingredients: [
        'Mexoryl 400',
        'Netlock Technology',
        'Vitamin E',
        'Thermal Spring Water',
      ],
      usageInstructions:
          'Shake well before use. Apply generously 15 minutes before sun exposure and reapply every 2 hours or after swimming.',
      images: [
        'https://images.unsplash.com/photo-1556228852-6d35a585d566?auto=format&fit=crop&w=800&q=80',
        'https://images.unsplash.com/photo-1598440947619-2c35fc9aa908?auto=format&fit=crop&w=800&q=80',
      ],
      price: 19.90,
      originalPrice: 24.50,
      rating: 4.9,
      reviewCount: 512,
      isBestSeller: true,
      isNewArrival: true,
      variants: [
        ProductVariant(
          id: 'p_03_50',
          label: '50 ml',
          price: 19.90,
          originalPrice: 24.50,
        ),
        ProductVariant(
          id: 'p_03_tinted',
          label: '50 ml Tinted',
          price: 21.50,
          originalPrice: 25.50,
        ),
      ],
    ),
    ProductEntity(
      id: 'p_04',
      name: 'Sensibio H2O Micellar Water',
      brand: 'Bioderma',
      categoryId: 'skincare',
      subcategory: 'Micellar Water',
      description:
          'The iconic dermatological micellar water engineered to respect sensitive skin while effortlessly removing makeup, pollution, and impurities.',
      benefits: [
        'Removes 99% of makeup and fine pollution particles',
        'Soothes redness and prevents irritation',
        'No-rinse physiological pH 5.5 formula',
      ],
      ingredients: [
        'Fatty Acid Esters Micelles',
        'Cucumber Fruit Extract',
        'DAF Patented Complex',
      ],
      usageInstructions:
          'Soak a cotton pad and gently cleanse face and eyes morning and evening. No rinsing required.',
      images: [
        'https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?auto=format&fit=crop&w=800&q=80',
      ],
      price: 14.90,
      originalPrice: 17.90,
      rating: 4.9,
      reviewCount: 890,
      isBestSeller: true,
      variants: [
        ProductVariant(
          id: 'p_04_250',
          label: '250 ml',
          price: 11.90,
        ),
        ProductVariant(
          id: 'p_04_500',
          label: '500 ml',
          price: 14.90,
          originalPrice: 17.90,
        ),
      ],
    ),
    ProductEntity(
      id: 'p_05',
      name: 'Cicalfate+ Restorative Protective Cream',
      brand: 'Avène',
      categoryId: 'skincare',
      subcategory: 'Moisturizers',
      description:
          'Rich postbiotic barrier cream that accelerates skin repair within 48 hours and soothes dry, irritated skin for the whole family.',
      benefits: [
        'Repairs skin 4x faster with [C+-Restore] postbiotic',
        'Copper-zinc complex purifies and limits bacterial risk',
        'Safe for infants, children, and adults',
      ],
      ingredients: [
        'Avène Thermal Spring Water',
        '[C+-Restore] Postbiotic Active',
        'Copper & Zinc Sulfate',
      ],
      usageInstructions:
          'Apply twice daily to clean, dry irritated areas of the face or body.',
      images: [
        'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&w=800&q=80',
      ],
      price: 12.90,
      rating: 4.8,
      reviewCount: 344,
      isRecommended: true,
      variants: [
        ProductVariant(id: 'p_05_40', label: '40 ml', price: 12.90),
        ProductVariant(id: 'p_05_100', label: '100 ml', price: 18.90),
      ],
    ),
    ProductEntity(
      id: 'p_06',
      name: 'Dercos Energy+ Stimulating Shampoo',
      brand: 'Vichy',
      categoryId: 'haircare',
      subcategory: 'Shampoos',
      description:
          'Fortifying hair-loss companion shampoo enriched with Aminexil and Niacinamide to revitalize fragile hair from root to tip.',
      benefits: [
        'Strengthens weakened hair fibers by +47%',
        'Supports healthier, fuller-looking scalp density',
        'Gentle daily dermatological formula',
      ],
      ingredients: [
        'Aminexil',
        'Niacinamide',
        'AHA & Vitamin E',
        'Vichy Volcanic Water',
      ],
      usageInstructions:
          'Massage into wet scalp for 1 minute to boost microcirculation, then rinse thoroughly.',
      images: [
        'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&w=800&q=80',
      ],
      price: 15.90,
      originalPrice: 18.50,
      rating: 4.7,
      reviewCount: 219,
      isRecommended: true,
      variants: [
        ProductVariant(
          id: 'p_06_200',
          label: '200 ml',
          price: 15.90,
          originalPrice: 18.50,
        ),
        ProductVariant(
          id: 'p_06_400',
          label: '400 ml Pump',
          price: 23.90,
          originalPrice: 27.90,
        ),
      ],
    ),
    ProductEntity(
      id: 'p_07',
      name: 'Huile Prodigieuse Multi-Purpose Dry Oil',
      brand: 'Nuxe',
      categoryId: 'body_care',
      subcategory: 'Body Oils',
      description:
          'Botanical dry oil blending 7 precious 100% plant oils to nourish, repair, and illuminate face, body, and hair with a satin finish.',
      benefits: [
        'Nourishes without greasy residue',
        'Antioxidant shield against urban pollution',
        '98% natural-origin botanical ingredients',
      ],
      ingredients: [
        'Tsubaki Oil',
        'Argan Oil',
        'Sweet Almond & Macadamia Oils',
        'Vitamin E',
      ],
      usageInstructions:
          'Warm a few drops in palms and smooth onto body, hair lengths, or mix one drop into your daily face cream.',
      images: [
        'https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?auto=format&fit=crop&w=800&q=80',
      ],
      price: 27.90,
      originalPrice: 32.00,
      rating: 4.9,
      reviewCount: 530,
      isBestSeller: true,
      isNewArrival: true,
      variants: [
        ProductVariant(id: 'p_07_50', label: '50 ml', price: 19.90),
        ProductVariant(
          id: 'p_07_100',
          label: '100 ml',
          price: 27.90,
          originalPrice: 32.00,
        ),
      ],
    ),
    ProductEntity(
      id: 'p_08',
      name: 'Gentle Cleansing Gel with Organic Avocado',
      brand: 'Mustela',
      categoryId: 'baby_care',
      subcategory: 'Bath & Wash',
      description:
          'Tear-free biodegradable hair and body wash crafted with patented Avocado Perseose to protect delicate newborn and baby skin.',
      benefits: [
        'Safe from birth including NICU newborns',
        '93% ingredients of natural origin',
        'Soap-free, tear-free, pediatrician tested',
      ],
      ingredients: [
        'Organic Avocado Perseose',
        'Vitamin B5',
        'Mild Surfactants',
      ],
      usageInstructions:
          'Pour a small amount into hand, lather gently over baby’s wet hair and body, and rinse with warm water.',
      images: [
        'https://images.unsplash.com/photo-1584305574647-0cc949a2bb9f?auto=format&fit=crop&w=800&q=80',
      ],
      price: 11.40,
      rating: 4.9,
      reviewCount: 287,
      isRecommended: true,
      variants: [
        ProductVariant(id: 'p_08_500', label: '500 ml Pump', price: 11.40),
        ProductVariant(id: 'p_08_750', label: '750 ml Family', price: 15.90),
      ],
    ),
    ProductEntity(
      id: 'p_09',
      name: 'Vitamin D3 + K2 Botanical Drops',
      brand: 'Solgar',
      categoryId: 'vitamins',
      subcategory: 'Immunity',
      description:
          'High-absorption cholecalciferol paired with bioavailable MK-7 vitamin K2 in cold-pressed organic olive oil for bone and immune health.',
      benefits: [
        'Supports immune defense and calcium absorption',
        'Clean botanical carrier with zero synthetic fillers',
        'Precision glass dropper for daily dosing',
      ],
      ingredients: [
        'Vitamin D3 (2000 IU)',
        'Vitamin K2 (MK-7 75 mcg)',
        'Organic Extra-Virgin Olive Oil',
      ],
      usageInstructions:
          'Take 5 drops daily with a meal or as directed by your pharmacist.',
      images: [
        'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=800&q=80',
      ],
      price: 22.50,
      rating: 4.8,
      reviewCount: 176,
      isNewArrival: true,
      badgeText: 'NEW',
      variants: [
        ProductVariant(id: 'p_09_30', label: '30 ml (60 days)', price: 22.50),
        ProductVariant(id: 'p_09_60', label: '60 ml (120 days)', price: 38.90),
      ],
    ),
    ProductEntity(
      id: 'p_10',
      name: 'M3 Comfort Upper Arm Blood Pressure Monitor',
      brand: 'Omron',
      categoryId: 'medical_equipment',
      subcategory: 'Diagnostics',
      description:
          'Clinically validated digital blood pressure monitor featuring Intelli Wrap 360° cuff accuracy and irregular heartbeat detection.',
      benefits: [
        '360° accurate readings in any upper-arm position',
        'Detects irregular heartbeat & morning hypertension',
        'Dual-user memory stores 60 readings per profile',
      ],
      ingredients: [
        'Intelli Wrap Cuff (22–42 cm)',
        'LED Cuff Wrap Guide',
        'Storage Case & Batteries Included',
      ],
      usageInstructions:
          'Sit calmly for 5 minutes, wrap the cuff 2 cm above the elbow, rest arm at heart level, and press Start.',
      images: [
        'https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=800&q=80',
      ],
      price: 69.00,
      originalPrice: 79.00,
      rating: 4.9,
      reviewCount: 154,
      isRecommended: true,
      variants: [
        ProductVariant(
          id: 'p_10_std',
          label: 'Standard Kit',
          price: 69.00,
          originalPrice: 79.00,
        ),
        ProductVariant(
          id: 'p_10_ac',
          label: 'Kit + AC Adapter',
          price: 78.00,
          originalPrice: 89.00,
        ),
      ],
    ),
    ProductEntity(
      id: 'p_11',
      name: 'pH5 Gentle Shower Oil for Sensitive Skin',
      brand: 'Eucerin',
      categoryId: 'hygiene',
      subcategory: 'Shower Oils',
      description:
          'Soap-free lipid-replenishing cleansing oil with Dexpanthenol that preserves the skin microbiome even with frequent showering.',
      benefits: [
        'Protects skin’s natural enzyme activity and pH',
        'Prevents dryness and itchiness from hard water',
        'Silky lather suitable for dry & atopic skin',
      ],
      ingredients: [
        '53% Natural Care Oils',
        'Dexpanthenol',
        'pH5 Citrate Buffer',
      ],
      usageInstructions:
          'Apply to damp skin during shower, massage gently, and rinse thoroughly.',
      images: [
        'https://images.unsplash.com/photo-1556228578-8c89e6adf883?auto=format&fit=crop&w=800&q=80',
      ],
      price: 16.50,
      rating: 4.7,
      reviewCount: 204,
      variants: [
        ProductVariant(id: 'p_11_400', label: '400 ml', price: 16.50),
        ProductVariant(id: 'p_11_1000', label: '1 L Refill', price: 29.90),
      ],
    ),
    ProductEntity(
      id: 'p_12',
      name: 'Toleriane Sensitive Le Teint Crème SPF',
      brand: 'La Roche-Posay',
      categoryId: 'makeup',
      subcategory: 'Tinted Care',
      description:
          'Dermatological tinted moisturizer with prebiotic thermal water and purified mineral pigments for breathable, natural coverage.',
      benefits: [
        'Instant sheer-to-medium natural glow',
        'Calms redness and strengthens skin microbiome',
        'Non-comedogenic & fragrance-free',
      ],
      ingredients: [
        'Niacinamide',
        'Ceramide',
        'Purified Mineral Pigments',
        'Thermal Spring Water',
      ],
      usageInstructions:
          'Smooth evenly across face and neck every morning with fingertips or a damp sponge.',
      images: [
        'https://images.unsplash.com/photo-1596462502278-27bfdc403348?auto=format&fit=crop&w=800&q=80',
      ],
      price: 21.90,
      rating: 4.6,
      reviewCount: 132,
      isNewArrival: true,
      badgeText: 'NEW',
      variants: [
        ProductVariant(id: 'p_12_light', label: '50 ml • Light', price: 21.90),
        ProductVariant(id: 'p_12_med', label: '50 ml • Medium', price: 21.90),
      ],
    ),
    ProductEntity(
      id: 'p_13',
      name: 'Lipikar Baume AP+M Triple-Action Balm',
      brand: 'La Roche-Posay',
      categoryId: 'body_care',
      subcategory: 'Body Balms',
      description:
          'Microbiome-balancing body balm formulated for very dry and eczema-prone skin to immediately soothe itching and space out flare-ups.',
      benefits: [
        'Immediate anti-scratching soothing relief',
        'Rebalances skin microbiome with Aqua Posae Filiformis',
        'Fast-absorbing non-sticky texture',
      ],
      ingredients: [
        'Shea Butter 20%',
        'Niacinamide',
        'Aqua Posae Filiformis + Microrésyl',
      ],
      usageInstructions:
          'Apply once daily to face and body after cleansing with a gentle lipid-replenishing wash.',
      images: [
        'https://images.unsplash.com/photo-1612817288484-6f916006741a?auto=format&fit=crop&w=800&q=80',
      ],
      price: 24.90,
      originalPrice: 29.50,
      rating: 4.9,
      reviewCount: 468,
      isBestSeller: true,
      variants: [
        ProductVariant(id: 'p_13_200', label: '200 ml Tube', price: 17.90),
        ProductVariant(
          id: 'p_13_400',
          label: '400 ml Pump',
          price: 24.90,
          originalPrice: 29.50,
        ),
      ],
    ),
    ProductEntity(
      id: 'p_14',
      name: 'Marine Collagen + Vitamin C Complex',
      brand: 'Solgar',
      categoryId: 'vitamins',
      subcategory: 'Skin & Beauty',
      description:
          'Hydrolyzed Type I & III marine collagen peptides combined with vitamin C and zinc to support skin firmness, hair strength, and joints.',
      benefits: [
        'Clinically studied low-molecular collagen peptides',
        'Vitamin C boosts endogenous collagen synthesis',
        'Neutral taste dissolves seamlessly in water or tea',
      ],
      ingredients: [
        'Hydrolyzed Marine Collagen (5000 mg)',
        'Vitamin C (80 mg)',
        'Zinc Bisglycinate',
        'Hyaluronic Acid',
      ],
      usageInstructions:
          'Mix one scoop daily into water, coffee, or a smoothie.',
      images: [
        'https://images.unsplash.com/photo-1550572017-edd951aa8f72?auto=format&fit=crop&w=800&q=80',
      ],
      price: 36.00,
      originalPrice: 41.00,
      rating: 4.8,
      reviewCount: 193,
      isNewArrival: true,
      variants: [
        ProductVariant(
          id: 'p_14_200g',
          label: '200 g Jar',
          price: 36.00,
          originalPrice: 41.00,
        ),
      ],
    ),
  ];
}
