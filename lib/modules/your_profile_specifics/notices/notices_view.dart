import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'notices_controller.dart';

class NoticesView extends GetView<NoticesController> {
  const NoticesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NOTICES', style: TextStyle(letterSpacing: 2))),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.notices.length,
        itemBuilder: (context, index) {
          final notice = controller.notices[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(notice.category.toUpperCase(), style: const TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
                    Text(DateFormat('MMM dd').format(notice.date), style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(notice.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(notice.content, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7))),
              ],
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateNoticeSheet(context),
        label: const Text("CREATE NOTICE"),
        icon: const Icon(Icons.notification_add_outlined),
      ),
    );
  }

  void _showCreateNoticeSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("NEW BROADCAST NOTICE", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: controller.titleController, decoration: const InputDecoration(labelText: "Notice Title")),
            TextField(controller: controller.contentController, maxLines: 3, decoration: const InputDecoration(labelText: "Content")),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => controller.createNotice(), child: const Text("PUBLISH NOTICE")),
          ],
        ),
      ),
    );
  }
}
