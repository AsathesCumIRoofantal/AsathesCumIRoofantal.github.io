import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'technology_controller.dart';

class TechnologyView extends GetView<TechnologyController> {
  const TechnologyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Technology',
      subtitle:
          'Technology in AIR is your personal stack inventory — what you run, why you chose it, and when it needs revisiting. Stay intentional about your tools instead of accumulating them by accident.',
      icon: Icons.developer_board_outlined,
      items: const [
        SampleContentItem(
          title: 'Current Stack',
          subtitle:
              'Document every tool, platform, and service you actively use — from your IDE to your cloud provider. Knowing your stack precisely prevents duplication and makes onboarding others much faster.',
          icon: Icons.layers_outlined,
        ),
        SampleContentItem(
          title: 'Why Each Tool',
          subtitle:
              'Every tool in your stack should have a written rationale. If you can\'t articulate why you use something, that\'s a signal to evaluate whether it still earns its place.',
          icon: Icons.help_outline,
        ),
        SampleContentItem(
          title: 'Upgrade Windows',
          subtitle:
              'Dependencies go stale and security patches pile up. Set a quarterly upgrade window for each major dependency and log the version history so you can roll back with confidence.',
          icon: Icons.system_update_alt_outlined,
        ),
        SampleContentItem(
          title: 'Tech Debt Register',
          subtitle:
              'Tech debt is a loan — it accrues interest over time. Keep a running register of known shortcuts, workarounds, and deferred refactors so you can schedule paydown deliberately.',
          icon: Icons.warning_amber_outlined,
        ),
        SampleContentItem(
          title: 'Evaluation Pipeline',
          subtitle:
              'New tools deserve a structured trial before adoption. Log tools you\'re evaluating, set a 30-day trial deadline, and record your verdict so you don\'t re-evaluate the same thing twice.',
          icon: Icons.science_outlined,
        ),
        SampleContentItem(
          title: 'Security Posture',
          subtitle:
              'Track your authentication methods, secret management approach, and last security audit date. A single compromised credential can undo months of work — stay ahead of it.',
          icon: Icons.security_outlined,
        ),
        SampleContentItem(
          title: 'Automation Wins',
          subtitle:
              'Log every manual process you\'ve automated and estimate the time saved per week. This builds a compelling case for continued investment in tooling and keeps your team motivated.',
          icon: Icons.smart_toy_outlined,
        ),
      ],
    );
  }
}
