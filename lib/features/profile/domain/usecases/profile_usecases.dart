import '../entities/address_entity.dart';
import '../repositories/profile_repository.dart';

class ManageAddressesUseCase {
  const ManageAddressesUseCase(this._repository);
  final ProfileRepository _repository;

  List<AddressEntity> getAll() => _repository.getAddresses();
  Future<List<AddressEntity>> saveAll(List<AddressEntity> list) =>
      _repository.saveAddresses(list);
}

class ManageProfilePreferencesUseCase {
  const ManageProfilePreferencesUseCase(this._repository);
  final ProfileRepository _repository;

  String getLanguage() => _repository.getLanguageCode();
  Future<void> setLanguage(String code) => _repository.setLanguageCode(code);
  Map<String, bool> getNotificationPrefs() =>
      _repository.getNotificationPrefs();
  Future<void> setNotificationPrefs(Map<String, bool> prefs) =>
      _repository.setNotificationPrefs(prefs);
}
