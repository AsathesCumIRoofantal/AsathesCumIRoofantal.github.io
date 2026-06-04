import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'media_news_controller.dart';

class MediaNewsView extends GetView<MediaNewsController> {
  final bool isEmbedded;
  const MediaNewsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Media & News',
      subtitle:
          'Curate a healthy media diet with trusted sources, fact-check workflows, and headline triage that cuts through noise. '
          'AIR helps you stay informed without being overwhelmed or manipulated by the information environment.',
      icon: Icons.newspaper,
      items: const [
        SampleContentItem(
          title: 'Trusted Source Registry',
          subtitle:
              'Maintain a vetted list of news sources rated by accuracy, independence, and domain expertise. '
              'A personal source registry prevents you from accidentally treating low-quality outlets as authoritative.',
          icon: Icons.verified_outlined,
        ),
        SampleContentItem(
          title: 'Headline Triage',
          subtitle:
              'Apply a quick triage filter to incoming headlines — signal vs. noise, urgent vs. background, fact vs. opinion. '
              'Triage discipline prevents the cognitive overload that comes from treating every headline as equally important.',
          icon: Icons.filter_list,
        ),
        SampleContentItem(
          title: 'Fact-Check Workflow',
          subtitle:
              'Run a structured fact-check on claims before sharing or acting on them — source, corroboration, and context. '
              'A consistent fact-check habit protects your credibility and reduces the spread of misinformation.',
          icon: Icons.fact_check_outlined,
        ),
        SampleContentItem(
          title: 'Bias Awareness Log',
          subtitle:
              'Track the ideological and commercial biases of your regular sources and how they frame the same events differently. '
              'Bias awareness does not mean avoiding all biased sources — it means knowing what lens you are looking through.',
          icon: Icons.visibility_outlined,
        ),
        SampleContentItem(
          title: 'Story Tracker',
          subtitle:
              'Follow developing stories over time, logging how the narrative evolves and which early claims were later corrected. '
              'Tracking stories longitudinally reveals which outlets update their reporting honestly and which do not.',
          icon: Icons.bookmark_border,
        ),
        SampleContentItem(
          title: 'Media Diet Review',
          subtitle:
              'Periodically audit your overall media consumption — diversity of sources, time spent, and emotional impact. '
              'A media diet review helps you stay informed without letting the news cycle dominate your attention and mood.',
          icon: Icons.pie_chart_outline,
        ),
        SampleContentItem(
          title: 'Disinformation Alerts',
          subtitle:
              'Flag and document disinformation campaigns, coordinated narratives, and known propaganda techniques as you encounter them. '
              'Building a personal disinformation log sharpens your pattern recognition and helps you warn others.',
          icon: Icons.report_gmailerrorred_outlined,
        ),
      ],
    );
  }
}



