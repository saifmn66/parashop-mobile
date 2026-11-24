import '../../domain/entities/basket_item_entity.dart';

class BasketItemModel extends BasketItemEntity {
  const BasketItemModel({
    required super.productId,
    required super.name,
    required super.brand,
    required super.imageUrl,
    required super.variantId,
    required super.variantLabel,
    required super.unitPrice,
    super.originalPrice,
    required super.quantity,
  });

  factory BasketItemModel.fromEntity(BasketItemEntity e) => BasketItemModel(
        productId: e.productId,
        name: e.name,
        brand: e.brand,
        imageUrl: e.imageUrl,
        variantId: e.variantId,
        variantLabel: e.variantLabel,
        unitPrice: e.unitPrice,
        originalPrice: e.originalPrice,
        quantity: e.quantity,
      );

  factory BasketItemModel.fromJson(Map<String, dynamic> json) =>
      BasketItemModel(
        productId: json['productId'] as String,
        name: json['name'] as String,
        brand: json['brand'] as String,
        imageUrl: json['imageUrl'] as String? ?? '',
        variantId: json['variantId'] as String,
        variantLabel: json['variantLabel'] as String,
        unitPrice: (json['unitPrice'] as num).toDouble(),
        originalPrice: (json['originalPrice'] as num?)?.toDouble(),
        quantity: json['quantity'] as int? ?? 1,
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'brand': brand,
        'imageUrl': imageUrl,
        'variantId': variantId,
        'variantLabel': variantLabel,
        'unitPrice': unitPrice,
        'originalPrice': originalPrice,
        'quantity': quantity,
      };
}
