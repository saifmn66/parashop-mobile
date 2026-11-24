import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../domain/entities/product_entity.dart';

class ProductFilterSheet extends StatefulWidget {
  const ProductFilterSheet({
    super.key,
    required this.initialFilter,
    required this.availableBrands,
  });

  final ProductFilter initialFilter;
  final List<String> availableBrands;

  static Future<ProductFilter?> show(
    BuildContext context, {
    required ProductFilter initialFilter,
    required List<String> availableBrands,
  }) {
    return showModalBottomSheet<ProductFilter>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProductFilterSheet(
        initialFilter: initialFilter,
        availableBrands: availableBrands,
      ),
    );
  }

  @override
  State<ProductFilterSheet> createState() => _ProductFilterSheetState();
}

class _ProductFilterSheetState extends State<ProductFilterSheet> {
  late ProductFilter _draft;

  @override
  void initState() {
    super.initState();
    _draft = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.78,
        minChildSize: 0.5,
        maxChildSize: 0.92,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.screenPadding,
                  vertical: AppSizes.xs,
                ),
                child: Row(
                  children: [
                    Text('Filter & Sort', style: theme.textTheme.titleLarge),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _draft = ProductFilter(categoryId: _draft.categoryId);
                        });
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(AppSizes.screenPadding),
                  children: [
                    Text('Sort by', style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSizes.sm),
                    Wrap(
                      spacing: AppSizes.xs,
                      runSpacing: AppSizes.xs,
                      children: ProductSort.values.map((sort) {
                        final selected = _draft.sort == sort;
                        return ChoiceChip(
                          label: Text(sort.label),
                          selected: selected,
                          onSelected: (_) =>
                              setState(() => _draft = _draft.copyWith(sort: sort)),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSizes.lg),
                    Row(
                      children: [
                        Text('Price range', style: theme.textTheme.titleMedium),
                        const Spacer(),
                        Text(
                          '${AppFormatters.price(_draft.minPrice)} – ${AppFormatters.price(_draft.maxPrice)}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                    RangeSlider(
                      values: RangeValues(_draft.minPrice, _draft.maxPrice),
                      min: 0,
                      max: 150,
                      divisions: 30,
                      activeColor: scheme.primary,
                      onChanged: (values) {
                        setState(() {
                          _draft = _draft.copyWith(
                            minPrice: values.start,
                            maxPrice: values.end,
                          );
                        });
                      },
                    ),
                    const SizedBox(height: AppSizes.md),
                    Text('Brands', style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSizes.sm),
                    Wrap(
                      spacing: AppSizes.xs,
                      runSpacing: AppSizes.xs,
                      children: widget.availableBrands.map((brand) {
                        final selected = _draft.brands.contains(brand);
                        return FilterChip(
                          label: Text(brand),
                          selected: selected,
                          onSelected: (v) {
                            final next = Set<String>.from(_draft.brands);
                            if (v) {
                              next.add(brand);
                            } else {
                              next.remove(brand);
                            }
                            setState(
                              () => _draft = _draft.copyWith(brands: next),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: AppSizes.lg),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'In stock only',
                        style: theme.textTheme.titleSmall,
                      ),
                      value: _draft.inStockOnly,
                      onChanged: (v) =>
                          setState(() => _draft = _draft.copyWith(inStockOnly: v)),
                    ),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Special offers only',
                        style: theme.textTheme.titleSmall,
                      ),
                      value: _draft.onSaleOnly,
                      onChanged: (v) =>
                          setState(() => _draft = _draft.copyWith(onSaleOnly: v)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(AppSizes.screenPadding),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  border: Border(top: BorderSide(color: scheme.outline)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SecondaryButton(
                        label: 'Cancel',
                        compact: true,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: AppSizes.sm),
                    Expanded(
                      flex: 2,
                      child: PrimaryButton(
                        label: 'Apply Filters',
                        compact: true,
                        onPressed: () => Navigator.of(context).pop(_draft),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
