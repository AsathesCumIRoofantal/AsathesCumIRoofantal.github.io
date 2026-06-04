import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'demonstration_controller.dart';

class DemonstrationView extends GetView<DemonstrationController> {
  final bool isEmbedded;
  const DemonstrationView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Demonstration',
      subtitle:
          'Show your progress through live walkthroughs, recorded demos, and annotated evidence. '
          'Demonstrations turn abstract claims into concrete, verifiable proof of competence.',
      icon: Icons.present_to_all,
      items: const [
        SampleContentItem(
          title: 'Schedule a Demo',
          subtitle:
              'Book a demonstration slot with an evaluator and specify the skill or task to be shown. '
              'Attach any pre-requisite materials so the assessor can prepare in advance.',
          icon: Icons.event_note,
        ),
        SampleContentItem(
          title: 'Live Walkthrough',
          subtitle:
              'Conduct a step-by-step walkthrough of a process or procedure in real time. '
              'Evaluators can annotate observations directly on the session record as it unfolds.',
          icon: Icons.slideshow,
        ),
        SampleContentItem(
          title: 'Recorded Evidence',
          subtitle:
              'Upload video or photo evidence of a completed demonstration for async review. '
              'Recordings are stored securely and linked to the relevant competency framework.',
          icon: Icons.video_camera_back,
        ),
        SampleContentItem(
          title: 'Evaluator Feedback',
          subtitle:
              'Receive structured feedback from your assessor after each demonstration session. '
              'Feedback is tied to specific rubric criteria so you know exactly where to improve.',
          icon: Icons.rate_review,
        ),
        SampleContentItem(
          title: 'Demo History',
          subtitle:
              'Review all past demonstrations with their outcomes, scores, and evaluator notes. '
              'Track your improvement trajectory across multiple attempts on the same skill.',
          icon: Icons.history_edu,
        ),
        SampleContentItem(
          title: 'Peer Demonstrations',
          subtitle:
              'Watch demonstrations submitted by peers to learn alternative techniques and approaches. '
              'Leave constructive comments to foster a culture of shared learning.',
          icon: Icons.people_outline,
        ),
      ],
    );
  }
}



