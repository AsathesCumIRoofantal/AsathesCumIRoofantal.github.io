import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/air_home_context_strip.dart';
import 'category_docs_controller.dart';
import '../../data/models/learning_doc_model.dart';

class CategoryDocsView extends GetView<CategoryDocsController> {
  const CategoryDocsView({Key? key}) : super(key: key);

  IconData _getIconForType(String type) {
    switch (type.toUpperCase()) {
      case 'PDF': return Icons.picture_as_pdf;
      case 'IMAGE': return Icons.image;
      case 'TXT': return Icons.description;
      case 'VIDEO': return Icons.play_circle_fill;
      default: return Icons.insert_drive_file;
    }
  }

  Color _getColorForType(String type) {
    switch (type.toUpperCase()) {
      case 'PDF': return Colors.redAccent;
      case 'IMAGE': return Colors.blueAccent;
      case 'TXT': return Colors.grey;
      case 'VIDEO': return Colors.purpleAccent;
      default: return Colors.teal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.title),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 4)
                )
              ]
            ),
            child: Obx(() => ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: controller.filterTypes.length,
              itemBuilder: (context, index) {
                final filter = controller.filterTypes[index];
                final isSelected = filter == controller.currentFilter.value;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ChoiceChip(
                    label: Text(filter, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                    selected: isSelected,
                    onSelected: (selected) => controller.applyFilter(filter),
                    selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                    backgroundColor: Theme.of(context).cardColor,
                    labelStyle: TextStyle(
                      color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).textTheme.bodyMedium?.color
                    ),
                    side: BorderSide(
                      color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor
                    ),
                  ),
                );
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: AirHomeContextStrip(
              compact: true,
              extraLine:
                  'These documents pair with Learn & Fun tiles; your IDENTITY tab still names who is reading.',
            ),
          ),

          // Documents List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
              }

              if (controller.filteredDocs.isEmpty) {
                return Center(child: Text("No accessible files match this filter.", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.filteredDocs.length,
                itemBuilder: (context, index) {
                  final LearningDocModel doc = controller.filteredDocs[index];
                  final Color typeColor = _getColorForType(doc.type);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.5)),
                      boxShadow: [
                        BoxShadow(
                          color: typeColor.withValues(alpha: isDark ? 0.05 : 0.02),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(_getIconForType(doc.type), color: typeColor, size: 32),
                      ),
                      title: Text(doc.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(doc.description, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, height: 1.3), maxLines: 2, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: [
                              _buildPill(doc.classCategory, Theme.of(context)),
                              _buildPill("Age: ${doc.targetAge}", Theme.of(context)),
                            ],
                          )
                        ],
                      ),
                      trailing: Icon(Icons.download_rounded, color: Theme.of(context).dividerColor),
                      onTap: () {
                        Get.snackbar(
                          "Retrieving Document", 
                          "Preparing ${doc.type} for optimal learning experience...",
                          backgroundColor: Theme.of(context).cardColor,
                          colorText: Theme.of(context).colorScheme.primary,
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPill(String text, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Text(text, style: TextStyle(fontSize: 10, color: theme.textTheme.bodyMedium?.color)),
    );
  }
}
