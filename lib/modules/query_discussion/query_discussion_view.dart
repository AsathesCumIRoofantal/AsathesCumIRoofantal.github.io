import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'query_discussion_controller.dart';
import 'package:intl/intl.dart';

class QueryDiscussionView extends GetView<QueryDiscussionController> {
  const QueryDiscussionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final tertiary = theme.colorScheme.tertiary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Query & Discussion',
          style: TextStyle(letterSpacing: 2),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddQueryModal(context),
        label: const Text(
          'Open Discussion',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white54),
        ),
        icon: const Icon(Icons.forum_rounded, color: Colors.white54),
        backgroundColor: tertiary,
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
            children: [
              _buildSearchBar(context),
              Expanded(
                child: Obx(() {
                  final list = controller.filteredDiscussions;
                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comments_disabled_outlined,
                            size: 64,
                            color: primary.withOpacity(0.1),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No discussions matching your query.',
                            style: TextStyle(color: Colors.white24),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return _buildDiscussionCard(context, list[index]);
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        onChanged: (value) => controller.searchQuery.value = value,
        decoration: InputDecoration(
          hintText: 'Search discussions or topics...',
          prefixIcon: Icon(Icons.search, color: theme.dividerColor),
          filled: true,
          fillColor: theme.cardColor.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildDiscussionCard(
    BuildContext context,
    DiscussionModel discussion,
  ) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final isConcluded = discussion.status == DiscussionStatus.concluded;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: (isConcluded ? Colors.green : primary).withOpacity(0.1),
        ),
      ),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (isConcluded ? Colors.green : primary).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isConcluded
                ? Icons.assignment_turned_in_rounded
                : Icons.chat_bubble_outline_rounded,
            color: isConcluded ? Colors.green : primary,
            size: 20,
          ),
        ),
        title: Text(
          discussion.topic,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Row(
          children: [
            Text(
              DateFormat('MMM dd').format(discussion.timestamp),
              style: TextStyle(fontSize: 10, color: theme.dividerColor),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: (isConcluded ? Colors.green : primary).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                isConcluded ? 'CONCLUDED' : 'ACTIVE',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: isConcluded ? Colors.green : primary,
                ),
              ),
            ),
            const Spacer(),
            Obx(
              () => Text(
                '${discussion.responses.length} responses',
                style: TextStyle(fontSize: 10, color: theme.dividerColor),
              ),
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        children: [
          const Divider(),
          const SizedBox(height: 12),
          const Text(
            'REMARKS:',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            discussion.remarks,
            style: TextStyle(
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          if (isConcluded) ...[
            const Text(
              'CONCLUSIVE DOCUMENTS:',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            ...discussion.conclusiveDocuments.map(
              (doc) => ListTile(
                dense: true,
                leading: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.green,
                  size: 18,
                ),
                title: Text(
                  doc.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.download, size: 16),
                onTap: () {},
              ),
            ),
          ] else ...[
            const Text(
              'TOP RESPONSES:',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => discussion.responses.isEmpty
                  ? const Text(
                      'Waiting for community feedback...',
                      style: TextStyle(fontSize: 12, color: Colors.white24),
                    )
                  : Column(
                      children: discussion.responses
                          .map(
                            (r) => Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.cardColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        size: 12,
                                        color: Colors.white70,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        r.user,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    r.text,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ],
      ),
    );
  }

  void _showAddQueryModal(BuildContext context) {
    final topicController = TextEditingController();
    final remarksController = TextEditingController();
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
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
                  color: theme.dividerColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Initiate Community Inquiry',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: topicController,
                      decoration: _inputDecoration(
                        'Discussion Topic',
                        Icons.topic_outlined,
                        context,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: remarksController,
                      maxLines: 8,
                      decoration: _inputDecoration(
                        'Remarks / Context',
                        Icons.notes_rounded,
                        context,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'EVIDENCE FILES (Optional)',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ActionChip(
                      avatar: const Icon(Icons.attach_file, size: 14),
                      label: const Text('Attach Reference'),
                      onPressed: () {},
                      backgroundColor: theme.cardColor,
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
                onPressed: () => controller.postQuery(
                  topic: topicController.text,
                  remarks: remarksController.text,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: tertiary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'INITIATE DISCUSSION',
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
        color: theme.colorScheme.tertiary.withOpacity(0.7),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.colorScheme.tertiary, width: 2),
      ),
      filled: true,
      fillColor: theme.cardColor.withOpacity(0.5),
    );
  }
}
