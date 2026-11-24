import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  UserEntity? call() => _repository.getCurrentUser();
}

class SignInUseCase {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call({
    required String email,
    required String password,
    bool rememberMe = true,
  }) =>
      _repository.signIn(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );
}

class SignUpUseCase {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) =>
      _repository.signUp(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );
}

class SocialSignInUseCase {
  const SocialSignInUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call(String provider) =>
      _repository.signInWithSocial(provider);
}

class ForgotPasswordUseCase {
  const ForgotPasswordUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call(String email) => _repository.sendPasswordReset(email);
}

class UpdateProfileUseCase {
  const UpdateProfileUseCase(this._repository);

  final AuthRepository _repository;

  Future<UserEntity> call({
    required String fullName,
    required String email,
    required String phone,
  }) =>
      _repository.updateProfile(
        fullName: fullName,
        email: email,
        phone: phone,
      );
}

class SignOutUseCase {
  const SignOutUseCase(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.signOut();
}
