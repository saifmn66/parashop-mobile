import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/basket_item_entity.dart';
import '../../domain/usecases/basket_usecases.dart';

class BasketState extends Equatable {
  const BasketState({
    this.items = const [],
    this.savedForLater = const [],
    this.promoCode,
    this.promoDiscountRate = 0,
    this.promoError,
  });

  final List<BasketItemEntity> items;
  final List<BasketItemEntity> savedForLater;
  final String? promoCode;
  final double promoDiscountRate;
  final String? promoError;

  int get totalCount => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.lineTotal);

  double get discount => subtotal * promoDiscountRate;

  double get deliveryFee {
    if (items.isEmpty) return 0;
    return subtotal >= AppConstants.freeDeliveryThreshold
        ? 0
        : AppConstants.standardDeliveryFee;
  }

  double get amountUntilFreeDelivery =>
      (AppConstants.freeDeliveryThreshold - subtotal).clamp(0, double.infinity);

  double get freeDeliveryProgress =>
      (subtotal / AppConstants.freeDeliveryThreshold).clamp(0.0, 1.0);

  double get total => (subtotal - discount + deliveryFee).clamp(0, double.infinity);

  BasketState copyWith({
    List<BasketItemEntity>? items,
    List<BasketItemEntity>? savedForLater,
    String? promoCode,
    bool clearPromo = false,
    double? promoDiscountRate,
    String? promoError,
    bool clearPromoError = false,
  }) {
    return BasketState(
      items: items ?? this.items,
      savedForLater: savedForLater ?? this.savedForLater,
      promoCode: clearPromo ? null : (promoCode ?? this.promoCode),
      promoDiscountRate:
          clearPromo ? 0 : (promoDiscountRate ?? this.promoDiscountRate),
      promoError: clearPromoError ? null : (promoError ?? this.promoError),
    );
  }

  @override
  List<Object?> get props => [
        items,
        savedForLater,
        promoCode,
        promoDiscountRate,
        promoError,
      ];
}

class BasketCubit extends Cubit<BasketState> {
  BasketCubit({
    required LoadBasketUseCase loadBasket,
    required this.persistBasket,
  }) : super(_initialState(loadBasket));

  final PersistBasketUseCase persistBasket;

  static BasketState _initialState(LoadBasketUseCase loadBasket) {
    final (items, saved) = loadBasket();
    return BasketState(items: items, savedForLater: saved);
  }

  Future<void> addProduct(
    ProductEntity product, {
    ProductVariant? variant,
    int quantity = 1,
  }) async {
    final chosen = variant ??
        (product.variants.isNotEmpty
            ? product.variants.first
            : ProductVariant(
                id: '${product.id}_default',
                label: 'Standard',
                price: product.price,
                originalPrice: product.originalPrice,
              ));

    final updated = List<BasketItemEntity>.from(state.items);
    final idx = updated.indexWhere(
      (i) => i.productId == product.id && i.variantId == chosen.id,
    );

    if (idx >= 0) {
      updated[idx] =
          updated[idx].copyWith(quantity: updated[idx].quantity + quantity);
    } else {
      updated.add(
        BasketItemEntity(
          productId: product.id,
          name: product.name,
          brand: product.brand,
          imageUrl: product.primaryImage,
          variantId: chosen.id,
          variantLabel: chosen.label,
          unitPrice: chosen.price,
          originalPrice: chosen.originalPrice,
          quantity: quantity,
        ),
      );
    }

    emit(state.copyWith(items: updated));
    await persistBasket(updated, state.savedForLater);
  }

  Future<void> updateQuantity(String itemKey, int newQuantity) async {
    if (newQuantity <= 0) {
      await removeItem(itemKey);
      return;
    }
    final updated = state.items
        .map((i) => i.itemKey == itemKey ? i.copyWith(quantity: newQuantity) : i)
        .toList();
    emit(state.copyWith(items: updated));
    await persistBasket(updated, state.savedForLater);
  }

  Future<void> removeItem(String itemKey) async {
    final updated = state.items.where((i) => i.itemKey != itemKey).toList();
    emit(state.copyWith(items: updated));
    await persistBasket(updated, state.savedForLater);
  }

  Future<void> saveItemForLater(String itemKey) async {
    final target = state.items.firstWhere(
      (i) => i.itemKey == itemKey,
      orElse: () => throw StateError('Item not found'),
    );
    final updatedItems = state.items.where((i) => i.itemKey != itemKey).toList();
    final updatedSaved = [
      target.copyWith(quantity: 1),
      ...state.savedForLater.where((i) => i.itemKey != itemKey),
    ];
    emit(state.copyWith(items: updatedItems, savedForLater: updatedSaved));
    await persistBasket(updatedItems, updatedSaved);
  }

  Future<void> moveSavedToBasket(String itemKey) async {
    final target = state.savedForLater.firstWhere(
      (i) => i.itemKey == itemKey,
      orElse: () => throw StateError('Item not found'),
    );
    final updatedSaved =
        state.savedForLater.where((i) => i.itemKey != itemKey).toList();
    final updatedItems = List<BasketItemEntity>.from(state.items);
    final idx = updatedItems.indexWhere((i) => i.itemKey == itemKey);
    if (idx >= 0) {
      updatedItems[idx] =
          updatedItems[idx].copyWith(quantity: updatedItems[idx].quantity + 1);
    } else {
      updatedItems.add(target);
    }
    emit(state.copyWith(items: updatedItems, savedForLater: updatedSaved));
    await persistBasket(updatedItems, updatedSaved);
  }

  Future<void> removeSavedItem(String itemKey) async {
    final updatedSaved =
        state.savedForLater.where((i) => i.itemKey != itemKey).toList();
    emit(state.copyWith(savedForLater: updatedSaved));
    await persistBasket(state.items, updatedSaved);
  }

  bool applyPromoCode(String rawCode) {
    final code = rawCode.trim().toUpperCase();
    if (code.isEmpty) {
      emit(state.copyWith(promoError: 'Enter a promo code'));
      return false;
    }
    final rate = AppConstants.promoCodes[code];
    if (rate == null) {
      emit(state.copyWith(
        promoError: 'Invalid code. Try WELCOME10, PARA15, or SKIN20.',
      ));
      return false;
    }
    emit(state.copyWith(
      promoCode: code,
      promoDiscountRate: rate,
      clearPromoError: true,
    ));
    return true;
  }

  void clearPromoCode() {
    emit(state.copyWith(clearPromo: true, clearPromoError: true));
  }

  Future<void> clearBasket() async {
    emit(state.copyWith(items: const [], clearPromo: true, clearPromoError: true));
    await persistBasket(const [], state.savedForLater);
  }
}
