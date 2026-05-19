import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_showcase_page_template.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import 'web_timeline_of_air_controller.dart';

class WebTimelineOfAirView extends GetView<WebTimelineOfAirController> {
  const WebTimelineOfAirView({super.key});

  static const String routeName = '/web-aspects/timeline-of-air';

  @override
  Widget build(BuildContext context) {
    final section = WebNavData.bySlug('aspects');

    return ShowcasePageTemplate(
      currentRoute: routeName,
      section: section,
      pageTitle: 'Timeline of AIR',
      pageSubtitle:
          'Transform chronology into a visual narrative with responsive slivers, milestone storytelling, and section pacing that lets the history of AIR feel cinematic rather than archived.',
      heroIcon: Icons.timeline_rounded,
      metrics: const [
        ShowcaseMetric(value: '5', label: 'Major eras'),
        ShowcaseMetric(value: '28', label: 'Connected events'),
        ShowcaseMetric(value: '1', label: 'Narrative continuum'),
      ],
      spotlights: const [
        ShowcaseSpotlight(
          title: 'Time as interface',
          body:
              'Flutter is very good at turning raw chronology into an intentional experience with visual pacing and progressive disclosure.',
          icon: Icons.history_edu_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Milestones with emotional weight',
          body:
              'Not every event is equal. Card hierarchy, color rhythm, and scroll depth help mark major beats properly.',
          icon: Icons.flag_circle_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Cross-device continuity',
          body:
              'A timeline should still feel coherent on smaller screens, and Flutter makes those layout shifts manageable.',
          icon: Icons.devices_rounded,
        ),
      ],
      items: section.items,
      timeline: const [
        ShowcaseTimelineEntry(
          label: 'ERA 01',
          title: 'Origin and framing',
          body:
              'Every good timeline begins by telling users what this history is about and why it matters now.',
        ),
        ShowcaseTimelineEntry(
          label: 'ERA 02',
          title: 'Structure milestones clearly',
          body:
              'Visual separation between milestones turns a flat list into a comprehensible progression.',
        ),
        ShowcaseTimelineEntry(
          label: 'ERA 03',
          title: 'Leave room for future beats',
          body:
              'The timeline pattern should support growth so AIR can extend its story without redesigning the page.',
        ),
      ],
      footerBlocks: [
        const SizedBox(height: 36),
        WMaxWidth(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  section.primary.withValues(alpha: 0.10),
                  section.secondary.withValues(alpha: 0.06),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Focus year selector',
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
                  children: ['2023', '2024', '2025', '2026', 'Future'].map((year) {
                    return Obx(() {
                      final active = controller.activeYear.value == year;
                      return InkWell(
                        onTap: () => controller.setYear(year),
                        borderRadius: BorderRadius.circular(100),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
                            year,
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
