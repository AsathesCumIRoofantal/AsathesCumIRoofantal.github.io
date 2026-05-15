import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'communication_controller.dart';

class CommunicationView extends GetView<CommunicationController> {
  const CommunicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Communication',
      subtitle:
          'Keep every exchange intentional — choose the right channel, set the right tone, and maintain a cadence that informs without overwhelming. '
          'AIR surfaces communication patterns so you can spot noise, reduce friction, and ensure the right messages reach the right people at the right time.',
      icon: Icons.forum_rounded,
      items: [
        SampleContentItem(
          title: 'Channel Directory',
          subtitle:
              'Browse all active communication channels available to you — direct messages, group threads, broadcast feeds, and official announcements — each labelled by purpose and audience. '
              'Choosing the right channel from the start prevents message drift and keeps conversations findable long after they happen.',
          icon: Icons.hub_rounded,
        ),
        SampleContentItem(
          title: 'Tone & Cadence Settings',
          subtitle:
              'Configure how often AIR sends you updates, digests, and nudges — and set the preferred tone for outbound messages you draft through the platform. '
              'Intentional cadence means people read what you send; too much noise trains them to ignore everything.',
          icon: Icons.tune_rounded,
        ),
        SampleContentItem(
          title: 'Message Templates',
          subtitle:
              'Access a library of pre-approved message templates for common scenarios — status updates, escalation notices, meeting requests, and acknowledgements. '
              'Templates save time and ensure consistency, so your communication always reflects the standards AIR expects.',
          icon: Icons.description_rounded,
        ),
        SampleContentItem(
          title: 'Broadcast & Announcements',
          subtitle:
              'Compose and send wide-reach announcements to your network, team, or the broader AIR community — with delivery confirmation and read-receipt tracking. '
              'Broadcasts are logged and archived so recipients can always find the original message, even weeks later.',
          icon: Icons.campaign_rounded,
        ),
        SampleContentItem(
          title: 'Communication Log',
          subtitle:
              'Review a timestamped history of all messages sent and received through AIR — searchable by sender, channel, date, or keyword. '
              'The log is your accountability trail: it shows what was communicated, when, and to whom, removing ambiguity from any dispute.',
          icon: Icons.history_rounded,
        ),
        SampleContentItem(
          title: 'Noise Filter & Mute Rules',
          subtitle:
              'Set rules to mute low-priority channels during focus hours, filter out automated notifications, and surface only the messages that require your attention. '
              'Reducing noise is not about missing things — it is about protecting the cognitive space needed to respond well to what matters.',
          icon: Icons.do_not_disturb_on_rounded,
        ),
        SampleContentItem(
          title: 'Response Commitments',
          subtitle:
              'Track messages that require a reply and set personal response-time commitments so nothing falls through the cracks. '
              'AIR reminds you of pending responses and flags overdue replies, keeping your communication reputation intact.',
          icon: Icons.mark_chat_unread_rounded,
        ),
      ],
    );
  }
}
