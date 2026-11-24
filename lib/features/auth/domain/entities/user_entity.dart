import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone = '',
    this.avatarUrl = '',
    this.memberTier = 'Botanical Member',
    this.loyaltyPoints = 240,
  });

  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String avatarUrl;
  final String memberTier;
  final int loyaltyPoints;

  String get firstName {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) return 'Guest';
    return trimmed.split(' ').first;
  }

  String get initials {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return 'P';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  UserEntity copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    String? memberTier,
    int? loyaltyPoints,
  }) {
    return UserEntity(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      memberTier: memberTier ?? this.memberTier,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phone,
        avatarUrl,
        memberTier,
        loyaltyPoints,
      ];
}
