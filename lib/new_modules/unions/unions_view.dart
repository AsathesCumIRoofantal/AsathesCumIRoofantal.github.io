import 'package:air_app/widgets_specific/air_home_context_strip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/content_reviser.dart';
import '../../data/models/union_model.dart';
import '../entities/entities_controller.dart';
import 'unions_controller.dart';

class UnionsView extends GetView<UnionsController> {
  final bool isEmbedded;
  const UnionsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: [
            FloatingActionButton.extended(
              onPressed: () => _showAddUnionModal(context),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              icon: const Icon(Icons.group_add_rounded, color: Colors.white),
              label: const Text(
                "Catalogue Union",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: AirHomeContextStrip(
                compact: true,
                placement: AirHomeContextPlacement.homeTab,
                extraLine:
                    'UNIONS tab: record bindings between entities; keep names consistent with the ENTITIES tab and your IDENTITY map.',
              ),
            ),
            _buildCollapsibleHeader(context),
            _buildUnionsInfoCard(context),
            Obx(
              () => AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: controller.isUnionsExpanded.value
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 12, bottom: 80),
                        itemCount: controller.unions.length,
                        itemBuilder: (context, index) {
                          final union = controller.unions[index];
                          return _buildUnionCard(context, union);
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

  void _showAddUnionModal(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.secondary;
    final entitiesController = Get.find<EntitiesController>();

    controller.selectedCategory.value = "";
    controller.selectedEntities.clear();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          top: 24,
          left: 24,
          right: 24,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
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
                Icon(Icons.diversity_3_rounded, color: secondary),
                const SizedBox(width: 12),
                Text(
                  "Catalogue New Union",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: _inputDecoration(
                        "Union Name",
                        Icons.badge_rounded,
                        context,
                      ),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descController,
                      maxLines: 2,
                      decoration: _inputDecoration(
                        "Relationship Description",
                        Icons.description_rounded,
                        context,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionLabel("UNION TYPE", secondary),
                    const SizedBox(height: 12),
                    Obx(
                      () => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: controller.categories.map((cat) {
                          final isSelected =
                              controller.selectedCategory.value == cat;
                          return ChoiceChip(
                            label: Text(cat),
                            selected: isSelected,
                            onSelected: (selected) =>
                                controller.selectedCategory.value = selected
                                ? cat
                                : "",
                            selectedColor: secondary.withValues(alpha: 0.2),
                            backgroundColor: theme.cardColor,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? secondary
                                  : theme.textTheme.bodyMedium?.color,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: isSelected
                                    ? secondary
                                    : theme.dividerColor.withValues(alpha: 0.1),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionLabel("INVOLVED ENTITIES", secondary),
                    const SizedBox(height: 12),
                    Obx(() {
                      if (entitiesController.entities.isEmpty) {
                        return Text(
                          "No entities catalogued yet.",
                          style: theme.textTheme.bodySmall,
                        );
                      }
                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: entitiesController.entities.map((entity) {
                          final isSelected = controller.selectedEntities
                              .contains(entity.name);
                          return FilterChip(
                            label: Text(entity.name),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                controller.selectedEntities.add(entity.name);
                              } else {
                                controller.selectedEntities.remove(entity.name);
                              }
                            },
                            selectedColor: secondary.withValues(alpha: 0.15),
                            checkmarkColor: secondary,
                            backgroundColor: theme.cardColor,
                            labelStyle: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? secondary
                                  : theme.textTheme.bodyMedium?.color,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: isSelected
                                    ? secondary.withValues(alpha: 0.5)
                                    : theme.dividerColor.withValues(alpha: 0.1),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      controller.selectedCategory.value.isNotEmpty &&
                      controller.selectedEntities.isNotEmpty) {
                    final newUnion = UnionModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: titleController.text,
                      description: descController.text.isEmpty
                          ? "A new relationship union."
                          : descController.text,
                      category: controller.selectedCategory.value,
                      unionedEntities: List<String>.from(
                        controller.selectedEntities,
                      ),
                      imageUrl: '',
                    );
                    controller.addUnion(newUnion);
                  } else {
                    Get.snackbar(
                      "Incomplete Union",
                      "Provide title, type, and at least one entity.",
                      backgroundColor: Colors.orange.withValues(alpha: 0.1),
                      colorText: Colors.orange,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "ESTABLISH UNION",
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

  Widget _sectionLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
        color: color.withValues(alpha: 0.8),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.secondary;
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20, color: secondary.withValues(alpha: 0.7)),
      labelStyle: TextStyle(
        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
      ),
      floatingLabelStyle: TextStyle(
        color: secondary,
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
        borderSide: BorderSide(color: secondary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withValues(alpha: 0.5),
    );
  }

  Widget _buildCollapsibleHeader(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;

    return Obx(() {
      final isExpanded = controller.isUnionsExpanded.value;
      return GestureDetector(
        onTap: () => controller.isUnionsExpanded.toggle(),
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
                child: Icon(Icons.hub_outlined, color: accent, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Unions are 'Relationships & Groupings of Entities'",
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
                          "Explore interconnected all-space nodes",
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

  Widget _buildUnionsInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.secondary;
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
                  'RELATIONSHIPS',
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
              'A Union is a relationship, grouping, or binding between two or more Entities. Types include:',
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: bodyColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            bullet('Pairs — Father & Child, Teacher & Student, Planet & Moon'),
            bullet('Groups — Families, Teams, Ecosystems, Galaxies'),
            bullet('Organisations — Companies, Governments, AIR itself'),
            bullet('Conceptual Unions — Marriage, Partnership, Alliance'),
            const SizedBox(height: 8),
            Text(
              'Use Catalogue Union to record how entities connect in your map.',
              style: TextStyle(
                fontSize: 12,
                height: 1.35,
                color: bodyColor?.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Drawer tip: the same menu (☰) lists collaborations, notices, rewards, and long-form SETUP lanes—use it when a union needs policy, learning, or services beyond this relationship list.',
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

  Widget _buildUnionCard(BuildContext context, dynamic union) {
    final theme = Theme.of(context);
    final secondary = theme.colorScheme.secondary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.cardColor, theme.scaffoldBackgroundColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: secondary.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: secondary.withValues(alpha: 0.05),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bubble_chart, color: secondary, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Obx(
                    () => Text(
                      ContentReviser.reviseTitle(union.name),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Obx(
              () => Text(
                ContentReviser.revise(union.description),
                style: TextStyle(
                  color: theme.textTheme.bodyMedium?.color,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'COMPOSED OF:',
              style: TextStyle(
                color: secondary,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: union.unionedEntities
                  .map<Widget>(
                    (e) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: secondary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: secondary.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        e.toString(),
                        style: TextStyle(fontSize: 12, color: secondary),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
