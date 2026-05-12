import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'responsibilities_controller.dart';

class ResponsibilitiesView extends GetView<ResponsibilitiesController> {
  const ResponsibilitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('LIABILITY & ETHICS', style: TextStyle(color: Colors.redAccent, letterSpacing: 3, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildLiabilityHeader(context),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: controller.liabilities.length,
              itemBuilder: (context, index) {
                final item = controller.liabilities[index];
                return _buildLiabilityCard(context, item);
              },
            )),
          ),
          _buildAgreementFooter(context),
        ],
      ),
    );
  }

  Widget _buildLiabilityHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: const Column(
        children: [
          Icon(Icons.balance_rounded, size: 60, color: Colors.redAccent),
          SizedBox(height: 16),
          Text(
            "BE LIABLE",
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4),
          ),
          SizedBox(height: 12),
          Text(
            "Accountability is the bedrock of AIR's systemic trust.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildLiabilityCard(BuildContext context, LiabilityItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.redAccent.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: Colors.redAccent, size: 28),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  "CONSEQUENCE:",
                  style: TextStyle(color: Colors.redAccent.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
                const SizedBox(height: 4),
                Text(
                  item.consequence,
                  style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreementFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.redAccent.withOpacity(0.1))),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.grey, size: 16),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "By continuing to use AIR, you acknowledge and accept these liabilities.",
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
