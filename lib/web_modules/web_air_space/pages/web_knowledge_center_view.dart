import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_showcase_page_template.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import 'web_knowledge_center_controller.dart';

class WebKnowledgeCenterView extends GetView<WebKnowledgeCenterController> {
  const WebKnowledgeCenterView({super.key});

  static const String routeName = '/web-air-space/knowledge-center';

  @override
  Widget build(BuildContext context) {
    final section = WebNavData.bySlug('air_space');

    return ShowcasePageTemplate(
      currentRoute: routeName,
      section: section,
      pageTitle: 'Knowledge Center',
      pageSubtitle:
          'Turn AIR Space into a high-signal resource cockpit with searchable documents, layered intelligence, animated content blocks, and editorial clarity that works on web and desktop.',
      heroIcon: Icons.library_books_rounded,
      searchQuery: controller.activeCategory,
      onSearchChanged: controller.setCategory,
      searchHint: 'Search research papers, reports, and knowledge assets...',
      metrics: const [
        ShowcaseMetric(value: '128', label: 'Indexed assets'),
        ShowcaseMetric(value: '24', label: 'Live collections'),
        ShowcaseMetric(value: '4.9', label: 'Signal score'),
      ],
      spotlights: const [
        ShowcaseSpotlight(
          title: 'Search-first reading flow',
          body:
              'Pair sliver search with responsive card grids so long knowledge inventories still feel fast, editorial, and navigable.',
          icon: Icons.manage_search_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Context-rich knowledge cards',
          body:
              'Each asset can surface title, topic, access posture, freshness, author signals, and content excerpts without becoming visually noisy.',
          icon: Icons.auto_stories_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Desktop-grade information density',
          body:
              'Flutter web handles dashboard-style layouts well when typography, spacing, and hover states are designed intentionally.',
          icon: Icons.dashboard_customize_rounded,
        ),
      ],
      items: section.items,
      timeline: const [
        ShowcaseTimelineEntry(
          label: 'STEP 01',
          title: 'Ingest and classify assets',
          body:
              'Reports, policies, notes, and reference packs are tagged into AIR Space so the page starts from a coherent content model.',
        ),
        ShowcaseTimelineEntry(
          label: 'STEP 02',
          title: 'Surface searchable clusters',
          body:
              'Pinned search, topic labels, and visual grouping reduce cognitive load when the catalog grows.',
        ),
        ShowcaseTimelineEntry(
          label: 'STEP 03',
          title: 'Guide deeper reading',
          body:
              'Hero messaging, editorial spotlights, and card summaries make the page feel curated rather than like raw storage.',
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
                  'Why this showcases Flutter well',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: section.primary,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'This kind of page demonstrates one of Flutter’s strongest abilities: building a polished, data-heavy interface without splitting implementation between mobile and web stacks. The same widget composition can power catalog browsing, admin consoles, and content hubs with consistent behavior.',
                  style: TextStyle(height: 1.65),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
