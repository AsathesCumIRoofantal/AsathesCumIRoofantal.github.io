import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'accountable_controller.dart';

class AccountableView extends GetView<AccountableController> {
  const AccountableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Accountable',
      subtitle:
          'Own every outcome you set in motion — through transparent ledgers, kept promises, and honest follow-through even when no one is watching. '
          'Accountability in AIR is not punishment; it is the discipline of closing every loop you open.',
      icon: Icons.fact_check_rounded,
      items: [
        SampleContentItem(
          title: 'Commitment Ledger',
          subtitle:
              'Log every promise you make — to yourself, your team, or the community — and track its status from open to closed. '
              'The ledger creates a living record of your word, making it easy to spot patterns of follow-through or drift before they become habits.',
          icon: Icons.menu_book_rounded,
        ),
        SampleContentItem(
          title: 'Outcome Ownership Declaration',
          subtitle:
              'Before starting any task or project, formally declare ownership so there is never ambiguity about who is responsible for the result. '
              'Declarations are timestamped and visible to relevant stakeholders, removing the grey zone where accountability usually disappears.',
          icon: Icons.assignment_ind_rounded,
        ),
        SampleContentItem(
          title: 'Transparent Progress Updates',
          subtitle:
              'Share structured progress notes at agreed intervals so stakeholders always know where things stand without having to chase you. '
              'Transparency builds trust faster than any single success, and it makes course-correction a collaborative act rather than a surprise.',
          icon: Icons.update_rounded,
        ),
        SampleContentItem(
          title: 'Miss & Learn Report',
          subtitle:
              'When a commitment is missed, file a brief miss-and-learn report that captures what happened, why, and what changes next time. '
              'The report is not a confession — it is a signal of maturity that turns every failure into institutional knowledge.',
          icon: Icons.report_problem_rounded,
        ),
        SampleContentItem(
          title: 'Accountability Score',
          subtitle:
              'Your rolling accountability score reflects the ratio of commitments made to commitments honoured over the past 90 days. '
              'The score is private by default but can be shared selectively to build credibility with collaborators and partners.',
          icon: Icons.score_rounded,
        ),
        SampleContentItem(
          title: 'Delegation Handoff Protocol',
          subtitle:
              'When you pass a task to someone else, use the handoff protocol to transfer ownership cleanly — including context, constraints, and a clear acceptance signal. '
              'Clean handoffs prevent the accountability vacuum that forms when tasks move between people without explicit transfer.',
          icon: Icons.swap_horiz_rounded,
        ),
        SampleContentItem(
          title: 'Closure Ritual',
          subtitle:
              'Mark completed commitments with a brief closure note that confirms the outcome and any residual actions. '
              'The ritual trains the brain to associate finishing with satisfaction, reinforcing the accountability loop at a neurological level.',
          icon: Icons.check_circle_rounded,
        ),
      ],
    );
  }
}
