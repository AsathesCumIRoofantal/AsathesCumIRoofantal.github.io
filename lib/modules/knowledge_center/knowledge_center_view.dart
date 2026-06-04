import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'knowledge_center_controller.dart';

class KnowledgeCenterView extends GetView<KnowledgeCenterController> {
  final bool isEmbedded;
  const KnowledgeCenterView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final tertiary = theme.colorScheme.tertiary;

    final queryController = TextEditingController();

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.scaffoldBackgroundColor,
                theme.colorScheme.surface,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAIQuerySection(context, queryController),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    'KNOWLEDGE HISTORY',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                _buildSearchBar(context),
                Obx(() {
                  final list = controller.filteredHistory;
                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_stories_rounded,
                            size: 64,
                            color: primary.withValues(alpha: 0.1),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No knowledge nodes found.',
                            style: TextStyle(color: Colors.white24),
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
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return _buildHistoryCard(context, list[index]);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
        Positioned(
          top: -20,
          right: 20,
          child: FloatingActionButton.extended(
            onPressed: () => _showAddKnowledgeModal(context),
            label: const Text(
              'Add Knowledge',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
            icon: const Icon(Icons.library_add_rounded, color: Colors.white54),
            backgroundColor: tertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildAIQuerySection(
    BuildContext context,
    TextEditingController queryController,
  ) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology_rounded, color: primary),
              const SizedBox(width: 12),
              const Text(
                'AI POWERED SOLUTIONS',
                style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: queryController,
            decoration: InputDecoration(
              hintText: 'Enter your query for AI analysis...',
              filled: true,
              fillColor: theme.cardColor.withValues(alpha: 0.3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: controller.isThinking.value
                    ? null
                    : () {
                        controller.submitQuery(queryController.text);
                        queryController.clear();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: controller.isThinking.value
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'THINKING...',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        'GENERATE SOLUTION',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        onChanged: (value) => controller.searchQuery.value = value,
        decoration: InputDecoration(
          hintText: 'Filter knowledge history...',
          prefixIcon: Icon(Icons.search, color: theme.dividerColor),
          filled: true,
          fillColor: theme.cardColor.withValues(alpha: 0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, KnowledgeEntry entry) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isAI = entry.solution != null;
    final isPending = entry.status == KnowledgeStatus.pending;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (isAI ? primary : theme.colorScheme.tertiary).withValues(
            alpha: 0.1,
          ),
        ),
      ),
      child: ExpansionTile(
        leading: Icon(
          isAI ? Icons.auto_awesome : Icons.menu_book_rounded,
          color: isAI ? primary : theme.colorScheme.tertiary,
        ),
        title: Text(
          isAI ? (entry.query ?? 'AI Solution') : entry.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Row(
          children: [
            Text(
              DateFormat('MMM dd').format(entry.timestamp),
              style: TextStyle(fontSize: 10, color: theme.dividerColor),
            ),
            const SizedBox(width: 8),
            if (isPending)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.amber.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'PENDING REVIEW',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            if (entry.status == KnowledgeStatus.approved && !isAI)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'CATALOGUED',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        childrenPadding: const EdgeInsets.all(20),
        children: [
          if (isAI) ...[
            const Text(
              'AI RESPONSE:',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              entry.solution ?? '',
              style: TextStyle(
                color: primary.withValues(alpha: 0.9),
                height: 1.6,
              ),
            ),
          ] else ...[
            const Text(
              'DETAIL RECORD:',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              entry.detail,
              style: TextStyle(
                color: theme.textTheme.bodyMedium?.color?.withValues(
                  alpha: 0.8,
                ),
                height: 1.6,
              ),
            ),
            if (entry.attachments.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                'ATTACHED FILES FOR REVIEW:',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: entry.attachments
                    .map(
                      (f) => Chip(
                        label: Text(f, style: const TextStyle(fontSize: 10)),
                        backgroundColor: theme.colorScheme.tertiary.withValues(
                          alpha: 0.1,
                        ),
                        avatar: const Icon(Icons.attach_file, size: 12),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ],
      ),
    );
  }

  void _showAddKnowledgeModal(BuildContext context) {
    final titleController = TextEditingController();
    final detailController = TextEditingController();
    final attachments = <String>['mock_data_01.csv', 'ref_image_air.png'].obs;
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
              'Propose New Knowledge',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Submitted knowledge will be reviewed by AIR Admin before becoming globally visible.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.white54),
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
                        'Knowledge Title',
                        Icons.title,
                        context,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: detailController,
                      maxLines: 6,
                      decoration: _inputDecoration(
                        'Detailed Findings',
                        Icons.description,
                        context,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'FILES ATTACHED FOR REVIEW',
                      style: TextStyle(
                        fontSize: 10,
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
                          ...attachments.map(
                            (f) => Chip(
                              label: Text(f),
                              onDeleted: () => attachments.remove(f),
                              backgroundColor: tertiary.withValues(alpha: 0.1),
                            ),
                          ),
                          ActionChip(
                            avatar: const Icon(Icons.add, size: 14),
                            label: const Text('Mock Attach'),
                            onPressed: () => attachments.add(
                              'manual_ref_${attachments.length}.pdf',
                            ),
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
              height: 56,
              child: ElevatedButton(
                onPressed: () => controller.addKnowledge(
                  title: titleController.text,
                  detail: detailController.text,
                  attachments: List<String>.from(attachments),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'SUBMIT TO ADMIN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
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
        color: theme.colorScheme.tertiary.withValues(alpha: 0.7),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.colorScheme.tertiary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withValues(alpha: 0.5),
    );
  }
}
