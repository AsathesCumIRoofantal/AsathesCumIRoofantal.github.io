import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_showcase_page_template.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import 'web_share_experience_controller.dart';

class WebShareExperienceView extends GetView<WebShareExperienceController> {
  const WebShareExperienceView({super.key});

  static const String routeName = '/web-be-you/share-experience';

  @override
  Widget build(BuildContext context) {
    final section = WebNavData.bySlug('be_you');

    return ShowcasePageTemplate(
      currentRoute: routeName,
      section: section,
      pageTitle: 'Share Experience',
      pageSubtitle:
          'Build a personal publishing surface where stories, lessons, and social proof feel expressive but still structured enough to scale inside AIR.',
      heroIcon: Icons.share_rounded,
      metrics: const [
        ShowcaseMetric(value: '64', label: 'Voices captured'),
        ShowcaseMetric(value: '18', label: 'Story threads'),
        ShowcaseMetric(value: '7', label: 'Community prompts'),
      ],
      spotlights: const [
        ShowcaseSpotlight(
          title: 'Identity-led design',
          body:
              'This section shows how Flutter can support emotionally warmer product surfaces without losing consistency.',
          icon: Icons.favorite_border_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Story cards with social signals',
          body:
              'Experience-sharing pages benefit from rich cards, author cues, reactions, and safe empty-state handling.',
          icon: Icons.forum_rounded,
        ),
        ShowcaseSpotlight(
          title: 'Motion that supports expression',
          body:
              'Subtle transitions make the page feel alive while keeping authored content as the main event.',
          icon: Icons.motion_photos_on_rounded,
        ),
      ],
      items: section.items,
      timeline: const [
        ShowcaseTimelineEntry(
          label: 'STAGE 01',
          title: 'Invite contribution',
          body:
              'The interface should make expression feel welcome before asking for structure, tags, or metadata.',
        ),
        ShowcaseTimelineEntry(
          label: 'STAGE 02',
          title: 'Curate what gets shared',
          body:
              'A good AIR page needs moderation posture, story clarity, and visible topic boundaries.',
        ),
        ShowcaseTimelineEntry(
          label: 'STAGE 03',
          title: 'Convert stories into reusable knowledge',
          body:
              'Personal narratives become more useful when they can later feed wisdom, onboarding, and community pages.',
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
                TextField(
                  maxLines: 3,
                  minLines: 1,
                  onChanged: controller.updatePostText,
                  decoration: InputDecoration(
                    hintText: 'Prototype a lived-experience post for this showcase...',
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.55),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Obx(
                  () => Text(
                    controller.postText.value.isEmpty
                        ? 'No draft yet. This block shows how interactive authored input can live inside the same sliver narrative.'
                        : 'Draft preview length: ${controller.postText.value.length} characters.',
                    style: TextStyle(
                      color: section.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
