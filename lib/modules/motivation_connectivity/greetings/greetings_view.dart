import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'greetings_controller.dart';

class GreetingsView extends GetView<GreetingsController> {
  const GreetingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.withOpacity(0.05), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person_outline, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 40),
            const Text(
              "GREETINGS",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 4),
            ),
            const SizedBox(height: 24),
            Obx(() => Text(
              controller.greeting.value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.6),
            )),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("ACCESS DASHBOARD"),
            ),
          ],
        ),
      ),
    );
  }
}
