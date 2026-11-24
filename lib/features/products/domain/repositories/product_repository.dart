import '../entities/product_entity.dart';

abstract class ProductRepository {
  List<ProductEntity> getAllProducts();
  ProductEntity? getProductById(String id);
  List<ProductEntity> getFilteredProducts(ProductFilter filter);
  List<ProductEntity> searchProducts(String query);
  List<ProductEntity> getRelatedProducts(ProductEntity product);
  List<String> getAllBrands();
  List<ProductEntity> getRecentlyViewed();
  Future<void> markAsViewed(String productId);
}
