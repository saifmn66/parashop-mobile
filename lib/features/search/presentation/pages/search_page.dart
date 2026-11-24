import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../basket/presentation/controllers/basket_cubit.dart';
import '../controllers/search_cubit.dart';
import '../widgets/search_suggestions_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  late final SearchCubit _cubit = sl<SearchCubit>();

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close();
    super.dispose();
  }

  void _selectTerm(String term) {
    _controller.text = term;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: term.length),
    );
    _cubit.submitSearch(term);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return BlocProvider<SearchCubit>.value(
      value: _cubit,
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(title: 'Search'),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSizes.screenPadding,
                      AppSizes.xs,
                      AppSizes.screenPadding,
                      AppSizes.sm,
                    ),
                    child: AppSearchBar(
                      controller: _controller,
                      showClear: state.hasQuery,
                      onChanged: _cubit.onQueryChanged,
                      onSubmitted: _cubit.submitSearch,
                      onClear: () {
                        _controller.clear();
                        _cubit.clearQuery();
                      },
                    ),
                  ),
                  if (state.hasQuery && state.suggestions.isNotEmpty)
                    SizedBox(
                      height: 44,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: AppSizes.screenInsets,
                        itemCount: state.suggestions.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: AppSizes.xs),
                        itemBuilder: (context, i) {
                          final suggestion = state.suggestions[i];
                          return ActionChip(
                            label: Text(suggestion),
                            onPressed: () => _selectTerm(suggestion),
                          );
                        },
                      ),
                    ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: AppMotion.normal,
                      child: !state.hasQuery
                          ? SearchSuggestionsView(
                              key: const ValueKey('suggestions'),
                              recentSearches: state.recentSearches,
                              popularSearches: state.popularSearches,
                              onTermTap: _selectTerm,
                              onRemoveRecent: _cubit.removeRecent,
                              onClearRecent: _cubit.clearRecent,
                            )
                          : state.results.isEmpty
                              ? EmptyStateWidget(
                                  key: const ValueKey('empty'),
                                  icon: Icons.search_off_rounded,
                                  title: 'No results for "${state.query}"',
                                  description:
                                      'Check the spelling or try searching by brand, ingredient, or category.',
                                  actionLabel: 'Clear search',
                                  onActionTap: () {
                                    _controller.clear();
                                    _cubit.clearQuery();
                                  },
                                )
                              : ListView.separated(
                                  key: const ValueKey('results'),
                                  padding: const EdgeInsets.all(
                                    AppSizes.screenPadding,
                                  ),
                                  itemCount: state.results.length + 1,
                                  separatorBuilder: (_, _) =>
                                      const SizedBox(height: AppSizes.sm),
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                      return Text(
                                        '${state.results.length} results found',
                                        style: theme.textTheme.bodySmall,
                                      );
                                    }
                                    final product = state.results[index - 1];
                                    final tag = 'search-${product.id}';
                                    return AnimatedFadeSlide(
                                      delay: Duration(
                                        milliseconds: (index % 6) * 35,
                                      ),
                                      child: ProductHorizontalCard(
                                        id: product.id,
                                        heroTag: tag,
                                        name: product.name,
                                        brand: product.brand,
                                        imageUrl: product.primaryImage,
                                        price: product.price,
                                        originalPrice: product.originalPrice,
                                        subtitle: product.subcategory,
                                        rating: product.rating,
                                        onTap: () =>
                                            Navigator.of(context).pushNamed(
                                          AppRoutes.productDetail,
                                          arguments: (product, tag),
                                        ),
                                        trailing: IconButton(
                                          tooltip: 'Add to basket',
                                          style: IconButton.styleFrom(
                                            backgroundColor:
                                                scheme.secondaryContainer,
                                          ),
                                          icon: Icon(
                                            Icons.add_shopping_cart_rounded,
                                            size: 18,
                                            color: scheme.primary,
                                          ),
                                          onPressed: () {
                                            context
                                                .read<BasketCubit>()
                                                .addProduct(product);
                                            context.showAppSnackBar(
                                              'Added ${product.name} to basket',
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
