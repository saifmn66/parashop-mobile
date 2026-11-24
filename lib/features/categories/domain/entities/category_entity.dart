import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.imageUrl,
    required this.icon,
    required this.productCount,
    required this.subcategories,
  });

  final String id;
  final String name;
  final String subtitle;
  final String imageUrl;
  final IconData icon;
  final int productCount;
  final List<String> subcategories;

  @override
  List<Object?> get props => [id, name, productCount, subcategories];
}
