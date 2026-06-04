import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'universal_peace_rule_controller.dart';

class UniversalPeaceRuleView extends GetView<UniversalPeaceRuleController> {
  final bool isEmbedded;
  const UniversalPeaceRuleView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Universal Peace Rule',
      subtitle:
          'Articulate and apply norms that aspire toward universal peace without naively erasing real differences or power imbalances. '
          'AIR helps you hold the tension between principled ideals and honest ground-level realities.',
      icon: Icons.balance,
      items: const [
        SampleContentItem(
          title: 'Core Peace Norms',
          subtitle:
              'Document the foundational norms your community or organisation commits to — non-violence, dignity, and good-faith dialogue. '
              'Written norms create a shared reference point that makes it harder to rationalise violations in the heat of conflict.',
          icon: Icons.menu_book_outlined,
        ),
        SampleContentItem(
          title: 'Norm Application Log',
          subtitle:
              'Record instances where peace norms were invoked, tested, or violated and how each situation was handled. '
              'A log of real applications reveals whether norms are genuinely guiding behaviour or merely decorating walls.',
          icon: Icons.history_edu_outlined,
        ),
        SampleContentItem(
          title: 'Power Imbalance Audit',
          subtitle:
              'Honestly assess the power differentials between parties before applying universal norms to a specific situation. '
              'Norms applied without accounting for power imbalances can inadvertently protect the powerful and harm the vulnerable.',
          icon: Icons.scale_outlined,
        ),
        SampleContentItem(
          title: 'Conflict Transformation',
          subtitle:
              'Track active conflicts and the steps being taken to transform them from destructive to constructive engagement. '
              'Transformation — not just resolution — addresses root causes and builds relationships that can survive future disagreements.',
          icon: Icons.transform,
        ),
        SampleContentItem(
          title: 'Cultural Norm Mapping',
          subtitle:
              'Document how universal peace principles are interpreted and expressed across different cultural contexts. '
              'Respecting cultural variation in expression while holding firm on core principles is the art of universal peacebuilding.',
          icon: Icons.language,
        ),
        SampleContentItem(
          title: 'Accountability Mechanisms',
          subtitle:
              'Define how violations of peace norms are acknowledged, addressed, and repaired within your community. '
              'Without accountability, norms are aspirational fiction; with it, they become the actual rules of the game.',
          icon: Icons.gavel,
        ),
        SampleContentItem(
          title: 'Peace Education',
          subtitle:
              'Track educational initiatives that build the skills and dispositions needed for peaceful coexistence. '
              'Long-term peace is built in classrooms, community halls, and family conversations — not only in negotiation rooms.',
          icon: Icons.school_outlined,
        ),
      ],
    );
  }
}



