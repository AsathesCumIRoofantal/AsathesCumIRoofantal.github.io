import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'family_controller.dart';

class FamilyView extends GetView<FamilyController> {
  const FamilyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Family',
      subtitle: 'Explore placeholder content for Family in AIR.',
      icon: Icons.article_outlined,
      items: const [
        SampleContentItem(
          title: 'Overview',
          subtitle: 'Learn about how Family works inside AIR.',
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
