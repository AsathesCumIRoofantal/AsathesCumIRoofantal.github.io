import 'package:air_app/modules/keep_adding_with_patience/keep_adding_with_patiencecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';

class KeepAddingWithPatienceView
    extends GetView<KeepAddingWithPatienceController> {
  const KeepAddingWithPatienceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Keep Adding With Patience',
      subtitle:
          'Explore placeholder content for Keep Adding With Patience in AIR.',
      icon: Icons.article_outlined,
      items: const [
        SampleContentItem(
          title: 'Overview',
          subtitle:
              'Learn about how Keep Adding With Patience works inside AIR.',
          icon: Icons.info_outline,
        ),
        SampleContentItem(
          title: 'Experience',
          subtitle: 'Browse the sample concepts and usage examples.',
          icon: Icons.auto_stories_outlined,
        ),
        SampleContentItem(
          title: 'Action',
          subtitle: 'Add your first entry or expand this module later.',
          icon: Icons.play_circle_outline,
        ),
      ],
    );
  }
}
