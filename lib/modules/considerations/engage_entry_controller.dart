// ============================================================
//  EngageEntry – Controller
//  GetX controller for the full entry form
// ============================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ── Enums ────────────────────────────────────────────────
enum EntrySection { product, operations, hr, finance, tech, general }

enum SectionTab { planning, execution, review, archive }

enum CatchCriteria {
  isSuggestion,
  isProblem,
  isSolution,
  isUrgent,
  isGeneral,
  isBlocking,
  isIdea,
  isFollowUp,
}

// ── Attachment model ──────────────────────────────────────
class AttachmentFile {
  final String name;
  final String extension;
  final int    sizeBytes;
  final String? previewUrl; // non-null for images

  const AttachmentFile({
    required this.name,
    required this.extension,
    required this.sizeBytes,
    this.previewUrl,
  });

  String get sizeLabel {
    if (sizeBytes < 1024) return '$sizeBytes B';
    if (sizeBytes < 1024 * 1024) return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  IconData get icon {
    switch (extension.toLowerCase()) {
      case 'pdf':         return Icons.picture_as_pdf_rounded;
      case 'doc':
      case 'docx':        return Icons.description_rounded;
      case 'xls':
      case 'xlsx':        return Icons.table_chart_rounded;
      case 'png':
      case 'jpg':
      case 'jpeg':        return Icons.image_rounded;
      case 'mp4':
      case 'mov':         return Icons.videocam_rounded;
      default:            return Icons.insert_drive_file_rounded;
    }
  }

  Color get iconColor {
    switch (extension.toLowerCase()) {
      case 'pdf':         return const Color(0xFFEF4444);
      case 'doc':
      case 'docx':        return const Color(0xFF3B82F6);
      case 'xls':
      case 'xlsx':        return const Color(0xFF10B981);
      case 'png':
      case 'jpg':
      case 'jpeg':        return const Color(0xFF8B5CF6);
      default:            return const Color(0xFF6B7280);
    }
  }
}

// ── Assignee model ────────────────────────────────────────
class Assignee {
  final String id;
  final String name;
  final String role;
  final Color  avatarColor;

  const Assignee({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarColor,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name[0].toUpperCase();
  }
}

// ── Entry model (the saved card) ──────────────────────────
class EngageEntry {
  final String           id;
  final EntrySection     section;
  final SectionTab       sectionTab;
  final String           contextBrief;
  final String           title;
  final String           description;
  final String           remark;
  final List<CatchCriteria> criteria;
  final List<AttachmentFile> attachments;
  final List<Assignee>   assignees;
  final DateTime         createdAt;

  const EngageEntry({
    required this.id,
    required this.section,
    required this.sectionTab,
    required this.contextBrief,
    required this.title,
    required this.description,
    required this.remark,
    required this.criteria,
    required this.attachments,
    required this.assignees,
    required this.createdAt,
  });
}

// ════════════════════════════════════════════════════════════
//  CONTROLLER
// ════════════════════════════════════════════════════════════
class EngageEntryController extends GetxController {
  static EngageEntryController get to => Get.find();

  // ── Form key ─────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();

  // ── Text controllers ──────────────────────────────────────
  final contextBriefCtrl = TextEditingController();
  final titleCtrl        = TextEditingController();
  final descriptionCtrl  = TextEditingController();
  final remarkCtrl       = TextEditingController();

  // ── Reactive state ────────────────────────────────────────
  final Rx<EntrySection>        selectedSection    = EntrySection.general.obs;
  final Rx<SectionTab>          selectedTab        = SectionTab.planning.obs;
  final RxSet<CatchCriteria>    selectedCriteria   = <CatchCriteria>{}.obs;
  final RxList<AttachmentFile>  attachments        = <AttachmentFile>[].obs;
  final RxList<Assignee>        selectedAssignees  = <Assignee>[].obs;
  final RxBool                  isSubmitting       = false.obs;
  final RxList<EngageEntry>     entries            = <EngageEntry>[].obs;

