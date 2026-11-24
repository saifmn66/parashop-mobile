import 'package:equatable/equatable.dart';

class BasketItemEntity extends Equatable {
  const BasketItemEntity({
    required this.productId,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.variantId,
    required this.variantLabel,
    required this.unitPrice,
    this.originalPrice,
    required this.quantity,
  });

  final String productId;
  final String name;
  final String brand;
  final String imageUrl;
  final String variantId;
  final String variantLabel;
  final double unitPrice;
  final double? originalPrice;
  final int quantity;

  String get itemKey => '${productId}_$variantId';
  double get lineTotal => unitPrice * quantity;

  BasketItemEntity copyWith({int? quantity}) {
    return BasketItemEntity(
      productId: productId,
      name: name,
      brand: brand,
      imageUrl: imageUrl,
      variantId: variantId,
      variantLabel: variantLabel,
      unitPrice: unitPrice,
      originalPrice: originalPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        variantId,
        unitPrice,
        quantity,
      ];
}
