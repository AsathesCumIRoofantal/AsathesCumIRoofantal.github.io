import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'counting_reports_controller.dart';

class CountingReportsView extends GetView<CountingReportsController> {
  const CountingReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Counting Reports',
      subtitle:
          'Generate and review bilingual counting reports that flow naturally in both Hindi and English. '
          'Maintain a consistent reporting rhythm so numbers, totals, and summaries are always clear across languages.',
      icon: Icons.calculate_outlined,
      items: const [
        SampleContentItem(
          title: 'Hindi Counting Reference',
          subtitle:
              'Browse the complete Hindi numeral system from ek to crore with pronunciation guides. '
              'Each entry includes the Devanagari script, transliteration, and common usage context so reports read authentically.',
          icon: Icons.language_outlined,
        ),
        SampleContentItem(
          title: 'English Counting Reference',
          subtitle:
              'Access structured English number formats — units, thousands, lakhs, millions, and beyond. '
              'Includes formatting rules for Indian English conventions like lakh and crore alongside international standards.',
          icon: Icons.translate_outlined,
        ),
        SampleContentItem(
          title: 'Bilingual Report Builder',
          subtitle:
              'Compose reports that display figures side-by-side in Hindi and English with a single input. '
              'Auto-converts numeric values to the correct word form in both languages, reducing manual translation errors.',
          icon: Icons.description_outlined,
        ),
        SampleContentItem(
          title: 'Topic-Based Report Search',
          subtitle:
              'Search across all counting reports by topic, date range, or language to find exactly what you need. '
              'Filters surface relevant summaries instantly so you spend less time hunting and more time acting on data.',
          icon: Icons.search_outlined,
        ),
        SampleContentItem(
          title: 'Reporting Rhythm Scheduler',
          subtitle:
              'Set a recurring cadence — daily, weekly, or monthly — for automatic report generation and delivery. '
              'Consistent rhythm means stakeholders always have fresh numbers without manual reminders.',
          icon: Icons.schedule_outlined,
        ),
        SampleContentItem(
          title: 'Localised Side-by-Side View',
          subtitle:
              'View any report in a split-screen layout with Hindi on one side and English on the other. '
              'Ideal for presentations and reviews where mixed-language audiences need to follow along simultaneously.',
          icon: Icons.compare_outlined,
        ),
        SampleContentItem(
          title: 'Export & Share',
          subtitle:
              'Export bilingual reports as PDF, CSV, or shareable links with formatting preserved in both scripts. '
              'Share directly to WhatsApp, email, or AIR channels so the right people get the right numbers fast.',
          icon: Icons.share_outlined,
        ),
      ],
    );
  }
}
