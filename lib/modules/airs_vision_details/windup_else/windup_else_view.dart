import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'windup_else_controller.dart';

class WindupElseView extends GetView<WindupElseController> {
  final bool isEmbedded;
  const WindupElseView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Windup & Else',
      subtitle:
          'Close out initiatives, sessions, and commitments gracefully — preserving the truth of what happened without leaving loose ends. '
          'A good wind-down is as important as a strong start: it honours the work done and frees energy for what comes next.',
      icon: Icons.flag_circle_rounded,
      items: [
        SampleContentItem(
          title: 'Initiative Closure Checklist',
          subtitle:
              'Walk through a structured checklist before formally closing any AIR initiative — deliverables confirmed, stakeholders notified, and lessons captured. '
              'Skipping steps is flagged so nothing critical is accidentally left open.',
          icon: Icons.checklist_rtl_rounded,
        ),
        SampleContentItem(
          title: 'Truth Preservation Log',
          subtitle:
              'Record the honest account of what happened during an initiative — what worked, what did not, and what was learned. '
              'The log is immutable once signed off, ensuring the institutional memory cannot be rewritten after the fact.',
          icon: Icons.lock_clock_rounded,
        ),
        SampleContentItem(
          title: 'Handover Package Builder',
          subtitle:
              'Compile all relevant documents, contacts, and context into a structured handover package for the next owner or team. '
              'Handover packages reduce the knowledge loss that typically occurs when responsibilities change hands.',
          icon: Icons.handshake_rounded,
        ),
        SampleContentItem(
          title: 'Commitment Settlement',
          subtitle:
              'Review every outstanding commitment made during the initiative and mark each as fulfilled, transferred, or formally released. '
              'Unsettled commitments are surfaced to the responsible party before the closure is approved.',
          icon: Icons.task_alt_rounded,
        ),
        SampleContentItem(
          title: 'Resource Release',
          subtitle:
              'Free up budget, tooling access, and team allocations tied to the closing initiative so they can be redeployed. '
              'Resource release is tracked to prevent ghost allocations that quietly drain capacity from active work.',
          icon: Icons.lock_open_rounded,
        ),
        SampleContentItem(
          title: 'Closure Retrospective',
          subtitle:
              'Run a final retrospective focused specifically on the wind-down process itself — was it smooth, complete, and respectful? '
              'Findings feed into the next initiative\'s planning so closures keep getting better over time.',
          icon: Icons.rate_review_rounded,
        ),
      ],
    );
  }
}
