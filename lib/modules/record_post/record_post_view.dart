import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'record_post_controller.dart';

class RecordPostView extends GetView<RecordPostController> {
  final bool isEmbedded;
  const RecordPostView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.scaffoldBackgroundColor, theme.colorScheme.surface],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FloatingActionButton.extended(
              onPressed: () => _showRecordPostModal(context),
              label: const Text(
                'Record New Post',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white54,
                ),
              ),
              icon: const Icon(Icons.mic_none_rounded, color: Colors.white54),
              backgroundColor: tertiary,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Record your thoughts and findings to the all-space narrative.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.7,
                  ),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Obx(() {
              if (controller.posts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history_edu_rounded,
                        size: 64,
                        color: tertiary.withValues(alpha: 0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No recordings logged yet.',
                        style: TextStyle(color: theme.dividerColor),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: isEmbedded,
                physics: isEmbedded
                    ? const NeverScrollableScrollPhysics()
                    : null,
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  final post = controller.posts[index];
                  return _buildPostCard(context, post);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, PostModel post) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    IconData mediaIcon = Icons.text_fields;
    switch (post.mediaType) {
      case 'Image':
        mediaIcon = Icons.image;
        break;
      case 'PDF':
        mediaIcon = Icons.picture_as_pdf;
        break;
      case 'Link':
        mediaIcon = Icons.link;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tertiary.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: tertiary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(mediaIcon, color: tertiary, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${post.category.toUpperCase()} // ${post.timestamp.day}/${post.timestamp.month}/${post.timestamp.year}',
                      style: TextStyle(
                        fontSize: 10,
                        color: theme.dividerColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              post.content,
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.9,
                ),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecordPostModal(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          left: 24,
          right: 24,
          top: 24,
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
                Icon(Icons.history_edu_rounded, color: tertiary),
                const SizedBox(width: 12),
                Text(
                  'Record New Post',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
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
                        'Post Title',
                        Icons.title_rounded,
                        context,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: contentController,
                      maxLines: 6,
                      decoration: _inputDecoration(
                        'Content Detail',
                        Icons.format_align_justify_rounded,
                        context,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionLabel('CATEGORY', tertiary),
                    const SizedBox(height: 12),
                    Obx(
                      () => Wrap(
                        spacing: 8,
                        children: controller.categories.map((cat) {
                          final isSelected =
                              controller.selectedCategory.value == cat;
                          return ChoiceChip(
                            label: Text(cat),
                            selected: isSelected,
                            onSelected: (selected) =>
                                controller.selectedCategory.value = cat,
                            selectedColor: tertiary.withValues(alpha: 0.2),
                            backgroundColor: theme.cardColor,
                            labelStyle: TextStyle(
                              color: isSelected
                                  ? tertiary
                                  : theme.textTheme.bodyMedium?.color,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _sectionLabel('MEDIA TYPE', tertiary),
                    const SizedBox(height: 12),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: controller.mediaTypes.map((media) {
                          final isSelected =
                              controller.selectedMediaType.value ==
                              media['name'];
                          return GestureDetector(
                            onTap: () => controller.selectedMediaType.value =
                                media['name'],
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? tertiary
                                        : theme.cardColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? tertiary
                                          : theme.dividerColor.withValues(
                                              alpha: 0.1,
                                            ),
                                    ),
                                  ),
                                  child: Icon(
                                    media['icon'],
                                    color: isSelected
                                        ? Colors.black87
                                        : theme.textTheme.bodyMedium?.color
                                              ?.withValues(alpha: 0.5),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  media['name'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? tertiary
                                        : theme.textTheme.bodyMedium?.color
                                              ?.withValues(alpha: 0.5),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => controller.addPost(
                  titleController.text,
                  contentController.text,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'PUBLISH RECORDING',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                    letterSpacing: 1,
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
    final tertiary = theme.colorScheme.tertiary;
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: tertiary.withValues(alpha: 0.7)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: tertiary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withValues(alpha: 0.5),
    );
  }
}
