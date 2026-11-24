import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class SearchSuggestionsView extends StatelessWidget {
  const SearchSuggestionsView({
    super.key,
    required this.recentSearches,
    required this.popularSearches,
    required this.onTermTap,
    required this.onRemoveRecent,
    required this.onClearRecent,
  });

  final List<String> recentSearches;
  final List<String> popularSearches;
  final ValueChanged<String> onTermTap;
  final ValueChanged<String> onRemoveRecent;
  final VoidCallback onClearRecent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(AppSizes.screenPadding),
      children: [
        if (recentSearches.isNotEmpty) ...[
          Row(
            children: [
              Text('Recent Searches', style: theme.textTheme.titleMedium),
              const Spacer(),
              TextButton(
                onPressed: onClearRecent,
                child: const Text('Clear all'),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.xs),
          ...recentSearches.map(
            (term) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.history_rounded,
                size: 20,
                color: scheme.onSurfaceVariant,
              ),
              title: Text(term, style: theme.textTheme.bodyLarge),
              trailing: IconButton(
                icon: const Icon(Icons.close_rounded, size: 18),
                onPressed: () => onRemoveRecent(term),
              ),
              onTap: () => onTermTap(term),
            ),
          ),
          const SizedBox(height: AppSizes.lg),
        ],
        Text('Popular Searches', style: theme.textTheme.titleMedium),
        const SizedBox(height: AppSizes.sm),
        Wrap(
          spacing: AppSizes.xs,
          runSpacing: AppSizes.xs,
          children: popularSearches
              .map(
                (term) => ActionChip(
                  avatar: Icon(
                    Icons.trending_up_rounded,
                    size: 16,
                    color: scheme.primary,
                  ),
                  label: Text(term),
                  onPressed: () => onTermTap(term),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