  // ── All available assignees ──────────────────────────────
  final List<Assignee> allAssignees = const [
    Assignee(id: 'a1', name: 'Aryan Sharma',    role: 'Product Manager',    avatarColor: Color(0xFF6366F1)),
    Assignee(id: 'a2', name: 'Priya Mehta',     role: 'UI/UX Designer',     avatarColor: Color(0xFFEC4899)),
    Assignee(id: 'a3', name: 'Rohan Verma',     role: 'Lead Developer',     avatarColor: Color(0xFF10B981)),
    Assignee(id: 'a4', name: 'Sneha Patel',     role: 'QA Engineer',        avatarColor: Color(0xFFF59E0B)),
    Assignee(id: 'a5', name: 'Dev Kumar',       role: 'Backend Developer',  avatarColor: Color(0xFF3B82F6)),
    Assignee(id: 'a6', name: 'Meera Joshi',     role: 'Business Analyst',   avatarColor: Color(0xFF8B5CF6)),
    Assignee(id: 'a7', name: 'Anil Chauhan',    role: 'DevOps Engineer',    avatarColor: Color(0xFF14B8A6)),
    Assignee(id: 'a8', name: 'Kavya Reddy',     role: 'Scrum Master',       avatarColor: Color(0xFFF97316)),
  ];

  // ── Criteria config ──────────────────────────────────────
  static const Map<CatchCriteria, ({String label, IconData icon, Color color})> criteriaConfig = {
    CatchCriteria.isSuggestion: (label: 'Suggestion',  icon: Icons.lightbulb_rounded,       color: Color(0xFFF59E0B)),
    CatchCriteria.isProblem:    (label: 'Problem',     icon: Icons.warning_amber_rounded,    color: Color(0xFFEF4444)),
    CatchCriteria.isSolution:   (label: 'Solution',    icon: Icons.check_circle_rounded,     color: Color(0xFF10B981)),
    CatchCriteria.isUrgent:     (label: 'Urgent',      icon: Icons.flash_on_rounded,         color: Color(0xFFDC2626)),
    CatchCriteria.isGeneral:    (label: 'General',     icon: Icons.info_rounded,             color: Color(0xFF6B7280)),
    CatchCriteria.isBlocking:   (label: 'Blocking',    icon: Icons.block_rounded,            color: Color(0xFFB91C1C)),
    CatchCriteria.isIdea:       (label: 'Idea',        icon: Icons.emoji_objects_rounded,    color: Color(0xFF8B5CF6)),
    CatchCriteria.isFollowUp:   (label: 'Follow-Up',   icon: Icons.replay_rounded,           color: Color(0xFF3B82F6)),
  };

  // ── Section config ───────────────────────────────────────
  static const Map<EntrySection, ({String label, IconData icon, Color color})> sectionConfig = {
    EntrySection.product:    (label: 'Product',     icon: Icons.inventory_2_rounded,       color: Color(0xFF6366F1)),
    EntrySection.operations: (label: 'Operations',  icon: Icons.settings_rounded,          color: Color(0xFF10B981)),
    EntrySection.hr:         (label: 'HR',          icon: Icons.people_rounded,            color: Color(0xFFEC4899)),
    EntrySection.finance:    (label: 'Finance',     icon: Icons.account_balance_rounded,   color: Color(0xFFF59E0B)),
    EntrySection.tech:       (label: 'Tech',        icon: Icons.code_rounded,              color: Color(0xFF3B82F6)),
    EntrySection.general:    (label: 'General',     icon: Icons.grid_view_rounded,         color: Color(0xFF8B5CF6)),
  };

