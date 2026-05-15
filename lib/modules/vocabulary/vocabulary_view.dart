import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'vocabulary_controller.dart';

class VocabularyView extends GetView<VocabularyController> {
  const VocabularyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final surface = theme.colorScheme.surface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vocabulary',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
        iconTheme: IconThemeData(color: onSurface),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [theme.scaffoldBackgroundColor, surface]
                : [surface, theme.scaffoldBackgroundColor],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildSearchBar(context),
              Expanded(
                child: Obx(() {
                  final items = controller.filteredItems;
                  if (items.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return _buildVocabularyCard(context, items[index]);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) => controller.searchQuery.value = value,
        style: TextStyle(color: onSurface),
        decoration: InputDecoration(
          hintText: 'Search terminology...',
          hintStyle: TextStyle(color: onSurface.withOpacity(0.5)),
          prefixIcon: Icon(Icons.search, color: onSurface.withOpacity(0.6)),
          filled: true,
          fillColor: isDark
              ? theme.cardColor.withOpacity(0.3)
              : theme.colorScheme.surfaceContainerHighest.withOpacity(0.6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildVocabularyCard(BuildContext context, VocabularyItem item) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final onSurface = theme.colorScheme.onSurface;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? theme.cardColor.withOpacity(0.4)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : theme.colorScheme.outline.withOpacity(0.15),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.category.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primary,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.info_outline,
                color: onSurface.withOpacity(0.35),
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.term,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.definition,
            style: TextStyle(
              fontSize: 14,
              color: onSurface.withOpacity(0.65),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: onSurface.withOpacity(0.2),
          ),
          const SizedBox(height: 16),
          Text(
            'No terms found matching your search.',
            style: TextStyle(color: onSurface.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
