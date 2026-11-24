import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/router/main_shell.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../products/domain/entities/product_entity.dart';
import '../../../products/presentation/pages/product_list_page.dart';
import '../../domain/entities/category_entity.dart';
import '../controllers/categories_cubit.dart';
import '../widgets/category_subcategory_strip.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  void _openCategory(
    BuildContext context,
    CategoryEntity category, {
    String? subcategory,
  }) {
    Navigator.of(context).pushNamed(
      AppRoutes.productList,
      arguments: ProductListPageArgs(
        title: subcategory ?? category.name,
        initialFilter: ProductFilter(
          categoryId: category.id,
          subcategory: subcategory,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoriesCubit>(
      create: (_) => sl<CategoriesCubit>(),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          final selected = state.selectedCategory;

          return Scaffold(
            appBar: CustomAppBar(
              title: 'Categories',
              showBack: false,
              actions: [
                IconButton(
                  tooltip: 'Search',
                  onPressed: () => MainShell.of(context)?.switchTab(2),
                  icon: const Icon(Icons.search_rounded),
                ),
              ],
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSizes.screenPadding,
                      AppSizes.xs,
                      AppSizes.screenPadding,
                      AppSizes.md,
                    ),
                    child: Text(
                      'Browse by health, clinical skincare, and everyday pharmacy departments.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: AnimatedSize(
                    duration: AppMotion.normal,
                    curve: AppMotion.curve,
                    child: selected == null
                        ? const SizedBox.shrink()
                        : CategorySubcategoryStrip(
                            category: selected,
                            onViewAllTap: () => _openCategory(context, selected),
                            onSubcategoryTap: (sub) => _openCategory(
                              context,
                              selected,
                              subcategory: sub,
                            ),
                          ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSizes.screenPadding,
                    0,
                    AppSizes.screenPadding,
                    AppSizes.xl,
                  ),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isTablet ? 3 : 2,
                      crossAxisSpacing: AppSizes.sm,
                      mainAxisSpacing: AppSizes.sm,
                      childAspectRatio: 0.92,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final category = state.categories[index];
                        return AnimatedFadeSlide(
                          delay: Duration(milliseconds: index * 45),
                          child: GestureDetector(
                            onLongPress: () => context
                                .read<CategoriesCubit>()
                                .selectCategory(category.id),
                            child: CategoryCard(
                              name: category.name,
                              imageUrl: category.imageUrl,
                              icon: category.icon,
                              productCount: category.productCount,
                              onTap: () {
                                if (state.selectedCategoryId == category.id) {
                                  _openCategory(context, category);
                                } else {
                                  context
                                      .read<CategoriesCubit>()
                                      .selectCategory(category.id);
                                }
                              },
                            ),
                          ),
                        );
                      },
                      childCount: state.categories.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
