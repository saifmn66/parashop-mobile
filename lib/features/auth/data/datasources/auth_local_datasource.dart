import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  const AuthLocalDataSource(this._storage);

  final LocalStorageService _storage;

  UserModel? getCachedUser() {
    final map = _storage.getJsonMap(AppConstants.keyAuthUser);
    if (map == null) return null;
    return UserModel.fromJson(map);
  }

  Future<void> cacheUser(UserModel user, {bool persist = true}) async {
    await _storage.setBool(AppConstants.keyRememberMe, persist);
    if (persist) {
      await _storage.setJsonMap(AppConstants.keyAuthUser, user.toJson());
    }
  }

  Future<void> clearUser() async {
    await _storage.remove(AppConstants.keyAuthUser);
  }
}
