import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  const AddressEntity({
    required this.id,
    required this.label,
    required this.recipientName,
    required this.phone,
    required this.street,
    required this.city,
    required this.postalCode,
    this.country = 'France',
    this.isDefault = false,
  });

  final String id;
  final String label;
  final String recipientName;
  final String phone;
  final String street;
  final String city;
  final String postalCode;
  final String country;
  final bool isDefault;

  String get formattedLine => '$street, $postalCode $city, $country';

  AddressEntity copyWith({
    String? label,
    String? recipientName,
    String? phone,
    String? street,
    String? city,
    String? postalCode,
    String? country,
    bool? isDefault,
  }) {
    return AddressEntity(
      id: id,
      label: label ?? this.label,
      recipientName: recipientName ?? this.recipientName,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
        id,
        label,
        recipientName,
        phone,
        street,
        city,
        postalCode,
        country,
        isDefault,
      ];
}
