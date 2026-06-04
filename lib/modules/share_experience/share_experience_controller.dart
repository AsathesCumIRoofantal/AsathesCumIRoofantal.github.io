import 'package:get/get.dart';

class ExperienceModel {
  final String id;
  final String subject;
  final String detail;
  final List<String> attachments;
  final DateTime timestamp;

  ExperienceModel({
    required this.id,
    required this.subject,
    required this.detail,
    required this.attachments,
    required this.timestamp,
  });
}

class ShareExperienceController extends GetxController {
  var experiences = <ExperienceModel>[].obs;
  var tempAttachments = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSamples();
  }

  void _loadSamples() {
    experiences.addAll([
      ExperienceModel(
        id: '1',
        subject: 'Initial Atlas Exploration',
        detail: 'Today I successfully mapped my first 5 entities in the All-Space catalogue. The cosmic theme provided a serene environment for reflection. Systemic nodes are becoming clearer.',
        attachments: ['atlas_map_v1.png', 'node_report.pdf'],
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ExperienceModel(
        id: '2',
        subject: 'First Systemic Union',
        detail: 'Established a "Conceptual Union" between the Teacher and Student nodes. The relationship logic within AIR is solid and provides a great framework for understanding complex groupings.',
        attachments: ['union_flowchart.jpg'],
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      ExperienceModel(
        id: '3',
        subject: 'Identity Mapping Phase 1',
        detail: 'Completed my first identity mapping. The phases of the questionnaire forced me to rethink my existential coordinates. I am now officially a "Philosophical Sentinel".',
        attachments: [],
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
    ]);
    // Sort so newest is at the top (reversed since we AddAll)
    experiences.value = experiences.reversed.toList();
  }

  void addExperience(String subject, String detail) {
    if (subject.isEmpty || detail.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all required fields.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final newExp = ExperienceModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subject: subject,
      detail: detail,
      attachments: List<String>.from(tempAttachments),
      timestamp: DateTime.now(),
    );

    experiences.insert(0, newExp);
    tempAttachments.clear();
    Get.back(); // Close modal
    
    Get.snackbar(
      'Success',
      'Experience shared with the AIR ecosystem.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void addMockAttachment() {
    tempAttachments.add('attachment_${tempAttachments.length + 1}.pdf');
  }

  void removeAttachment(int index) {
    tempAttachments.removeAt(index);
  }
}
