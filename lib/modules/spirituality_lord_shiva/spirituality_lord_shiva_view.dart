import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'spirituality_lord_shiva_controller.dart';

class SpiritualityLordShivaView
    extends GetView<SpiritualityLordShivaController> {
  const SpiritualityLordShivaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Spirituality — Lord Shiva',
      subtitle:
          'Explore devotional content, sacred texts, and educational resources centred on Lord Shiva. '
          'Deepen your understanding of Shaivite philosophy, rituals, and the timeless wisdom of the Mahadeva.',
      icon: Icons.temple_hindu,
      items: const [
        SampleContentItem(
          title: 'Shiva Stotras & Mantras',
          subtitle:
              'Access a curated collection of sacred stotras, mantras, and shlokas dedicated to Lord Shiva. '
              'Each mantra includes transliteration, translation, and guidance on the appropriate time for recitation.',
          icon: Icons.music_note,
        ),
        SampleContentItem(
          title: 'Symbolism of Shiva',
          subtitle:
              'Understand the deep spiritual symbolism behind the Trishul, Damaru, Crescent Moon, and Third Eye. '
              'Each symbol carries profound philosophical meaning that illuminates the nature of consciousness.',
          icon: Icons.auto_awesome,
        ),
        SampleContentItem(
          title: 'Sacred Texts',
          subtitle:
              'Read excerpts from the Shiva Purana, Linga Purana, and other canonical Shaivite scriptures. '
              'Texts are presented with commentary to make ancient wisdom accessible to modern readers.',
          icon: Icons.menu_book,
        ),
        SampleContentItem(
          title: 'Festivals & Observances',
          subtitle:
              'Follow the calendar of major Shiva festivals including Maha Shivaratri, Pradosh Vrat, and Shravan Somvar. '
              'Each festival entry explains its significance, rituals, and the spiritual benefits of observance.',
          icon: Icons.celebration,
        ),
        SampleContentItem(
          title: 'Pilgrimage Sites',
          subtitle:
              'Explore the twelve Jyotirlinga shrines and other sacred sites associated with Lord Shiva. '
              'Each site profile includes history, significance, and practical pilgrimage guidance.',
          icon: Icons.place,
        ),
        SampleContentItem(
          title: 'Meditation & Dhyana',
          subtitle:
              'Practise guided meditations inspired by Shiva\'s aspect as Adiyogi, the first yogi. '
              'Dhyana sessions focus on stillness, inner awareness, and the dissolution of ego.',
          icon: Icons.self_improvement,
        ),
        SampleContentItem(
          title: 'Devotional Stories',
          subtitle:
              'Read and reflect on stories from the Puranas that reveal Lord Shiva\'s grace, power, and compassion. '
              'Stories are presented in accessible language suitable for all ages and levels of familiarity.',
          icon: Icons.auto_stories,
        ),
      ],
    );
  }
}
