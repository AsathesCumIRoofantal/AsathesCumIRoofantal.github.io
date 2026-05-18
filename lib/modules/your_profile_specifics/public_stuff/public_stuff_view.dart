import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'public_stuff_controller.dart';

class PublicStuffView extends GetView<PublicStuffController> {
  final bool isEmbedded;
  const PublicStuffView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Obx(
        () => Column(
          children: [
            FloatingActionButton.extended(
              onPressed: () => _showCreatePostSheet(context),
              label: const Text("SHARE SOMETHING"),
              icon: const Icon(Icons.send_rounded),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                final post = controller.posts[index];
                return _buildPostCard(context, post);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, PublicPost post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.withValues(alpha: 0.1),
                child: Text(post.author[0]),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.author,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat('HH:mm').format(post.time),
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(post.content, style: const TextStyle(fontSize: 15)),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.favorite_border, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                post.likes.toString(),
                style: TextStyle(color: Colors.grey[600]),
              ),
              const Spacer(),
              Icon(Icons.share_outlined, size: 18, color: Colors.grey[600]),
            ],
          ),
        ],
      ),
    );
  }

  void _showCreatePostSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "SHARE WITH THE COMMUNITY",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.createPost(),
                child: const Text("POST UPDATE"),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
