import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    super.phone,
    super.avatarUrl,
    super.memberTier,
    super.loyaltyPoints,
  });

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
        id: entity.id,
        fullName: entity.fullName,
        email: entity.email,
        phone: entity.phone,
        avatarUrl: entity.avatarUrl,
        memberTier: entity.memberTier,
        loyaltyPoints: entity.loyaltyPoints,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String? ?? 'user_1',
        fullName: json['fullName'] as String? ?? 'Lina Benali',
        email: json['email'] as String? ?? 'lina.benali@parashop.example',
        phone: json['phone'] as String? ?? '+33 6 42 18 90 12',
        avatarUrl: json['avatarUrl'] as String? ?? '',
        memberTier: json['memberTier'] as String? ?? 'Botanical Member',
        loyaltyPoints: json['loyaltyPoints'] as int? ?? 240,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'email': email,
        'phone': phone,
        'avatarUrl': avatarUrl,
        'memberTier': memberTier,
        'loyaltyPoints': loyaltyPoints,
      };
}
