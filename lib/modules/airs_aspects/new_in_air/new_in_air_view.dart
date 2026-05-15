import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'new_in_air_controller.dart';

class NewInAirView extends GetView<NewInAirController> {
  const NewInAirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'New in AIR',
      subtitle:
          'Stay current with the latest releases, feature additions, and capability upgrades — skim what changed recently and decide what to explore first. '
          'Release notes are written for humans, not engineers: plain language, clear impact, and a direct link to try each new thing.',
      icon: Icons.new_releases_rounded,
      items: [
        SampleContentItem(
          title: 'Latest Release Highlights',
          subtitle:
              'Read a plain-language summary of the most recent AIR release — what changed, what improved, and what was removed and why. '
              'Highlights are curated to surface the changes most likely to affect your daily use, not every technical detail.',
          icon: Icons.star_rounded,
        ),
        SampleContentItem(
          title: 'Feature Spotlight',
          subtitle:
              'Dive deep into one newly released feature each cycle — with a walkthrough, use cases, and tips for getting the most out of it immediately. '
              'Spotlights are designed to take under five minutes and leave you ready to use the feature confidently.',
          icon: Icons.tips_and_updates_rounded,
        ),
        SampleContentItem(
          title: 'Changelog Browser',
          subtitle:
              'Browse the full, searchable changelog to find specific changes, track the evolution of a feature, or verify when a bug was fixed. '
              'The changelog is the authoritative record of every change made to AIR — complete, timestamped, and permanently accessible.',
          icon: Icons.history_rounded,
        ),
        SampleContentItem(
          title: 'Upcoming Preview',
          subtitle:
              'Get an early look at features currently in development — what is coming, when it is expected, and how to join the beta if one is available. '
              'Previews are shared to invite community feedback before features are finalised, not to generate hype.',
          icon: Icons.preview_rounded,
        ),
        SampleContentItem(
          title: 'Deprecation Notices',
          subtitle:
              'Stay informed about features and workflows that are being retired — with clear timelines, migration paths, and the reasoning behind each decision. '
              'Deprecation notices are published well in advance so you have time to adapt without disruption.',
          icon: Icons.warning_amber_rounded,
        ),
        SampleContentItem(
          title: 'Community Feedback Loop',
          subtitle:
              'React to new features, report issues, and suggest improvements directly from the release notes — closing the loop between what AIR ships and what the community needs. '
              'Feedback submitted here is reviewed by the product team and influences the next release cycle.',
          icon: Icons.feedback_rounded,
        ),
      ],
    );
  }
}
