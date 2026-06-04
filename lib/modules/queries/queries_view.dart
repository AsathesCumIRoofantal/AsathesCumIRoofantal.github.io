import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'queries_controller.dart';
import 'package:intl/intl.dart';

class QueriesView extends GetView<QueriesController> {
  final bool isEmbedded;
  const QueriesView({super.key, this.isEmbedded = false});

  void _showSubmissionSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Submit A New Query",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: controller.subjectController,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                decoration: InputDecoration(
                  labelText: 'Subject / Focus',
                  labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller.descController,
                maxLines: 4,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                decoration: InputDecoration(
                  labelText: 'Description / Context',
                  labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Get.snackbar(
                    'File Explorer',
                    'Attachment interface queued...',
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  );
                },
                icon: Icon(
                  Icons.attach_file,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: Text(
                  'Attach Supporting Files',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: controller.submitQuery,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'SUBMIT QUERY',
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Filter Bar Section
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: FloatingActionButton.extended(
                  onPressed: () => _showSubmissionSheet(context),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text(
                    'Send Query',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextField(
                onChanged: controller.updateSearch,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                decoration: InputDecoration(
                  hintText: 'Search past queries...',
                  hintStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: ['All Time', 'Past 7 Days', 'Past 30 Days'].map((
                    filter,
                  ) {
                    final isSelected =
                        filter == controller.dateFilterType.value;
                    return Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(canvasColor: Colors.transparent),
                      child: ChoiceChip(
                        label: Text(
                          filter,
                          style: const TextStyle(fontSize: 12),
                        ),
                        selected: isSelected,
                        onSelected: (val) =>
                            controller.updateDateFilter(filter),
                        backgroundColor: Theme.of(context).cardColor,
                        selectedColor: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.2),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(
                                  context,
                                ).dividerColor.withValues(alpha: 0.5),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        Obx(() {
          if (controller.displayQueries.isEmpty) {
            return Center(
              child: Text(
                "No queries found matching the timeline/filters.",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: isEmbedded,
            physics: isEmbedded ? NeverScrollableScrollPhysics() : null,
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 80,
            ),
            itemCount: controller.displayQueries.length,
            itemBuilder: (context, index) {
              final query = controller.displayQueries[index];
              final bool isAnswered = query.status == 'Answered';

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).dividerColor.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat(
                              'MMM dd, yyyy - hh:mm a',
                            ).format(query.dateSubmitted),
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isAnswered
                                  ? Colors.green.withValues(alpha: 0.1)
                                  : Colors.orange.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isAnswered
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                            child: Text(
                              query.status,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isAnswered
                                    ? Colors.green
                                    : Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        query.subject,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        query.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          height: 1.4,
                        ),
                      ),
                      if (query.attachedFiles.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.attachment,
                              size: 16,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${query.attachedFiles.length} file(s) attached",
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.primary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
