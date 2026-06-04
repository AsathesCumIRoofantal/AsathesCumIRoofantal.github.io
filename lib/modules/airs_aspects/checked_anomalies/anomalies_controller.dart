import 'package:get/get.dart';

class Anomaly {
  final String id;
  final String description;
  final String severity;
  final bool isResolved;

  Anomaly({required this.id, required this.description, required this.severity, this.isResolved = false});
}

class AnomaliesController extends GetxController {
  final anomalies = <Anomaly>[
    Anomaly(id: "ANO-701", description: "Inconsistent sensor data in Sector 7", severity: "High", isResolved: true),
    Anomaly(id: "ANO-702", description: "Biometric desync on mobile portal", severity: "Medium", isResolved: false),
    Anomaly(id: "ANO-703", description: "Ghost assets detected in inventory", severity: "Low", isResolved: true),
    Anomaly(id: "ANO-704", description: "Oxygen levels dip in Cargo Bay 4", severity: "Critical", isResolved: false),
  ].obs;

  List<Anomaly> get checkedAnomalies => anomalies.where((a) => a.isResolved).toList();
  List<Anomaly> get uncheckedAnomalies => anomalies.where((a) => !a.isResolved).toList();

  void reportAnomaly() {
    Get.snackbar("Reporting", "New anomaly logged in the system.");
  }
}
