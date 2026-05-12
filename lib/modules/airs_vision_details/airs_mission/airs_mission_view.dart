import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'airs_mission_controller.dart';

class AirsMissionView extends GetView<AirsMissionController> {
  const AirsMissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("AIR'S MISSION", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(Icons.stars_rounded, size: 80, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              "To revolutionize industrial coordination through the power of autonomous digitalization and community-driven verification.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1.6),
            ),
            const SizedBox(height: 48),
            Obx(() => Column(
              children: controller.pillars.map((pillar) => _buildPillarItem(context, pillar)).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildPillarItem(BuildContext context, MissionPillar pillar) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        children: [
          Icon(pillar.icon, color: Colors.blue, size: 32),
          const SizedBox(height: 12),
          Text(pillar.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1)),
          const SizedBox(height: 8),
          Text(
            pillar.description,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}
