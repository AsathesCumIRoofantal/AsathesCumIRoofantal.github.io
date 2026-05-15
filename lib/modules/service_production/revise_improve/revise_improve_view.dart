import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'revise_improve_controller.dart';

class ReviseImproveView extends GetView<ReviseImproveController> {
  const ReviseImproveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Revise & Improve',
      subtitle:
          'Inspect completed outputs, gather structured feedback, and tighten the next processing cycle with targeted refinements. '
          'Continuous improvement is not a one-off project — it is a disciplined habit built into every AIR iteration.',
      icon: Icons.auto_fix_high_rounded,
      items: [
        SampleContentItem(
          title: 'Cycle Retrospective',
          subtitle:
              'After each processing cycle, run a structured retrospective to surface what worked, what did not, and what to change. '
              'Retrospective findings are converted into improvement tickets that feed directly into the next sprint.',
          icon: Icons.loop_rounded,
        ),
        SampleContentItem(
          title: 'Improvement Backlog',
          subtitle:
              'Maintain a prioritised list of all logged improvement ideas, ranked by impact and implementation effort. '
              'Each backlog item tracks its origin, owner, and current status so nothing gets lost between cycles.',
          icon: Icons.format_list_numbered_rounded,
        ),
        SampleContentItem(
          title: 'Root Cause Analysis',
          subtitle:
              'Dig into recurring errors or quality failures using structured five-why and fishbone analysis tools. '
              'Documented root causes prevent the same fix from being applied repeatedly without addressing the underlying issue.',
          icon: Icons.search_rounded,
        ),
        SampleContentItem(
          title: 'Change Experiment Log',
          subtitle:
              'Record every process tweak as a controlled experiment with a hypothesis, expected outcome, and measured result. '
              'The experiment log builds an institutional memory of what has been tried and what actually moved the needle.',
          icon: Icons.science_rounded,
        ),
        SampleContentItem(
          title: 'Quality Trend Charts',
          subtitle:
              'Track error rates, rework volumes, and quality scores across successive cycles on a single timeline. '
              'Trend lines make it easy to confirm whether a recent change is having the intended positive effect.',
          icon: Icons.trending_up_rounded,
        ),
        SampleContentItem(
          title: 'Feedback Inbox',
          subtitle:
              'Collect structured feedback from operators, clients, and automated monitors in one consolidated inbox. '
              'Each piece of feedback is triaged, tagged, and linked to the relevant process area for targeted action.',
          icon: Icons.inbox_rounded,
        ),
      ],
    );
  }
}
