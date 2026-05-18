import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'private_confidential_controller.dart';

class PrivateConfidentialView extends GetView<PrivateConfidentialController> {
  final bool isEmbedded;
  const PrivateConfidentialView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),

      child: Column(
        children: [
          FloatingActionButton.extended(
            onPressed: () => controller.authenticate(),
            label: const Text("AUTHENTICATE ACCESS"),
            icon: const Icon(Icons.fingerprint),
            backgroundColor: Colors.red[900],
          ),
          _buildVaultHeader(context),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.files.length,
                itemBuilder: (context, index) {
                  final file = controller.files[index];
                  return _buildSecureFileRow(context, file);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaultHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: const Column(
        children: [
          Icon(Icons.shield_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 24),
          Text(
            "RESTRICTED AREA",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Military Grade Encryption Active",
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecureFileRow(BuildContext context, ConfidentialFile file) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.lock_outline, color: Colors.red),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Access: ${file.accessLevel}",
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
          Text(
            file.status,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
