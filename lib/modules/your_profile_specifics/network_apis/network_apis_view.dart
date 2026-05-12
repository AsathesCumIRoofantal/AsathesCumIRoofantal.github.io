import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'network_apis_controller.dart';

class NetworkApisView extends GetView<NetworkApisController> {
  const NetworkApisView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0208), // Matrix/Terminal dark
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('NETWORK & APIs', style: TextStyle(color: Color(0xFF00FF41), letterSpacing: 4, fontFamily: 'monospace')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildTerminalHeader(),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.endpoints.length,
              itemBuilder: (context, index) {
                final api = controller.endpoints[index];
                return _buildApiRow(api);
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.testNetwork(),
        label: const Text("RUN NETWORK DIAGNOSTICS", style: TextStyle(fontFamily: 'monospace')),
        icon: const Icon(Icons.terminal),
        backgroundColor: const Color(0xFF00FF41),
        foregroundColor: Colors.black,
      ),
    );
  }

  Widget _buildTerminalHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("AIR OS NETWORK STATUS: ONLINE", style: TextStyle(color: Color(0xFF00FF41), fontSize: 12, fontFamily: 'monospace')),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: 0.8, backgroundColor: Colors.grey[900], color: const Color(0xFF00FF41)),
        ],
      ),
    );
  }

  Widget _buildApiRow(ApiEndpoint api) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF00FF41).withOpacity(0.3)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Text(api.method, style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 10, fontFamily: 'monospace')),
          const SizedBox(width: 16),
          Expanded(child: Text(api.name, style: const TextStyle(color: Colors.white, fontFamily: 'monospace'))),
          Text("${api.latency}ms", style: TextStyle(color: api.latency > 500 ? Colors.red : Colors.green, fontSize: 10, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
