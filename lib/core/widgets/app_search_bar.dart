import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = 'Search skincare, brands, vitamins...',
    this.readOnly = false,
    this.autofocus = false,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.onFilterTap,
    this.showClear = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool readOnly;
  final bool autofocus;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final VoidCallback? onFilterTap;
  final bool showClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    if (readOnly) {
      return Material(
        color: scheme.surfaceContainerHighest,
        borderRadius: AppSizes.rMd,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppSizes.rMd,
          child: Container(
            height: AppSizes.inputHeight,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: scheme.onSurfaceVariant,
                  size: AppSizes.iconMd - 2,
                ),
                const SizedBox(width: AppSizes.sm),
                Expanded(
                  child: Text(
                    hintText,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textHint,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (onFilterTap != null)
                  IconButton(
                    onPressed: onFilterTap,
                    icon: Icon(
                      Icons.tune_rounded,
                      color: scheme.primary,
                      size: AppSizes.iconSm + 2,
                    ),
                    tooltip: 'Filter',
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return TextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search_rounded, size: AppSizes.iconMd - 2),
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showClear)
              IconButton(
                onPressed: onClear,
                tooltip: 'Clear search',
                icon: const Icon(Icons.close_rounded, size: AppSizes.iconSm),
              ),
            if (onFilterTap != null)
              IconButton(
                onPressed: onFilterTap,
                tooltip: 'Filter',
                icon: Icon(
                  Icons.tune_rounded,
                  color: scheme.primary,
                  size: AppSizes.iconSm + 2,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
