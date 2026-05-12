import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'finally_blessings_controller.dart';

class FinallyBlessingsView extends GetView<FinallyBlessingsController> {
  const FinallyBlessingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.favorite_rounded, size: 100, color: Colors.redAccent),
              const SizedBox(height: 40),
              const Text(
                "FINALLY, BLESSINGS",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
              const SizedBox(height: 24),
              Obx(() => Text(
                controller.message.value,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600], height: 1.6),
              )),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () => Get.offAllNamed('/'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("RETURN HOME"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
