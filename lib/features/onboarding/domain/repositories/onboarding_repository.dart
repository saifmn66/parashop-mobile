import '../entities/onboarding_step.dart';

abstract class OnboardingRepository {
  List<OnboardingStep> getSteps();
  bool isCompleted();
  Future<void> markCompleted();
}
