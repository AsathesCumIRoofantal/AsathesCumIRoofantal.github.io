import 'package:get/get.dart';

class ApiEndpoint {
  final String name;
  final String method;
  final String status;
  final int latency;

  ApiEndpoint({required this.name, required this.method, required this.status, required this.latency});
}

class NetworkApisController extends GetxController {
  final endpoints = <ApiEndpoint>[
    ApiEndpoint(name: "/auth/login", method: "POST", status: "Healthy", latency: 120),
    ApiEndpoint(name: "/user/profile", method: "GET", status: "Slow", latency: 850),
    ApiEndpoint(name: "/data/sync", method: "PUT", status: "Healthy", latency: 45),
  ].obs;

  void testNetwork() {
    Get.snackbar("Network Test", "Pinging global AIR nodes...");
  }
}
