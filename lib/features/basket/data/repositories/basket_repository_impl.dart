import '../../domain/entities/basket_item_entity.dart';
import '../../domain/repositories/basket_repository.dart';
import '../datasources/basket_local_datasource.dart';
import '../models/basket_item_model.dart';

class BasketRepositoryImpl implements BasketRepository {
  const BasketRepositoryImpl(this._localDataSource);

  final BasketLocalDataSource _localDataSource;

  @override
  List<BasketItemEntity> getItems() => _localDataSource.getItems();

  @override
  List<BasketItemEntity> getSavedForLater() =>
      _localDataSource.getSavedForLater();

  @override
  Future<void> saveItems(List<BasketItemEntity> items) =>
      _localDataSource.saveItems(
        items.map(BasketItemModel.fromEntity).toList(),
      );

  @override
  Future<void> saveForLaterItems(List<BasketItemEntity> items) =>
      _localDataSource.saveForLater(
        items.map(BasketItemModel.fromEntity).toList(),
      );
}
