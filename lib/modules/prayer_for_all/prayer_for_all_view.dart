import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'prayer_for_all_controller.dart';

class PrayerForAllView extends GetView<PrayerForAllController> {
  const PrayerForAllView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Prayer For All',
      subtitle: 'Explore placeholder content for Prayer For All in AIR.',
      icon: Icons.article_outlined,
      items: const [
        SampleContentItem(
          title: 'Overview',
          subtitle: 'Learn about how Prayer For All works inside AIR.',
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
