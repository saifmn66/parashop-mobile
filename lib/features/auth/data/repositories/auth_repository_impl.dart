import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._localDataSource);

  final AuthLocalDataSource _localDataSource;
  UserModel? _sessionUser;

  @override
  UserEntity? getCurrentUser() {
    _sessionUser ??= _localDataSource.getCachedUser();
    return _sessionUser;
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
    bool rememberMe = true,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 550));
    if (password.length < 8) {
      throw const ServerException(
        message: 'Invalid email or password. Password must be 8+ characters.',
        statusCode: 401,
      );
    }

    final namePart = email.split('@').first.replaceAll(RegExp(r'[._-]+'), ' ');
    final formattedName = namePart
        .split(' ')
        .where((s) => s.isNotEmpty)
        .map((s) => '${s[0].toUpperCase()}${s.substring(1)}')
        .join(' ');

    final user = UserModel(
      id: 'usr_${email.hashCode.abs()}',
      fullName: formattedName.isEmpty ? 'Lina Benali' : formattedName,
      email: email.trim(),
      phone: '+33 6 42 18 90 12',
      memberTier: 'Botanical Member',
      loyaltyPoints: 340,
    );
    _sessionUser = user;
    await _localDataSource.cacheUser(user, persist: rememberMe);
    return user;
  }

  @override
  Future<UserEntity> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 650));
    final user = UserModel(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      fullName: fullName.trim(),
      email: email.trim(),
      phone: phone.trim(),
      memberTier: 'New Member',
      loyaltyPoints: 100,
    );
    _sessionUser = user;
    await _localDataSource.cacheUser(user, persist: true);
    return user;
  }

  @override
  Future<UserEntity> signInWithSocial(String provider) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final user = UserModel(
      id: 'usr_social_${provider.toLowerCase()}',
      fullName: 'Lina Benali',
      email: 'lina.benali@parashop.example',
      phone: '+33 6 42 18 90 12',
      memberTier: 'Botanical Gold',
      loyaltyPoints: 480,
    );
    _sessionUser = user;
    await _localDataSource.cacheUser(user, persist: true);
    return user;
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserEntity> updateProfile({
    required String fullName,
    required String email,
    required String phone,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final current = getCurrentUser();
    final updated = UserModel(
      id: current?.id ?? 'usr_1',
      fullName: fullName.trim(),
      email: email.trim(),
      phone: phone.trim(),
      avatarUrl: current?.avatarUrl ?? '',
      memberTier: current?.memberTier ?? 'Botanical Member',
      loyaltyPoints: current?.loyaltyPoints ?? 240,
    );
    _sessionUser = updated;
    await _localDataSource.cacheUser(updated, persist: true);
    return updated;
  }

  @override
  Future<void> signOut() async {
    _sessionUser = null;
    await _localDataSource.clearUser();
  }
}
