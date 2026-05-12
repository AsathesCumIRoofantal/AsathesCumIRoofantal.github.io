import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'windup_else_controller.dart';

class WindupElseView extends GetView<WindupElseController> {
  const WindupElseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("WINDUP & ELSE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(Icons.logout_rounded, size: 80, color: Colors.grey),
            const SizedBox(height: 24),
            const Text(
              "Session Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Obx(() => Column(
              children: controller.stats.map((stat) => _buildStatRow(stat)).toList(),
            )),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.windup(),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("FINISH SESSION", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(WindupItem stat) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(stat.title, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(stat.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
