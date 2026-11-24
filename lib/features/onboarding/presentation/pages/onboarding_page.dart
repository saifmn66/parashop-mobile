import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/primary_button.dart';
import '../controllers/onboarding_cubit.dart';
import '../widgets/onboarding_page_indicator.dart';
import '../widgets/onboarding_slide_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleNext(BuildContext context, OnboardingState state) async {
    if (state.isLastPage) {
      await context.read<OnboardingCubit>().finish();
    } else {
      await _pageController.nextPage(
        duration: AppMotion.slow,
        curve: AppMotion.curve,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (_) => sl<OnboardingCubit>(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listenWhen: (prev, curr) => !prev.isCompleted && curr.isCompleted,
        listener: (context, state) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.signIn);
        },
        builder: (context, state) {
          final theme = Theme.of(context);
          final scheme = theme.colorScheme;

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.screenPadding,
                      vertical: AppSizes.sm,
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: scheme.primary,
                                borderRadius: AppSizes.rSm,
                              ),
                              child: Icon(
                                Icons.spa_rounded,
                                size: 18,
                                color: scheme.onPrimary,
                              ),
                            ),
                            const SizedBox(width: AppSizes.xs),
                            Text(
                              'ParaShop',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        if (!state.isLastPage)
                          TextButton(
                            onPressed: () =>
                                context.read<OnboardingCubit>().finish(),
                            child: const Text('Skip'),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: state.steps.length,
                      onPageChanged: (index) =>
                          context.read<OnboardingCubit>().onPageChanged(index),
                      itemBuilder: (context, index) {
                        return OnboardingSlideWidget(
                          step: state.steps[index],
                          isActive: index == state.currentPage,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSizes.screenPadding,
                      AppSizes.sm,
                      AppSizes.screenPadding,
                      AppSizes.lg,
                    ),
                    child: Column(
                      children: [
                        OnboardingPageIndicator(
                          count: state.steps.length,
                          currentIndex: state.currentPage,
                        ),
                        const SizedBox(height: AppSizes.lg),
                        PrimaryButton(
                          label: state.isLastPage ? 'Get Started' : 'Continue',
                          icon: state.isLastPage
                              ? Icons.arrow_forward_rounded
                              : null,
                          onPressed: () => _handleNext(context, state),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
