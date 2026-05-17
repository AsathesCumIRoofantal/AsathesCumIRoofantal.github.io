import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'share_experience_controller.dart';

class ShareExperienceView extends GetView<ShareExperienceController> {
  final bool isEmbedded;
  const ShareExperienceView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Share Experience',
          style: TextStyle(letterSpacing: 2),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddExperienceModal(context),
        label: const Text(
          'Add your Experience',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [theme.scaffoldBackgroundColor, theme.colorScheme.surface],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Your contributions help map the all-space experience.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: 0.7,
                    ),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.experiences.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 64,
                            color: primary.withValues(alpha: 0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No experiences shared yet.',
                            style: TextStyle(color: theme.dividerColor),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.experiences.length,
                    itemBuilder: (context, index) {
                      final exp = controller.experiences[index];
                      return _buildExperienceCard(context, exp);
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

  Widget _buildExperienceCard(BuildContext context, ExperienceModel exp) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: ExpansionTile(
        title: Text(
          exp.subject,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Mapping Date: ${exp.timestamp.day}/${exp.timestamp.month}/${exp.timestamp.year}',
          style: TextStyle(fontSize: 12, color: theme.dividerColor),
        ),
        childrenPadding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(exp.detail, style: const TextStyle(height: 1.5)),
              ),
            ],
          ),
          if (exp.attachments.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'ATTACHMENTS',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: exp.attachments
                  .map(
                    (a) => Chip(
                      label: Text(a, style: const TextStyle(fontSize: 10)),
                      avatar: const Icon(Icons.attach_file, size: 14),
                      backgroundColor: primary.withValues(alpha: 0.1),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddExperienceModal(BuildContext context) {
    final subjectController = TextEditingController();
    final detailController = TextEditingController();
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
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
            Text(
              'Add your experience',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
                child: Column(
                  children: [
                    TextField(
                      controller: subjectController,
                      decoration: _inputDecoration(
                        'Subject',
                        Icons.subject,
                        context,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: detailController,
                      maxLines: 5,
                      decoration: _inputDecoration(
                        'Detail',
                        Icons.notes,
                        context,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'FILES ATTACHED',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(
                      () => Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ...controller.tempAttachments.asMap().entries.map(
                            (entry) => Chip(
                              label: Text(entry.value),
                              onDeleted: () =>
                                  controller.removeAttachment(entry.key),
                              deleteIcon: const Icon(Icons.close, size: 14),
                              backgroundColor: primary.withValues(alpha: 0.1),
                            ),
                          ),
                          ActionChip(
                            avatar: const Icon(Icons.add, size: 14),
                            label: const Text('Add File'),
                            onPressed: () => controller.addMockAttachment(),
                            backgroundColor: theme.cardColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => controller.addExperience(
                  subjectController.text,
                  detailController.text,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'ESTABLISH EXPERIENCE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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

  InputDecoration _inputDecoration(
    String label,
    IconData icon,
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: theme.colorScheme.primary.withValues(alpha: 0.7),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withValues(alpha: 0.5),
    );
  }
}






