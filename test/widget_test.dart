import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parashopmobile/core/constants/app_constants.dart';
import 'package:parashopmobile/core/di/service_locator.dart';
import 'package:parashopmobile/core/router/app_routes.dart';
import 'package:parashopmobile/features/products/domain/usecases/product_usecases.dart';
import 'package:parashopmobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('ParaShopApp shows onboarding on first launch', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await sl.reset();
    await initDependencies();

    await tester.pumpWidget(const ParaShopApp());
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
  });

  testWidgets('Redesigned 4-tab navigation (Home, Shop, Favorites, Profile)', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({
      AppConstants.keyOnboardingComplete: true,
    });
    await sl.reset();
    await initDependencies();

    await tester.pumpWidget(const ParaShopApp());
    await tester.pump(const Duration(milliseconds: 500));

    // Home screen
    expect(find.text('Best for You'), findsOneWidget);
    expect(find.text('See All'), findsOneWidget);

    // Shop tab
    await tester.tap(find.text('Shop'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Skincare'), findsWidgets);

    // Favorites tab
    await tester.tap(find.text('Favorites'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('No favorites yet'), findsOneWidget);

    // Profile tab
    await tester.tap(find.text('Profile'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('ACCOUNT'), findsOneWidget);
  });

  testWidgets('Redesigned ProductDetailPage: overlap, qty, tabs, Add to Cart', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390 * 3, 844 * 3);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({
      AppConstants.keyOnboardingComplete: true,
    });
    await sl.reset();
    await initDependencies();

    await tester.pumpWidget(const ParaShopApp());
    await tester.pump(const Duration(milliseconds: 500));

    final product = sl<GetAllProductsUseCase>()().first;
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushNamed(
      AppRoutes.productDetail,
      arguments: (product, 'test-hero'),
    );
    await tester.pumpAndSettle();

    // Product info & purchase row visible
    expect(find.text(product.name), findsOneWidget);
    expect(find.text('Add to Cart'), findsOneWidget);

    // Quantity increment
    await tester.tap(find.byIcon(Icons.add_rounded).first);
    await tester.pumpAndSettle();
    expect(find.text('2'), findsOneWidget);

    // Tabs: Details -> Ingredients -> Reviews
    await tester.ensureVisible(find.text('Ingredients'));
    await tester.pumpAndSettle();

    expect(find.text('Details'), findsOneWidget);
    await tester.tap(find.text('Ingredients'));
    await tester.pumpAndSettle();
    expect(find.text(product.ingredients.first), findsOneWidget);

    await tester.ensureVisible(find.text('Reviews'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reviews'));
    await tester.pumpAndSettle();
    expect(find.textContaining('verified reviews'), findsOneWidget);

    // Benefits row visible at bottom
    await tester.ensureVisible(find.text('Soothes\nredness'));
    await tester.pumpAndSettle();
    expect(find.text('Soothes\nredness'), findsOneWidget);
  });
}
