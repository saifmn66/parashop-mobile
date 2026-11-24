import '../entities/basket_item_entity.dart';

abstract class BasketRepository {
  List<BasketItemEntity> getItems();
  List<BasketItemEntity> getSavedForLater();
  Future<void> saveItems(List<BasketItemEntity> items);
  Future<void> saveForLaterItems(List<BasketItemEntity> items);
}
