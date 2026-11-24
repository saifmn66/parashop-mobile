import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetAllProductsUseCase {
  const GetAllProductsUseCase(this._repository);
  final ProductRepository _repository;
  List<ProductEntity> call() => _repository.getAllProducts();
}

class GetFilteredProductsUseCase {
  const GetFilteredProductsUseCase(this._repository);
  final ProductRepository _repository;
  List<ProductEntity> call(ProductFilter filter) =>
      _repository.getFilteredProducts(filter);
}

class GetProductByIdUseCase {
  const GetProductByIdUseCase(this._repository);
  final ProductRepository _repository;
  ProductEntity? call(String id) => _repository.getProductById(id);
}

class GetRelatedProductsUseCase {
  const GetRelatedProductsUseCase(this._repository);
  final ProductRepository _repository;
  List<ProductEntity> call(ProductEntity product) =>
      _repository.getRelatedProducts(product);
}

class GetRecentlyViewedUseCase {
  const GetRecentlyViewedUseCase(this._repository);
  final ProductRepository _repository;
  List<ProductEntity> call() => _repository.getRecentlyViewed();
}

class MarkProductViewedUseCase {
  const MarkProductViewedUseCase(this._repository);
  final ProductRepository _repository;
  Future<void> call(String productId) => _repository.markAsViewed(productId);
}