  // ── Tab config ───────────────────────────────────────────
  static const Map<SectionTab, ({String label, IconData icon})> tabConfig = {
    SectionTab.planning:   (label: 'Planning',   icon: Icons.flag_rounded),
    SectionTab.execution:  (label: 'Execution',  icon: Icons.play_circle_rounded),
    SectionTab.review:     (label: 'Review',     icon: Icons.rate_review_rounded),
    SectionTab.archive:    (label: 'Archive',    icon: Icons.archive_rounded),
  };

  // ── Actions ──────────────────────────────────────────────
  void selectSection(EntrySection s)  => selectedSection.value = s;
  void selectTab(SectionTab t)        => selectedTab.value = t;

  void toggleCriteria(CatchCriteria c) {
    if (selectedCriteria.contains(c)) {
      selectedCriteria.remove(c);
    } else {
      selectedCriteria.add(c);
    }
  }

  void toggleAssignee(Assignee a) {
    if (selectedAssignees.any((x) => x.id == a.id)) {
      selectedAssignees.removeWhere((x) => x.id == a.id);
    } else {
      selectedAssignees.add(a);
    }
  }

  bool isAssigneeSelected(Assignee a) => selectedAssignees.any((x) => x.id == a.id);

  // ── Dummy file picker ─────────────────────────────────────
  void pickFiles() {
    final dummyFiles = [
      const AttachmentFile(name: 'requirements_doc',   extension: 'pdf',  sizeBytes: 245760),
      const AttachmentFile(name: 'wireframe_v2',       extension: 'png',  sizeBytes: 512000),
      const AttachmentFile(name: 'sprint_tracker',     extension: 'xlsx', sizeBytes: 89600),
      const AttachmentFile(name: 'meeting_notes',      extension: 'docx', sizeBytes: 32768),
      const AttachmentFile(name: 'demo_recording',     extension: 'mp4',  sizeBytes: 15728640),
    ];
    // Pick a random one not already added
    final available = dummyFiles.where(
        (f) => !attachments.any((a) => a.name == f.name)).toList();
    if (available.isEmpty) {
      Get.snackbar('No more files', 'All sample files already added.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    attachments.add(available.first);
  }

  void removeAttachment(int index) => attachments.removeAt(index);

  // ── Submit ────────────────────────────────────────────────
  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedCriteria.isEmpty) {
      Get.snackbar('Select Criteria', 'Please select at least one catch criteria.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white);
      return;
    }

    isSubmitting.value = true;
    await Future.delayed(const Duration(milliseconds: 900)); // Simulate API

    final entry = EngageEntry(
      id:           'entry_${DateTime.now().millisecondsSinceEpoch}',
      section:      selectedSection.value,
      sectionTab:   selectedTab.value,
      contextBrief: contextBriefCtrl.text.trim(),
      title:        titleCtrl.text.trim(),
      description:  descriptionCtrl.text.trim(),
      remark:       remarkCtrl.text.trim(),
      criteria:     selectedCriteria.toList(),
      attachments:  attachments.toList(),
      assignees:    selectedAssignees.toList(),
      createdAt:    DateTime.now(),
    );

    entries.insert(0, entry);
    isSubmitting.value = false;

    Get.snackbar(
      '✅ Entry Added',
      '"${entry.title}" has been saved successfully.',
      snackPosition:   SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF10B981),
      colorText:       Colors.white,
      duration:        const Duration(seconds: 3),
    );

    _resetForm();
  }

  void _resetForm() {
    contextBriefCtrl.clear();
    titleCtrl.clear();
    descriptionCtrl.clear();
    remarkCtrl.clear();
    selectedCriteria.clear();
    attachments.clear();
    selectedAssignees.clear();
    selectedSection.value = EntrySection.general;
    selectedTab.value     = SectionTab.planning;
  }

  void deleteEntry(String id) {
    entries.removeWhere((e) => e.id == id);
    Get.snackbar('Deleted', 'Entry removed.',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    contextBriefCtrl.dispose();
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    remarkCtrl.dispose();
    super.onClose();
  }
}
