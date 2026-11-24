import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/main_shell.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../controllers/basket_cubit.dart';
import '../widgets/basket_item_tile.dart';
import '../widgets/basket_summary_card.dart';
import '../widgets/promo_code_card.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketCubit, BasketState>(
      builder: (context, state) {
        final cubit = context.read<BasketCubit>();
        final theme = Theme.of(context);

        return Scaffold(
          appBar: CustomAppBar(
            title: 'Basket',
            subtitle: state.items.isEmpty
                ? null
                : '${state.totalCount} ${state.totalCount == 1 ? 'item' : 'items'}',
            actions: [
              if (state.items.isNotEmpty)
                IconButton(
                  tooltip: 'Clear basket',
                  icon: const Icon(Icons.delete_sweep_outlined),
                  onPressed: () async {
                    final confirm = await ConfirmationDialog.show(
                      context,
                      title: 'Clear basket?',
                      message:
                          'Remove all items from your shopping basket?',
                      confirmLabel: 'Clear',
                      isDestructive: true,
                    );
                    if (confirm) await cubit.clearBasket();
                  },
                ),
            ],
          ),
          body: state.items.isEmpty && state.savedForLater.isEmpty
              ? EmptyStateWidget(
                  icon: Icons.shopping_bag_outlined,
                  title: 'Your basket is empty',
                  description:
                      'Discover dermatologist-approved skincare, vitamins, and daily care essentials.',
                  actionLabel: 'Start Shopping',
                  onActionTap: () => MainShell.of(context)?.switchTab(0),
                )
              : ListView(
                  padding: const EdgeInsets.all(AppSizes.screenPadding),
                  children: [
                    if (state.items.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.lg),
                        child: EmptyStateWidget(
                          icon: Icons.shopping_bag_outlined,
                          title: 'Basket is empty',
                          description:
                              'Move items from Saved for Later below or continue browsing.',
                          actionLabel: 'Continue Shopping',
                          onActionTap: () =>
                              MainShell.of(context)?.switchTab(0),
                        ),
                      )
                    else ...[
                      ...List.generate(state.items.length, (i) {
                        final item = state.items[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.sm),
                          child: AnimatedFadeSlide(
                            delay: Duration(milliseconds: i * 40),
                            child: BasketItemTile(
                              item: item,
                              onIncrement: () => cubit.updateQuantity(
                                item.itemKey,
                                item.quantity + 1,
                              ),
                              onDecrement: () => cubit.updateQuantity(
                                item.itemKey,
                                item.quantity - 1,
                              ),
                              onRemove: () {
                                cubit.removeItem(item.itemKey);
                                context.showAppSnackBar(
                                  'Removed ${item.name}',
                                );
                              },
                              onSaveForLater: () {
                                cubit.saveItemForLater(item.itemKey);
                                context.showAppSnackBar(
                                  'Saved ${item.name} for later',
                                );
                              },
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: AppSizes.xs),
                      PromoCodeCard(
                        appliedCode: state.promoCode,
                        discountRate: state.promoDiscountRate,
                        errorText: state.promoError,
                        onApply: cubit.applyPromoCode,
                        onRemove: cubit.clearPromoCode,
                      ),
                      const SizedBox(height: AppSizes.md),
                      BasketSummaryCard(
                        state: state,
                        onCheckout: () => context.showAppSnackBar(
                          'Checkout flow arriving in next phase!',
                        ),
                        onContinueShopping: () =>
                            MainShell.of(context)?.switchTab(0),
                      ),
                    ],
                    if (state.savedForLater.isNotEmpty) ...[
                      const SizedBox(height: AppSizes.xl),
                      Text(
                        'Saved for Later (${state.savedForLater.length})',
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSizes.sm),
                      ...state.savedForLater.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSizes.sm),
                          child: ProductHorizontalCard(
                            id: item.productId,
                            heroTag: 'saved-${item.itemKey}',
                            name: item.name,
                            brand: item.brand,
                            imageUrl: item.imageUrl,
                            price: item.unitPrice,
                            originalPrice: item.originalPrice,
                            subtitle: item.variantLabel,
                            onTap: () {},
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Move to basket',
                                  icon: const Icon(
                                    Icons.add_shopping_cart_rounded,
                                    size: 19,
                                  ),
                                  onPressed: () =>
                                      cubit.moveSavedToBasket(item.itemKey),
                                ),
                                IconButton(
                                  tooltip: 'Remove',
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                  ),
                                  onPressed: () =>
                                      cubit.removeSavedItem(item.itemKey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSizes.lg),
                  ],
                ),
        );
      },
    );
  }
}
