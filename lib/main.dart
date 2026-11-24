import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_constants.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/router/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/auth/presentation/controllers/auth_bloc.dart';
import 'features/basket/presentation/controllers/basket_cubit.dart';
import 'features/favorites/presentation/controllers/favorites_cubit.dart';
import 'features/onboarding/domain/repositories/onboarding_repository.dart';
import 'features/profile/presentation/controllers/profile_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const ParaShopApp());
}

class ParaShopApp extends StatelessWidget {
  const ParaShopApp({super.key});

  String _resolveInitialRoute() {
    final onboardingDone = sl<OnboardingRepository>().isCompleted();
    if (!onboardingDone) return AppRoutes.onboarding;
    return AppRoutes.main;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: sl<ThemeCubit>()),
        BlocProvider<AuthBloc>.value(
          value: sl<AuthBloc>()..add(const AuthCheckRequested()),
        ),
        BlocProvider<FavoritesCubit>.value(value: sl<FavoritesCubit>()),
        BlocProvider<BasketCubit>.value(value: sl<BasketCubit>()),
        BlocProvider<ProfileCubit>.value(value: sl<ProfileCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeMode,
            initialRoute: _resolveInitialRoute(),
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
