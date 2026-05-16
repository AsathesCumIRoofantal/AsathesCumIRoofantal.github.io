import 'package:get/get.dart';

enum DiscussionStatus { active, concluded }

class DiscussionResponse {
  final String id;
  final String user;
  final String text;
  final DateTime timestamp;

  DiscussionResponse({
    required this.id,
    required this.user,
    required this.text,
    required this.timestamp,
  });
}

class ConclusiveDocument {
  final String title;
  final String url;

  ConclusiveDocument({required this.title, required this.url});
}

class DiscussionModel {
  final String id;
  final String topic;
  final String remarks;
  final DateTime timestamp;
  final RxList<DiscussionResponse> responses;
  final List<ConclusiveDocument> conclusiveDocuments;
  final DiscussionStatus status;

  DiscussionModel({
    required this.id,
    required this.topic,
    required this.remarks,
    required this.timestamp,
    required List<DiscussionResponse> responses,
    this.conclusiveDocuments = const [],
    this.status = DiscussionStatus.active,
  }) : responses = responses.obs;
}

class QueryDiscussionController extends GetxController {
  var discussions = <DiscussionModel>[].obs;
  var searchQuery = ''.obs;

  List<DiscussionModel> get filteredDiscussions {
    if (searchQuery.value.isEmpty) {
      return discussions;
    }
    final query = searchQuery.value.toLowerCase();
    return discussions
        .where(
          (d) =>
              d.topic.toLowerCase().contains(query) ||
              d.remarks.toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadSamples();
  }

  void _loadSamples() {
    discussions.addAll([
      DiscussionModel(
        id: '1',
        topic: 'Standardizing Node Sync Protocols',
        remarks:
            'Discussing the transition from MESH-X72 to the new ultra-low latency protocols for deep atlas mapping.',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        responses: [
          DiscussionResponse(
            id: 'r1',
            user: 'Admin_AIR',
            text: 'Proposed protocols look solid, observing node stability.',
            timestamp: DateTime.now().subtract(const Duration(days: 2)),
          ),
          DiscussionResponse(
            id: 'r2',
            user: 'Expert_Alpha',
            text: 'Needs more stress testing in the Alifiyas sector.',
            timestamp: DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      ),
      DiscussionModel(
        id: '2',
        topic: 'Transparency Log Refactor',
        remarks:
            'Finalized the architectural changes required for absolute ledger transparency.',
        timestamp: DateTime.now().subtract(const Duration(days: 10)),
        status: DiscussionStatus.concluded,
        responses: [],
        conclusiveDocuments: [
          ConclusiveDocument(
            title: 'Refactor Roadmap.pdf',
            url: 'https://air.org/docs/refactor',
          ),
          ConclusiveDocument(
            title: 'Final Schema.json',
            url: 'https://air.org/docs/schema',
          ),
        ],
      ),
    ]);
  }

  Future<void> postQuery({
    required String topic,
    required String remarks,
  }) async {
    if (topic.isEmpty || remarks.isEmpty) {
      Get.snackbar(
        'Input Error',
        'Please provide both a topic and contextual remarks.',
      );
      return;
    }

    final newDiscussion = DiscussionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      topic: topic,
      remarks: remarks,
      timestamp: DateTime.now(),
      responses: [],
    );

    discussions.insert(0, newDiscussion);
    Get.back(); // Close modal

    Get.snackbar(
      'Discussion Initiated',
      'Your query has been broadcasted to the AIR community.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.1),
      colorText: Get.theme.colorScheme.primary,
    );

    // Simulate community response after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      _simulateResponse(newDiscussion.id);
    });
  }

  void _simulateResponse(String discussionId) {
    final index = discussions.indexWhere((d) => d.id == discussionId);
    if (index != -1) {
      discussions[index].responses.add(
        DiscussionResponse(
          id: 'sim_${DateTime.now().millisecondsSinceEpoch}',
          user: 'CommunityNode_Bot',
          text:
              'Interesting topic! I have cross-referenced this with the Knowledge Center and found partial matches in the Alifiyas archives.',
          timestamp: DateTime.now(),
        ),
      );

      Get.snackbar(
        'New Response',
        'A community member has responded to your topic: "${discussions[index].topic}"',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.secondary.withValues(alpha: 0.2),
        duration: const Duration(seconds: 4),
      );
    }
  }
}
