import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/sign_in_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/basket/presentation/pages/basket_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/products/domain/entities/product_entity.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/products/presentation/pages/product_list_page.dart';
import '../../features/profile/presentation/pages/about_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/manage_addresses_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import 'app_routes.dart';
import 'main_shell.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const OnboardingPage(),
        );
      case AppRoutes.signIn:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const SignInPage(),
        );
      case AppRoutes.signUp:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const SignUpPage(),
        );
      case AppRoutes.forgotPassword:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const ForgotPasswordPage(),
        );
      case AppRoutes.productList:
        final args = settings.arguments is ProductListPageArgs
            ? settings.arguments as ProductListPageArgs
            : const ProductListPageArgs(title: 'Products');
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => ProductListPage(args: args),
        );
      case AppRoutes.productDetail:
        final (product, heroTag) =
            settings.arguments as (ProductEntity, String);
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => ProductDetailPage(product: product, heroTag: heroTag),
        );
      case AppRoutes.search:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const SearchPage(),
        );
      case AppRoutes.basket:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const BasketPage(),
        );
      case AppRoutes.favorites:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const FavoritesPage(),
        );
      case AppRoutes.editProfile:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const EditProfilePage(),
        );
      case AppRoutes.addresses:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const ManageAddressesPage(),
        );
      case AppRoutes.about:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const AboutPage(),
        );
      case AppRoutes.splash:
      case AppRoutes.main:
        final initialIndex =
            settings.arguments is int ? settings.arguments as int : 0;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => MainShell(initialIndex: initialIndex),
        );
      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const MainShell(),
        );
    }
  }
}
