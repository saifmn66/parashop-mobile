import '../entities/address_entity.dart';

abstract class ProfileRepository {
  List<AddressEntity> getAddresses();
  Future<List<AddressEntity>> saveAddresses(List<AddressEntity> addresses);
  String getLanguageCode();
  Future<void> setLanguageCode(String code);
  Map<String, bool> getNotificationPrefs();
  Future<void> setNotificationPrefs(Map<String, bool> prefs);
}
