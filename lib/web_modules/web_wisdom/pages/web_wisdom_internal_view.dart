import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_showcase_page_template.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import 'web_wisdom_internal_controller.dart';

class WebWisdomInternalView extends GetView<WebWisdomInternalController> {
  const WebWisdomInternalView({super.key});

  static const String routeName = '/web-wisdom/wisdom';

  @override
  Widget build(BuildContext context) {
    final section = WebNavData.bySlug('wisdom');

    return ShowcasePageTemplate(
      currentRoute: routeName,
      section: section,
      pageTitle: 'Wisdom Internal',
      pageSubtitle:
          'Present reflective content with cinematic hierarchy, calmer motion, and structured reading blocks so Flutter feels mature, not merely flashy.',
      heroIcon: Icons.menu_book_rounded,
      metrics: const [
        ShowcaseMetric(value: '3', label: 'Guiding chapters'),
        ShowcaseMetric(value: '12', label: 'Reflection prompts'),
        ShowcaseMetric(value: '1', label: 'Unified reading flow'),
      ],
      spotlights: const [
        ShowcaseSpotlight(
          title: 'Quiet motion, strong hierarchy',
          body:
              'Flutter is not only for energetic dashboards. It also handles contemplative reading experiences with restraint and depth.',
          icon: Icons.self_improvement_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Editorial composition',
          body:
              'Large type, measured spacing, and progressive sections help long-form thought feel deliberate rather than dense.',
          icon: Icons.chrome_reader_mode_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Shared system, distinct mood',
          body:
              'The same reusable Flutter architecture can still produce a very different emotional tone for Wisdom than for Explore or Service.',
          icon: Icons.palette_outlined,
        ),
      ],
      items: section.items,
      timeline: const [
        ShowcaseTimelineEntry(
          label: 'CHAPTER 01',
          title: 'Anchor readers with a premise',
          body:
              'A strong hero and top-level framing text tell the reader what kind of reflection space they are entering.',
        ),
        ShowcaseTimelineEntry(
          label: 'CHAPTER 02',
          title: 'Let sections breathe',
          body:
              'Spacing, tone, and motion should slow cognition down just enough for deeper reading.',
        ),
        ShowcaseTimelineEntry(
          label: 'CHAPTER 03',
          title: 'Turn philosophy into navigation',
          body:
              'Even abstract content becomes more useful when organized into visible, reusable themes and prompts.',
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
            ),
            child: Obx(
              () => Text(
                'Reading progress state can still be preserved through GetX: chapter ${controller.currentPage.value + 1} is currently highlighted as the active reflection layer.',
                style: const TextStyle(height: 1.65),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
