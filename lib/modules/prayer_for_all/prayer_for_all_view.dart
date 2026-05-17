import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'prayer_for_all_controller.dart';

class PrayerForAllView extends GetView<PrayerForAllController> {
  final bool isEmbedded;
  const PrayerForAllView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Prayer for All',
      subtitle:
          'Offer inclusive prayer intentions for peace, healing, and the collective good of all beings. '
          'This space transcends tradition — every sincere heart is welcome here.',
      icon: Icons.diversity_3,
      items: const [
        SampleContentItem(
          title: 'Prayers for Peace',
          subtitle:
              'Offer intentions for peace at every level — within oneself, in families, communities, and nations. '
              'Peace prayers draw from diverse traditions and are expressed in universal, inclusive language.',
          icon: Icons.volunteer_activism_rounded,
        ),
        SampleContentItem(
          title: 'Healing Intentions',
          subtitle:
              'Submit or browse healing prayers for those who are ill, grieving, or in need of restoration. '
              'Healing intentions are held collectively by the community and renewed each day.',
          icon: Icons.healing,
        ),
        SampleContentItem(
          title: 'Gratitude Offerings',
          subtitle:
              'Express gratitude for blessings received and share those moments of thankfulness with others. '
              'A daily gratitude practice cultivates resilience and shifts focus toward abundance.',
          icon: Icons.favorite_border,
        ),
        SampleContentItem(
          title: 'Prayers for the Departed',
          subtitle:
              'Honour those who have passed with respectful prayers and remembrance entries. '
              'Remembrance records can be kept private or shared with the community as a collective tribute.',
          icon: Icons.local_florist,
        ),
        SampleContentItem(
          title: 'Community Prayer Wall',
          subtitle:
              'Post a prayer intention to the shared community wall and invite others to join in solidarity. '
              'The prayer wall is moderated to ensure a safe, respectful, and uplifting space for all.',
          icon: Icons.people,
        ),
        SampleContentItem(
          title: 'Guided Contemplation',
          subtitle:
              'Follow short guided contemplation sessions designed to centre the mind and open the heart. '
              'Sessions are drawn from multiple spiritual traditions and require no prior experience.',
          icon: Icons.self_improvement,
        ),
        SampleContentItem(
          title: 'Collective Intentions',
          subtitle:
              'Join scheduled collective prayer moments where the entire community focuses on a shared intention. '
              'Collective intentions are announced in advance and archived so latecomers can still participate.',
          icon: Icons.groups,
        ),
      ],
    );
  }
}



