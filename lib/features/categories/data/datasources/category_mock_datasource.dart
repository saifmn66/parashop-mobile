import 'package:flutter/material.dart';

import '../../domain/entities/category_entity.dart';

class CategoryMockDataSource {
  const CategoryMockDataSource();

  List<CategoryEntity> getCategories() => const [
        CategoryEntity(
          id: 'skincare',
          name: 'Skincare',
          subtitle: 'Serums, cleansers & barrier repair',
          imageUrl:
              'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=600&q=80',
          icon: Icons.spa_outlined,
          productCount: 48,
          subcategories: [
            'Serums',
            'Cleansers',
            'Moisturizers',
            'Micellar Water',
            'Anti-Aging',
          ],
        ),
        CategoryEntity(
          id: 'sun_protection',
          name: 'Sun Protection',
          subtitle: 'Broad-spectrum SPF50+ & after-sun',
          imageUrl:
              'https://images.unsplash.com/photo-1556228852-6d35a585d566?auto=format&fit=crop&w=600&q=80',
          icon: Icons.wb_sunny_outlined,
          productCount: 24,
          subcategories: ['Face SPF', 'Body SPF', 'Kids SPF', 'After-Sun'],
        ),
        CategoryEntity(
          id: 'haircare',
          name: 'Haircare',
          subtitle: 'Scalp treatments & fortifying washes',
          imageUrl:
              'https://images.unsplash.com/photo-1535585209827-a15fcdbc4c2d?auto=format&fit=crop&w=600&q=80',
          icon: Icons.waves_rounded,
          productCount: 31,
          subcategories: ['Shampoos', 'Anti-Hair Loss', 'Masks', 'Scalp Care'],
        ),
        CategoryEntity(
          id: 'body_care',
          name: 'Body Care',
          subtitle: 'Botanical oils & lipid-rich balms',
          imageUrl:
              'https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?auto=format&fit=crop&w=600&q=80',
          icon: Icons.water_drop_outlined,
          productCount: 37,
          subcategories: ['Body Balms', 'Body Oils', 'Hand & Foot', 'Exfoliants'],
        ),
        CategoryEntity(
          id: 'vitamins',
          name: 'Vitamins & Supplements',
          subtitle: 'Immunity, collagen & daily vitality',
          imageUrl:
              'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=600&q=80',
          icon: Icons.medication_outlined,
          productCount: 42,
          subcategories: ['Immunity', 'Skin & Beauty', 'Magnesium', 'Probiotics'],
        ),
        CategoryEntity(
          id: 'baby_care',
          name: 'Baby Care',
          subtitle: 'Pediatrician-tested gentle formulas',
          imageUrl:
              'https://images.unsplash.com/photo-1584305574647-0cc949a2bb9f?auto=format&fit=crop&w=600&q=80',
          icon: Icons.child_care_rounded,
          productCount: 26,
          subcategories: ['Bath & Wash', 'Diaper Care', 'Baby Lotions'],
        ),
        CategoryEntity(
          id: 'hygiene',
          name: 'Hygiene',
          subtitle: 'Microbiome-friendly daily cleansers',
          imageUrl:
              'https://images.unsplash.com/photo-1556228578-8c89e6adf883?auto=format&fit=crop&w=600&q=80',
          icon: Icons.clean_hands_outlined,
          productCount: 29,
          subcategories: ['Shower Oils', 'Deodorants', 'Oral Care'],
        ),
        CategoryEntity(
          id: 'medical_equipment',
          name: 'Medical Equipment',
          subtitle: 'Home diagnostics & first aid',
          imageUrl:
              'https://images.unsplash.com/photo-1584515933487-779824d29309?auto=format&fit=crop&w=600&q=80',
          icon: Icons.monitor_heart_outlined,
          productCount: 19,
          subcategories: ['Diagnostics', 'Thermometers', 'First Aid'],
        ),
        CategoryEntity(
          id: 'makeup',
          name: 'Makeup',
          subtitle: 'Dermo-cosmetic tinted care',
          imageUrl:
              'https://images.unsplash.com/photo-1596462502278-27bfdc403348?auto=format&fit=crop&w=600&q=80',
          icon: Icons.face_retouching_natural_outlined,
          productCount: 22,
          subcategories: ['Tinted Care', 'Sensitive Eyes', 'Lip Care'],
        ),
      ];
}
