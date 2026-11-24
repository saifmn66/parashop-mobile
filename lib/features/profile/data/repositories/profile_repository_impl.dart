import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../models/address_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._localDataSource);

  final ProfileLocalDataSource _localDataSource;

  @override
  List<AddressEntity> getAddresses() => _localDataSource.getAddresses();

  @override
  Future<List<AddressEntity>> saveAddresses(List<AddressEntity> addresses) =>
      _localDataSource.saveAddresses(
        addresses.map(AddressModel.fromEntity).toList(),
      );

  @override
  String getLanguageCode() => _localDataSource.getLanguageCode();

  @override
  Future<void> setLanguageCode(String code) =>
      _localDataSource.setLanguageCode(code);

  @override
  Map<String, bool> getNotificationPrefs() =>
      _localDataSource.getNotificationPrefs();

  @override
  Future<void> setNotificationPrefs(Map<String, bool> prefs) =>
      _localDataSource.setNotificationPrefs(prefs);
}
