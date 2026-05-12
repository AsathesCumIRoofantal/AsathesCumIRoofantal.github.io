import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'get_connected_controller.dart';

class GetConnectedView extends GetView<GetConnectedController> {
  const GetConnectedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("GET CONNECTED", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.links.length,
        itemBuilder: (context, index) {
          final link = controller.links[index];
          return _buildSocialTile(context, link);
        },
      )),
    );
  }

  Widget _buildSocialTile(BuildContext context, SocialLink link) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        tileColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(link.icon, color: Colors.blue),
        title: Text(link.platform, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(link.handle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: const Icon(Icons.open_in_new_rounded, size: 18, color: Colors.grey),
        onTap: () => controller.connect(link.platform),
      ),
    );
  }
}
