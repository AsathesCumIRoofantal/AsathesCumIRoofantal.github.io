import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_showcase_page_template.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import 'web_process_controller.dart';

class WebProcessView extends GetView<WebProcessController> {
  const WebProcessView({super.key});

  static const String routeName = '/web-service/process';

  @override
  Widget build(BuildContext context) {
    final section = WebNavData.bySlug('service');

    return ShowcasePageTemplate(
      currentRoute: routeName,
      section: section,
      pageTitle: 'Process & Pipeline',
      pageSubtitle:
          'Showcase Flutter as an operations-grade UI toolkit by turning service workflows into a refined, readable process surface with stages, ownership cues, and forward momentum.',
      heroIcon: Icons.gavel_rounded,
      metrics: const [
        ShowcaseMetric(value: '4', label: 'Pipeline stages'),
        ShowcaseMetric(value: '15', label: 'Active items'),
        ShowcaseMetric(value: '99.2%', label: 'SLA confidence'),
      ],
      spotlights: const [
        ShowcaseSpotlight(
          title: 'Operational clarity',
          body:
              'Flutter is strong for workflow pages when the UI must feel structured, legible, and responsive under load.',
          icon: Icons.assignment_turned_in_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Board logic without clutter',
          body:
              'Pipelines need stage visibility, throughput cues, and task summaries without looking like spreadsheet debris.',
          icon: Icons.view_kanban_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Shared design, distinct posture',
          body:
              'Service pages should feel procedural and accountable, which is a different mood from learning or storytelling pages.',
          icon: Icons.rule_folder_rounded,
        ),
      ],
      items: section.items,
      timeline: const [
        ShowcaseTimelineEntry(
          label: 'PHASE 01',
          title: 'Intake and framing',
          body:
              'Good workflow UIs clarify the request, the owner, and the quality bar before work starts moving.',
        ),
        ShowcaseTimelineEntry(
          label: 'PHASE 02',
          title: 'Progress with accountability',
          body:
              'Each stage should signal state, blockers, and expected next moves without users needing a separate legend.',
        ),
        ShowcaseTimelineEntry(
          label: 'PHASE 03',
          title: 'Close loops visibly',
          body:
              'The UI should make completed service outcomes feel verifiable, not merely moved to another column.',
        ),
      ],
      footerBlocks: [
        const SizedBox(height: 36),
        WMaxWidth(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: section.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: section.primary.withValues(alpha: 0.18)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pipeline mode',
                  style: TextStyle(
                    color: section.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: ['Standard Delivery', 'Fast Track', 'Review Heavy'].map((mode) {
                    return Obx(() {
                      final active = controller.activePipeline.value == mode;
                      return InkWell(
                        onTap: () => controller.setPipeline(mode),
                        borderRadius: BorderRadius.circular(100),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: active ? section.primary : Colors.transparent,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: active
                                  ? section.primary
                                  : section.primary.withValues(alpha: 0.24),
                            ),
                          ),
                          child: Text(
                            mode,
                            style: TextStyle(
                              color: active ? Colors.white : section.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
