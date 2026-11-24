import 'package:equatable/equatable.dart';

class ProductVariant extends Equatable {
  const ProductVariant({
    required this.id,
    required this.label,
    required this.price,
    this.originalPrice,
    this.inStock = true,
  });

  final String id;
  final String label;
  final double price;
  final double? originalPrice;
  final bool inStock;

  @override
  List<Object?> get props => [id, label, price, originalPrice, inStock];
}

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.categoryId,
    required this.subcategory,
    required this.description,
    required this.benefits,
    required this.ingredients,
    required this.usageInstructions,
    required this.images,
    required this.price,
    this.originalPrice,
    required this.rating,
    required this.reviewCount,
    required this.variants,
    this.inStock = true,
    this.isBestSeller = false,
    this.isNewArrival = false,
    this.isRecommended = false,
    this.badgeText,
  });

  final String id;
  final String name;
  final String brand;
  final String categoryId;
  final String subcategory;
  final String description;
  final List<String> benefits;
  final List<String> ingredients;
  final String usageInstructions;
  final List<String> images;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewCount;
  final List<ProductVariant> variants;
  final bool inStock;
  final bool isBestSeller;
  final bool isNewArrival;
  final bool isRecommended;
  final String? badgeText;

  String get primaryImage => images.isNotEmpty ? images.first : '';
  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  @override
  List<Object?> get props => [
        id,
        name,
        brand,
        categoryId,
        subcategory,
        price,
        originalPrice,
        rating,
        reviewCount,
        inStock,
      ];
}

enum ProductSort {
  popularity('Most Popular'),
  newest('Newest'),
  priceLowToHigh('Price: Low to High'),
  priceHighToLow('Price: High to Low'),
  rating('Top Rated');

  const ProductSort(this.label);
  final String label;
}

class ProductFilter extends Equatable {
  const ProductFilter({
    this.categoryId,
    this.subcategory,
    this.brands = const {},
    this.minPrice = 0,
    this.maxPrice = 150,
    this.inStockOnly = false,
    this.onSaleOnly = false,
    this.sort = ProductSort.popularity,
  });

  final String? categoryId;
  final String? subcategory;
  final Set<String> brands;
  final double minPrice;
  final double maxPrice;
  final bool inStockOnly;
  final bool onSaleOnly;
  final ProductSort sort;

  int get activeFilterCount {
    var count = 0;
    if (brands.isNotEmpty) count++;
    if (minPrice > 0 || maxPrice < 150) count++;
    if (inStockOnly) count++;
    if (onSaleOnly) count++;
    return count;
  }

  ProductFilter copyWith({
    String? categoryId,
    bool clearCategory = false,
    String? subcategory,
    bool clearSubcategory = false,
    Set<String>? brands,
    double? minPrice,
    double? maxPrice,
    bool? inStockOnly,
    bool? onSaleOnly,
    ProductSort? sort,
  }) {
    return ProductFilter(
      categoryId: clearCategory ? null : (categoryId ?? this.categoryId),
      subcategory:
          clearSubcategory ? null : (subcategory ?? this.subcategory),
      brands: brands ?? this.brands,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      inStockOnly: inStockOnly ?? this.inStockOnly,
      onSaleOnly: onSaleOnly ?? this.onSaleOnly,
      sort: sort ?? this.sort,
    );
  }

  @override
  List<Object?> get props => [
        categoryId,
        subcategory,
        brands,
        minPrice,
        maxPrice,
        inStockOnly,
        onSaleOnly,
        sort,
      ];
}
