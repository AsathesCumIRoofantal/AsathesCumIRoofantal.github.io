import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'motivation_controller.dart';

class MotivationView extends GetView<MotivationController> {
  const MotivationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("MOTIVATION", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.format_quote_rounded, size: 64, color: Colors.blue),
              const SizedBox(height: 24),
              Obx(() {
                final quote = controller.quotes[controller.currentQuoteIndex.value];
                return Column(
                  children: [
                    Text(
                      "\"${quote.text}\"",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontStyle: FontStyle.italic, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "- ${quote.author}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 60),
              OutlinedButton(
                onPressed: () => controller.nextQuote(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("NEXT QUOTE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
