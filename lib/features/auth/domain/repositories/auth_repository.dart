import '../entities/user_entity.dart';

abstract class AuthRepository {
  UserEntity? getCurrentUser();

  Future<UserEntity> signIn({
    required String email,
    required String password,
    bool rememberMe = true,
  });

  Future<UserEntity> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  });

  Future<UserEntity> signInWithSocial(String provider);

  Future<void> sendPasswordReset(String email);

  Future<UserEntity> updateProfile({
    required String fullName,
    required String email,
    required String phone,
  });

  Future<void> signOut();
}
