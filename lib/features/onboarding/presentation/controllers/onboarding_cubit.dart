import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/onboarding_step.dart';
import '../../domain/usecases/onboarding_usecases.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    required this.steps,
    this.currentPage = 0,
    this.isCompleted = false,
  });

  final List<OnboardingStep> steps;
  final int currentPage;
  final bool isCompleted;

  bool get isLastPage => currentPage >= steps.length - 1;

  OnboardingState copyWith({
    List<OnboardingStep>? steps,
    int? currentPage,
    bool? isCompleted,
  }) {
    return OnboardingState(
      steps: steps ?? this.steps,
      currentPage: currentPage ?? this.currentPage,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [steps, currentPage, isCompleted];
}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required GetOnboardingStepsUseCase getSteps,
    required this.completeOnboarding,
  }) : super(OnboardingState(steps: getSteps()));

  final CompleteOnboardingUseCase completeOnboarding;

  void onPageChanged(int index) {
    emit(state.copyWith(currentPage: index));
  }

  Future<void> finish() async {
    await completeOnboarding();
    emit(state.copyWith(isCompleted: true));
  }
}
