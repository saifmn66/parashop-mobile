import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../models/basket_item_model.dart';

class BasketLocalDataSource {
  const BasketLocalDataSource(this._storage);

  final LocalStorageService _storage;

  List<BasketItemModel> getItems() => _readList(AppConstants.keyBasketItems);

  List<BasketItemModel> getSavedForLater() =>
      _readList(AppConstants.keySavedForLater);

  Future<void> saveItems(List<BasketItemModel> items) => _storage.setJsonList(
        AppConstants.keyBasketItems,
        items.map((e) => e.toJson()).toList(),
      );

  Future<void> saveForLater(List<BasketItemModel> items) =>
      _storage.setJsonList(
        AppConstants.keySavedForLater,
        items.map((e) => e.toJson()).toList(),
      );

  List<BasketItemModel> _readList(String key) {
    final raw = _storage.getJsonList(key);
    if (raw == null) return const [];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(BasketItemModel.fromJson)
        .toList();
  }
}
