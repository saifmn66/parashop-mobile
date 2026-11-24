import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../models/address_model.dart';

class ProfileLocalDataSource {
  const ProfileLocalDataSource(this._storage);

  final LocalStorageService _storage;

  List<AddressModel> getAddresses() {
    final raw = _storage.getJsonList(AppConstants.keyAddresses);
    if (raw == null || raw.isEmpty) {
      return const [
        AddressModel(
          id: 'addr_1',
          label: 'Home',
          recipientName: 'Lina Benali',
          phone: '+33 6 42 18 90 12',
          street: '24 Rue du Faubourg Saint-Honoré',
          city: 'Paris',
          postalCode: '75008',
          country: 'France',
          isDefault: true,
        ),
        AddressModel(
          id: 'addr_2',
          label: 'Office',
          recipientName: 'Lina Benali',
          phone: '+33 6 42 18 90 12',
          street: '18 Avenue des Champs-Élysées',
          city: 'Paris',
          postalCode: '75008',
          country: 'France',
        ),
      ];
    }
    return raw
        .whereType<Map<String, dynamic>>()
        .map(AddressModel.fromJson)
        .toList();
  }

  Future<List<AddressModel>> saveAddresses(List<AddressModel> addresses) async {
    await _storage.setJsonList(
      AppConstants.keyAddresses,
      addresses.map((e) => e.toJson()).toList(),
    );
    return addresses;
  }

  String getLanguageCode() =>
      _storage.getString(AppConstants.keyLanguageCode) ?? 'en';

  Future<void> setLanguageCode(String code) =>
      _storage.setString(AppConstants.keyLanguageCode, code);

  Map<String, bool> getNotificationPrefs() {
    final map = _storage.getJsonMap(AppConstants.keyNotificationPrefs);
    if (map == null) {
      return const {
        'orders': true,
        'deliveries': true,
        'promotions': true,
      };
    }
    return map.map((k, v) => MapEntry(k, v == true));
  }

  Future<void> setNotificationPrefs(Map<String, bool> prefs) =>
      _storage.setJsonMap(AppConstants.keyNotificationPrefs, prefs);
}
