import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/address_entity.dart';
import '../../domain/usecases/profile_usecases.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.addresses,
    required this.languageCode,
    required this.notificationPrefs,
  });

  final List<AddressEntity> addresses;
  final String languageCode;
  final Map<String, bool> notificationPrefs;

  AddressEntity? get defaultAddress {
    for (final a in addresses) {
      if (a.isDefault) return a;
    }
    return addresses.isNotEmpty ? addresses.first : null;
  }

  ProfileState copyWith({
    List<AddressEntity>? addresses,
    String? languageCode,
    Map<String, bool>? notificationPrefs,
  }) {
    return ProfileState(
      addresses: addresses ?? this.addresses,
      languageCode: languageCode ?? this.languageCode,
      notificationPrefs: notificationPrefs ?? this.notificationPrefs,
    );
  }

  @override
  List<Object?> get props => [addresses, languageCode, notificationPrefs];
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.manageAddresses,
    required this.managePreferences,
  }) : super(
          ProfileState(
            addresses: manageAddresses.getAll(),
            languageCode: managePreferences.getLanguage(),
            notificationPrefs: managePreferences.getNotificationPrefs(),
          ),
        );

  final ManageAddressesUseCase manageAddresses;
  final ManageProfilePreferencesUseCase managePreferences;

  Future<void> addAddress(AddressEntity address) async {
    final list = state.addresses
        .map(
          (a) => address.isDefault ? a.copyWith(isDefault: false) : a,
        )
        .toList();
    list.add(address);
    await manageAddresses.saveAll(list);
    emit(state.copyWith(addresses: list));
  }

  Future<void> setDefaultAddress(String id) async {
    final list = state.addresses
        .map((a) => a.copyWith(isDefault: a.id == id))
        .toList();
    await manageAddresses.saveAll(list);
    emit(state.copyWith(addresses: list));
  }

  Future<void> removeAddress(String id) async {
    final list = state.addresses.where((a) => a.id != id).toList();
    if (list.isNotEmpty && !list.any((a) => a.isDefault)) {
      list[0] = list[0].copyWith(isDefault: true);
    }
    await manageAddresses.saveAll(list);
    emit(state.copyWith(addresses: list));
  }

  Future<void> setLanguage(String code) async {
    await managePreferences.setLanguage(code);
    emit(state.copyWith(languageCode: code));
  }

  Future<void> toggleNotificationPref(String key, bool value) async {
    final updated = Map<String, bool>.from(state.notificationPrefs)
      ..[key] = value;
    await managePreferences.setNotificationPrefs(updated);
    emit(state.copyWith(notificationPrefs: updated));
  }
}
