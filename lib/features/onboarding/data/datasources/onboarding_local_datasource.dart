import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/onboarding_step.dart';

class OnboardingLocalDataSource {
  const OnboardingLocalDataSource(this._storage);

  final LocalStorageService _storage;

  List<OnboardingStep> getSteps() => const [
        OnboardingStep(
          tag: 'CLINICAL SKINCARE',
          title: 'Dermatologist-curated\nessentials for your skin',
          description:
              'Explore authentic dermo-cosmetics, botanical serums, and daily care from trusted pharmacy laboratories.',
          imageUrl:
              'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=900&q=80',
          icon: Icons.spa_outlined,
          highlightLabel: '100% Authentic Pharmacy Brands',
        ),
        OnboardingStep(
          tag: 'PERSONALIZED CARE',
          title: 'Tailored routines for\nevery health & beauty need',
          description:
              'Filter by skin concern, active ingredients, and life stage — from sensitive baby care to daily vitamins.',
          imageUrl:
              'https://images.unsplash.com/photo-1556228720-195a672e8a03?auto=format&fit=crop&w=900&q=80',
          icon: Icons.auto_awesome_outlined,
          highlightLabel: 'Pharmacist-Approved Formulas',
        ),
        OnboardingStep(
          tag: 'EXPRESS DELIVERY',
          title: 'Delivered fresh to\nyour doorstep with care',
          description:
              'Enjoy temperature-safe packaging, real-time delivery tracking, and complimentary shipping on orders over €49.',
          imageUrl:
              'https://images.unsplash.com/photo-1608248597279-f99d160bfcbc?auto=format&fit=crop&w=900&q=80',
          icon: Icons.local_shipping_outlined,
          highlightLabel: 'Same-Day & Next-Day Delivery',
        ),
      ];

  bool isCompleted() =>
      _storage.getBool(AppConstants.keyOnboardingComplete);

  Future<void> markCompleted() =>
      _storage.setBool(AppConstants.keyOnboardingComplete, true);
}
