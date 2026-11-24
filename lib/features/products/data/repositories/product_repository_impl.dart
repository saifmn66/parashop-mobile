import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_mock_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._mockDataSource, this._storage);

  final ProductMockDataSource _mockDataSource;
  final LocalStorageService _storage;

  @override
  List<ProductEntity> getAllProducts() => _mockDataSource.getProducts();

  @override
  ProductEntity? getProductById(String id) {
    for (final p in _mockDataSource.getProducts()) {
      if (p.id == id) return p;
    }
    return null;
  }

  @override
  List<ProductEntity> getFilteredProducts(ProductFilter filter) {
    var list = _mockDataSource.getProducts().where((p) {
      if (filter.categoryId != null && p.categoryId != filter.categoryId) {
        return false;
      }
      if (filter.subcategory != null &&
          p.subcategory.toLowerCase() != filter.subcategory!.toLowerCase()) {
        return false;
      }
      if (filter.brands.isNotEmpty && !filter.brands.contains(p.brand)) {
        return false;
      }
      if (p.price < filter.minPrice || p.price > filter.maxPrice) {
        return false;
      }
      if (filter.inStockOnly && !p.inStock) {
        return false;
      }
      if (filter.onSaleOnly && !p.hasDiscount) {
        return false;
      }
      return true;
    }).toList();

    switch (filter.sort) {
      case ProductSort.popularity:
        list.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
      case ProductSort.newest:
        list.sort((a, b) {
          final aNew = a.isNewArrival ? 1 : 0;
          final bNew = b.isNewArrival ? 1 : 0;
          return bNew.compareTo(aNew);
        });
      case ProductSort.priceLowToHigh:
        list.sort((a, b) => a.price.compareTo(b.price));
      case ProductSort.priceHighToLow:
        list.sort((a, b) => b.price.compareTo(a.price));
      case ProductSort.rating:
        list.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return list;
  }

  @override
  List<ProductEntity> searchProducts(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return _mockDataSource.getProducts().where((p) {
      return p.name.toLowerCase().contains(q) ||
          p.brand.toLowerCase().contains(q) ||
          p.subcategory.toLowerCase().contains(q) ||
          p.categoryId.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q);
    }).toList();
  }

  @override
  List<ProductEntity> getRelatedProducts(ProductEntity product) {
    return _mockDataSource
        .getProducts()
        .where(
          (p) =>
              p.id != product.id &&
              (p.categoryId == product.categoryId || p.brand == product.brand),
        )
        .take(6)
        .toList();
  }

  @override
  List<String> getAllBrands() {
    final set = _mockDataSource.getProducts().map((p) => p.brand).toSet();
    final sorted = set.toList()..sort();
    return sorted;
  }

  @override
  List<ProductEntity> getRecentlyViewed() {
    final ids = _storage.getStringList(AppConstants.keyRecentlyViewedIds);
    final all = _mockDataSource.getProducts();
    if (ids.isEmpty) return all.take(4).toList();
    final map = {for (final p in all) p.id: p};
    return ids.map((id) => map[id]).whereType<ProductEntity>().toList();
  }

  @override
  Future<void> markAsViewed(String productId) async {
    final ids = _storage.getStringList(AppConstants.keyRecentlyViewedIds).toList();
    ids.remove(productId);
    ids.insert(0, productId);
    if (ids.length > 10) {
      ids.removeRange(10, ids.length);
    }
    await _storage.setStringList(AppConstants.keyRecentlyViewedIds, ids);
  }
}
