import 'package:get/get.dart';

class ProcessingJob {
  final String id;
  final String algorithm;
  final double progress;
  final String eta;

  ProcessingJob({required this.id, required this.algorithm, required this.progress, required this.eta});
}

class ProcessController extends GetxController {
  final activeJobs = <ProcessingJob>[
    ProcessingJob(id: "JOB-901", algorithm: "OCR Engine v2", progress: 0.45, eta: "2m 15s"),
    ProcessingJob(id: "JOB-902", algorithm: "Neural Sync", progress: 0.88, eta: "45s"),
    ProcessingJob(id: "JOB-903", algorithm: "Defragmentation", progress: 0.12, eta: "12m 30s"),
  ].obs;

  void optimizeProcess() {
    Get.snackbar("Optimization", "Reallocating compute resources for maximum throughput.");
  }
}
