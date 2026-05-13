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
      subtitle: 'Bilingual counting reports in Hindi & English for AIR.',
      icon: Icons.read_more,
      items: const [
        SampleContentItem(
          title: 'Search Any Topic to Find Related Reports',
          subtitle: 'Access any reports.',
          icon: Icons.search,
        ),
        SampleContentItem(
          title: 'Hindi Reports',
          subtitle: 'Access counting reports in Hindi language.',
          icon: Icons.language,
        ),
        SampleContentItem(
          title: 'English Reports',
          subtitle: 'Access counting reports in English language.',
          icon: Icons.translate,
        ),
        SampleContentItem(
          title: 'Bilingual View',
          subtitle: 'View reports side-by-side in both languages.',
          icon: Icons.view_agenda,
        ),
      ],
    );
  }
}
