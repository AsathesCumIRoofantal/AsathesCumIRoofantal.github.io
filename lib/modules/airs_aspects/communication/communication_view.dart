import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'communication_controller.dart';

class CommunicationView extends GetView<CommunicationController> {
  const CommunicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("COMMUNICATION", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: controller.channels.length,
        itemBuilder: (context, index) {
          final channel = controller.channels[index];
          return _buildChannelTile(context, channel);
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }

  Widget _buildChannelTile(BuildContext context, ChatChannel channel) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: Colors.blue.withOpacity(0.1),
        child: Text(channel.name[0], style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      ),
      title: Text(channel.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(channel.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(channel.time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          if (channel.unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              child: Text(
                channel.unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
