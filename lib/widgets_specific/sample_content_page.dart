import 'package:flutter/material.dart';

import 'air_home_context_strip.dart';

class SampleContentItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const SampleContentItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class SampleContentPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<SampleContentItem> items;

  /// When true, adds an all-space / home-tabs strip and (if [items] is non-empty)
  /// one extra list card linking this module back to Identity and the drawer.
  final bool showHomeContextBridge;

  const SampleContentPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.items = const [],
    this.showHomeContextBridge = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surface = theme.colorScheme.surface;
    final background = theme.scaffoldBackgroundColor;

    final listItems = <SampleContentItem>[
      ...items,
      if (showHomeContextBridge && items.isNotEmpty)
        SampleContentItem(
          title: 'All-space home & Identity',
          subtitle:
              'Return to the All-Space home to refine ENTITIES and UNIONS, finish the IDENTITY questionnaire, or open the menu (☰) for another lane. This screen is "$title"—keep it coherent with what you catalogue and how you map yourself.',
          icon: Icons.home_work_outlined,
        ),
    ];

    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark ? [background, surface] : [surface, background],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.18,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          icon,
                          size: 28,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              subtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodyMedium?.color
                                    ?.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (showHomeContextBridge) ...[
                  const SizedBox(height: 14),
                  const AirHomeContextStrip(),
                ],
                const SizedBox(height: 16),
                listItems.isEmpty
                    ? Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface.withValues(
                              alpha: 0.9,
                            ),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: theme.dividerColor.withValues(alpha: 0.15),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.hourglass_empty,
                                size: 42,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Empty sample content',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'This page is ready to receive real AIR content.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.textTheme.bodyMedium?.color
                                      ?.withValues(alpha: 0.7),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              if (showHomeContextBridge) ...[
                                const SizedBox(height: 16),
                                const AirHomeContextStrip(),
                                const SizedBox(height: 8),
                                Text(
                                  'When real content ships for "$title", it will still sit beside your Identity map and entity catalogue on the home screen.',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    height: 1.35,
                                    color: theme.textTheme.bodySmall?.color
                                        ?.withValues(alpha: 0.85),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listItems.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = listItems[index];
                          return _buildCard(context, item);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, SampleContentItem item) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(item.icon, color: theme.colorScheme.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: 0.75,
                    ),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
