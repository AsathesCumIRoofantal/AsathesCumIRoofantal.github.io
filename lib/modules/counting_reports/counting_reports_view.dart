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
          title: 'Hindi Counting',
          subtitle: 'Access counting meanings.',
          icon: Icons.language,
        ),
        SampleContentItem(
          title: 'English Counting',
          subtitle: 'Access counting meanings.',
          icon: Icons.translate,
        ),
        SampleContentItem(
          title: 'Localised View',
          subtitle: 'View reports side-by-side in any languages.',
          icon: Icons.language,
        ),
      ],
    );
  }
}
