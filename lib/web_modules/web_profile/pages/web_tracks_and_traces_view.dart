import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_showcase_page_template.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import 'web_tracks_and_traces_controller.dart';

class WebTracksAndTracesView extends GetView<WebTracksAndTracesController> {
  const WebTracksAndTracesView({super.key});

  static const String routeName = '/web-profile/tracks-and-traces';

  @override
  Widget build(BuildContext context) {
    final section = WebNavData.bySlug('profile');

    return ShowcasePageTemplate(
      currentRoute: routeName,
      section: section,
      pageTitle: 'Tracks & Traces',
      pageSubtitle:
          'Use Flutter to present profile intelligence, audit signals, and activity narratives with the polish of a product dashboard and the clarity of a personal operating log.',
      heroIcon: Icons.track_changes_rounded,
      metrics: const [
        ShowcaseMetric(value: '12.4K', label: 'Tracked events'),
        ShowcaseMetric(value: '98%', label: 'Trace continuity'),
        ShowcaseMetric(value: '24/7', label: 'Profile visibility'),
      ],
      spotlights: const [
        ShowcaseSpotlight(
          title: 'Audit console feel',
          body:
              'Flutter can deliver terminal-inspired or analytics-inspired experiences without becoming visually brittle.',
          icon: Icons.terminal_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Readable state density',
          body:
              'Profile and trace pages often need a lot of signal in one view. Good layout keeps that useful instead of overwhelming.',
          icon: Icons.analytics_outlined,
        ),
        ShowcaseSpotlight(
          title: 'Personal data as narrative',
          body:
              'A trace page is more than logs. It can become a visual story of activity, reliability, and momentum.',
          icon: Icons.route_rounded,
        ),
      ],
      items: section.items,
      timeline: const [
        ShowcaseTimelineEntry(
          label: 'TRACE 01',
          title: 'Capture the right events',
          body:
              'A useful profile page starts by collecting meaningful changes instead of dumping raw noise everywhere.',
        ),
        ShowcaseTimelineEntry(
          label: 'TRACE 02',
          title: 'Group signals by intent',
          body:
              'Flutter widgets make it easy to shape logs into identity, performance, and accountability segments.',
        ),
        ShowcaseTimelineEntry(
          label: 'TRACE 03',
          title: 'Expose confidence visually',
          body:
              'Confidence indicators, badges, status chips, and motion cues help users trust what they are seeing.',
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
                  'Audit filters prototype',
                  style: TextStyle(
                    color: section.primary,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: ['All Logs', 'Security', 'Access', 'System'].map((tab) {
                    return Obx(() {
                      final active = controller.activeTab.value == tab;
                      return InkWell(
                        onTap: () => controller.setTab(tab),
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
                            tab,
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
