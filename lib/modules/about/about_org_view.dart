import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'about_controller.dart';

class AboutOrgView extends GetView<AboutController> {
  const AboutOrgView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("ABOUT ORGANIZATION")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Colors.blue, child: Icon(Icons.account_balance_rounded, size: 50, color: Colors.white)),
            const SizedBox(height: 24),
            Obx(() => Text(controller.orgName.value, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
            const SizedBox(height: 32),
            const Text("OUR MISSION", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.blue)),
            const SizedBox(height: 12),
            Obx(() => Text(controller.orgMission.value, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600], height: 1.6))),
            const SizedBox(height: 48),
            _buildOrgDetail(Icons.location_on_outlined, "Global Headquarters", "Silicon Valley, CA"),
            _buildOrgDetail(Icons.people_outline, "Workforce", "50,000+ Synchronized Nodes"),
            _buildOrgDetail(Icons.verified_outlined, "Compliance", "ISO 9001, AIR-Core Certified"),
          ],
        ),
      ),
    );
  }

  Widget _buildOrgDetail(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(value, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
