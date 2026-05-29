import 'package:air_app/widgets_specific/air_home_context_strip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/content_reviser.dart';
import '../../data/models/entity_model.dart';
import 'entities_controller.dart';

class EntitiesView extends GetView<EntitiesController> {
  final bool isEmbedded;
  const EntitiesView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      }
      return SingleChildScrollView(
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: AirHomeContextStrip(
                compact: true,
                placement: AirHomeContextPlacement.homeTab,
                extraLine:
                    'ENTITIES tab: catalogue discrete nodes first; UNIONS and IDENTITY explain how they connect and who observes them.',
              ),
            ),
            _buildCollapsibleHeader(context),
            _buildEntitiesInfoCard(context),
            Obx(
              () => AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: controller.isEntitiesExpanded.value
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 12, bottom: 80),
                        itemCount: controller.entities.length,
                        itemBuilder: (context, index) {
                          final entity = controller.entities[index];
                          return _buildEntityCard(context, entity);
                        },
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showAddEntityModal(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    controller.selectedCategory.value = ""; // Reset selection

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          top: 24,
          left: 24,
          right: 24,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.add_chart_rounded, color: accent),
                const SizedBox(width: 12),
                Text(
                  "Catalogue New Entity",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Add a new node to the all-space knowledge map.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.6,
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: titleController,
              decoration: _inputDecoration(
                "Entity Title / Name",
                Icons.title_rounded,
                context,
              ),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: _inputDecoration(
                "Description of Existence",
                Icons.description_rounded,
                context,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "META DATA TYPE",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: accent.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: controller.categories.map((cat) {
                  final isSelected = controller.selectedCategory.value == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      controller.selectedCategory.value = selected ? cat : "";
                    },
                    selectedColor: accent.withValues(alpha: 0.2),
                    backgroundColor: theme.cardColor,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? accent
                          : theme.textTheme.bodyMedium?.color,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isSelected
                            ? accent
                            : theme.dividerColor.withValues(alpha: 0.1),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      controller.selectedCategory.value.isNotEmpty) {
                    final newEntity = EntityModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: titleController.text,
                      description: descController.text.isEmpty
                          ? "No description provided."
                          : descController.text,
                      category: controller.selectedCategory.value,
                      imageUrl: '',
                    );
                    controller.addEntity(newEntity);
                  } else {
                    Get.snackbar(
                      "Missing Info",
                      "Please provide at least a title and a category.",
                      backgroundColor: Colors.orange.withValues(alpha: 0.1),
                      colorText: Colors.orange,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  shadowColor: accent.withValues(alpha: 0.4),
                ),
                child: const Text(
                  "ADD TO ALL-SPACE",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      labelStyle: TextStyle(
        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
      ),
      floatingLabelStyle: TextStyle(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.15),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withValues(alpha: 0.5),
    );
  }

  Widget _buildCollapsibleHeader(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Obx(() {
      final isExpanded = controller.isEntitiesExpanded.value;
      return GestureDetector(
        onTap: () => controller.isEntitiesExpanded.toggle(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isExpanded
                  ? [
                      accent.withValues(alpha: 0.15),
                      accent.withValues(alpha: 0.05),
                    ]
                  : [
                      accent.withValues(alpha: 0.08),
                      accent.withValues(alpha: 0.03),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: accent.withValues(alpha: isExpanded ? 0.5 : 0.2),
              width: 1.5,
            ),
            boxShadow: [
              if (isExpanded)
                BoxShadow(
                  color: accent.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.layers_rounded, color: accent, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Entities are 'Building blocks of individual Identities'",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: theme.textTheme.bodyLarge?.color,
                        height: 1.3,
                      ),
                    ),
                    if (!isExpanded)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          "Tap to explore all-space nodes",
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.6),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: accent,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Short orientation card (AIR Vision–aligned); does not replace the header tagline.
  Widget _buildEntitiesInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;
    final bodyColor = theme.textTheme.bodyMedium?.color;

    Widget bullet(String text) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '• ',
              style: TextStyle(color: accent, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  color: bodyColor?.withValues(alpha: 0.9),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.cardColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accent.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 20, color: accent),
                const SizedBox(width: 8),
                Text(
                  'IN ALL-SPACE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: accent.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'An Entity is any discrete, identifiable node in all-space. This includes:',
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: bodyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            bullet('Living beings — Humans, Animals, Plants, Microorganisms'),
            bullet('Non-living objects — Planets, Machines, Materials'),
            bullet('Abstract nodes — Emotions, Concepts, Theorems'),
            bullet('Phenomena — Gravity, Light, Sound, Time'),
            bullet('Digital entities — Software, AI, Data Structures'),
            const SizedBox(height: 8),
            Text(
              'Every entity can be catalogued here and linked through Unions.',
              style: TextStyle(
                fontSize: 12,
                height: 1.35,
                color: bodyColor?.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Drawer tip: open the menu (☰) from this screen for AIR-wide programmes—explore, profile, vision, motivation, setup, and system—without leaving your entity map.',
              style: TextStyle(
                fontSize: 12,
                height: 1.35,
                color: bodyColor?.withValues(alpha: 0.72),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEntityCard(BuildContext context, dynamic entity) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(
              context,
            ).colorScheme.primary.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.5),
            ),
          ),
          child: Icon(Icons.hub, color: Theme.of(context).colorScheme.primary),
        ),
        title: Obx(
          () => Text(
            ContentReviser.reviseTitle(entity.name),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Obx(
              () => Text(
                ContentReviser.revise(entity.description),
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Text(
                entity.category,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
