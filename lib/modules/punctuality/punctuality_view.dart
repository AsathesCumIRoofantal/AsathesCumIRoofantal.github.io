import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'punctuality_controller.dart';

class PunctualityView extends GetView<PunctualityController> {
  const PunctualityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Punctuality',
      subtitle:
          'Punctuality in AIR is time integrity — the practice of treating your commitments to others\' time as seriously as you treat your own. Being on time is a form of respect made visible.',
      icon: Icons.schedule_outlined,
      items: const [
        SampleContentItem(
          title: 'Time SLAs',
          subtitle:
              'Define your personal service-level agreements for time — how early you arrive for meetings, how quickly you respond to messages, how long tasks should take. Written SLAs make accountability concrete.',
          icon: Icons.timer_outlined,
        ),
        SampleContentItem(
          title: 'Buffer Planning',
          subtitle:
              'Chronic lateness is usually a planning failure, not a character flaw. Build transition buffers between commitments — 10 minutes minimum — and log how often you actually use them.',
          icon: Icons.hourglass_bottom_outlined,
        ),
        SampleContentItem(
          title: 'Respect for Others\' Time',
          subtitle:
              'Every minute someone waits for you is a minute they didn\'t choose to give. Track your on-time rate for meetings and appointments and treat it as a metric worth improving.',
          icon: Icons.people_outline,
        ),
        SampleContentItem(
          title: 'Deadline Integrity',
          subtitle:
              'A deadline is a promise. Log every deadline you commit to and your actual delivery date. The gap between the two is your integrity score — review it monthly and close it deliberately.',
          icon: Icons.event_available_outlined,
        ),
        SampleContentItem(
          title: 'Early Warning System',
          subtitle:
              'When you know you\'re going to be late or miss a deadline, communicate early — not at the last minute. Log how often you give advance notice versus scrambling at the deadline.',
          icon: Icons.notifications_active_outlined,
        ),
        SampleContentItem(
          title: 'Time Audit',
          subtitle:
              'Where your time actually goes versus where you think it goes are rarely the same. Run a weekly time audit — log your actual hours against your intended schedule and identify the biggest gaps.',
          icon: Icons.bar_chart_outlined,
        ),
        SampleContentItem(
          title: 'Clock Discipline',
          subtitle:
              'Set your clocks and reminders to work for you, not against you. Review your alarm and reminder system quarterly to ensure it\'s still calibrated to your current schedule and commitments.',
          icon: Icons.alarm_outlined,
        ),
      ],
    );
  }
}
