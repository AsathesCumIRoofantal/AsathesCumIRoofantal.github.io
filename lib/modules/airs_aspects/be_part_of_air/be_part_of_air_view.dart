import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'be_part_of_air_controller.dart';

class BePartOfAirView extends GetView<BePartOfAirController> {
  const BePartOfAirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("BE PART OF AIR", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "Join the revolution. Choose your path to become an integral part of the Automated Industrial Registry.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 32),
            Obx(() => Column(
              children: controller.paths.map((path) => _buildPathCard(context, path)).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildPathCard(BuildContext context, ParticipationPath path) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.primary.withOpacity(0.05), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(path.icon, size: 48, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            path.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.handleAction(path.title),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(path.action),
            ),
          ),
        ],
      ),
    );
  }
}
