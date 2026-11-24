import '../entities/basket_item_entity.dart';
import '../repositories/basket_repository.dart';

class LoadBasketUseCase {
  const LoadBasketUseCase(this._repository);
  final BasketRepository _repository;

  (List<BasketItemEntity>, List<BasketItemEntity>) call() =>
      (_repository.getItems(), _repository.getSavedForLater());
}

class PersistBasketUseCase {
  const PersistBasketUseCase(this._repository);
  final BasketRepository _repository;

  Future<void> call(
    List<BasketItemEntity> items,
    List<BasketItemEntity> saved,
  ) async {
    await _repository.saveItems(items);
    await _repository.saveForLaterItems(saved);
  }
}
