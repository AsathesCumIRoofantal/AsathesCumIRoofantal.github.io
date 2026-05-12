import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'new_in_air_controller.dart';

class NewInAirView extends GetView<NewInAirController> {
  const NewInAirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("NEW IN AIR", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.news.length,
        itemBuilder: (context, index) {
          final item = controller.news[index];
          return _buildNewsCard(context, item);
        },
      )),
    );
  }

  Widget _buildNewsCard(BuildContext context, NewsItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getTagColor(item.tag).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item.tag,
                  style: TextStyle(color: _getTagColor(item.tag), fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
              Text(item.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Text(
            item.description,
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 0), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            child: const Text("READ MORE", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag) {
      case "UPDATE": return Colors.blue;
      case "PARTNER": return Colors.green;
      case "EVENT": return Colors.purple;
      default: return Colors.grey;
    }
  }
}
