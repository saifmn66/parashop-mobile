import '../../domain/entities/onboarding_step.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  List<OnboardingStep> getSteps() => _localDataSource.getSteps();

  @override
  bool isCompleted() => _localDataSource.isCompleted();

  @override
  Future<void> markCompleted() => _localDataSource.markCompleted();
}
