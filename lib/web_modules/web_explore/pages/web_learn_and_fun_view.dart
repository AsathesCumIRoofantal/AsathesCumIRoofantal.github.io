import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_showcase_page_template.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import 'web_learn_and_fun_controller.dart';

class WebLearnAndFunView extends GetView<WebLearnAndFunController> {
  const WebLearnAndFunView({super.key});

  static const String routeName = '/web-explore/learn-and-fun';

  @override
  Widget build(BuildContext context) {
    final section = WebNavData.bySlug('explore');

    return ShowcasePageTemplate(
      currentRoute: routeName,
      section: section,
      pageTitle: 'Learn And Fun',
      pageSubtitle:
          'Show how Flutter can turn educational content into a playful, premium product surface with sliver storytelling, responsive grids, hover depth, and editorial structure.',
      heroIcon: Icons.lightbulb_outline,
      searchQuery: controller.searchQuery,
      onSearchChanged: controller.setSearch,
      searchHint: 'Search learning topics, docs, and practice areas...',
      metrics: const [
        ShowcaseMetric(value: '42', label: 'Learning lanes'),
        ShowcaseMetric(value: '11', label: 'Knowledge tracks'),
        ShowcaseMetric(value: '93%', label: 'Retention focus'),
      ],
      spotlights: const [
        ShowcaseSpotlight(
          title: 'Playful structure, serious clarity',
          body:
              'Flutter is strong when a page needs to feel interactive and educational at the same time without sacrificing layout discipline.',
          icon: Icons.sports_esports_rounded,
        ),
        ShowcaseSpotlight(
          title: 'One codebase, many learning formats',
          body:
              'Cards, lists, tabs, assessments, motion cues, and content scaffolding can live in one composable UI system.',
          icon: Icons.widgets_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Responsive teaching canvas',
          body:
              'The same page can act like a lesson catalog on desktop and a guided learning feed on smaller screens.',
          icon: Icons.cast_for_education_rounded,
        ),
      ],
      items: section.items,
      timeline: const [
        ShowcaseTimelineEntry(
          label: 'STEP 01',
          title: 'Organize curiosity into tracks',
          body:
              'Exploration works when the page shows structure first, not chaos. Flutter makes those pathways visually obvious.',
        ),
        ShowcaseTimelineEntry(
          label: 'STEP 02',
          title: 'Use motion to guide attention',
          body:
              'Staggered entries and hover states help learners focus on what to open next without shouting at them.',
        ),
        ShowcaseTimelineEntry(
          label: 'STEP 03',
          title: 'Scale from modules to ecosystems',
          body:
              'Because the page is data-driven, the catalog can grow from a few topics into a large learning atlas.',
        ),
      ],
      footerBlocks: [
        const SizedBox(height: 36),
        WMaxWidth(
          child: Row(
            children: const [
              Expanded(
                child: WStatChip(
                  value: 'UX',
                  label: 'Guided discovery',
                  color: WColors.amber,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: WStatChip(
                  value: 'UI',
                  label: 'Adaptive learning cards',
                  color: WColors.teal,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: WStatChip(
                  value: 'DX',
                  label: 'Reusable Flutter widgets',
                  color: WColors.violet,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
