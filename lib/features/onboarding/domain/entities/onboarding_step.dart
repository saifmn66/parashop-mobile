import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OnboardingStep extends Equatable {
  const OnboardingStep({
    required this.tag,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.icon,
    required this.highlightLabel,
  });

  final String tag;
  final String title;
  final String description;
  final String imageUrl;
  final IconData icon;
  final String highlightLabel;

  @override
  List<Object?> get props => [
        tag,
        title,
        description,
        imageUrl,
        icon,
        highlightLabel,
      ];
}
