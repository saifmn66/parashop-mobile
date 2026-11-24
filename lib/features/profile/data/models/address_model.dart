import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.label,
    required super.recipientName,
    required super.phone,
    required super.street,
    required super.city,
    required super.postalCode,
    super.country,
    super.isDefault,
  });

  factory AddressModel.fromEntity(AddressEntity e) => AddressModel(
        id: e.id,
        label: e.label,
        recipientName: e.recipientName,
        phone: e.phone,
        street: e.street,
        city: e.city,
        postalCode: e.postalCode,
        country: e.country,
        isDefault: e.isDefault,
      );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['id'] as String,
        label: json['label'] as String? ?? 'Home',
        recipientName: json['recipientName'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        street: json['street'] as String? ?? '',
        city: json['city'] as String? ?? '',
        postalCode: json['postalCode'] as String? ?? '',
        country: json['country'] as String? ?? 'France',
        isDefault: json['isDefault'] as bool? ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'recipientName': recipientName,
        'phone': phone,
        'street': street,
        'city': city,
        'postalCode': postalCode,
        'country': country,
        'isDefault': isDefault,
      };
}
