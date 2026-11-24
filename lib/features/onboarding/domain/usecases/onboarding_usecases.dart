import '../entities/onboarding_step.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingStepsUseCase {
  const GetOnboardingStepsUseCase(this._repository);

  final OnboardingRepository _repository;

  List<OnboardingStep> call() => _repository.getSteps();
}

class CompleteOnboardingUseCase {
  const CompleteOnboardingUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<void> call() => _repository.markCompleted();
}
