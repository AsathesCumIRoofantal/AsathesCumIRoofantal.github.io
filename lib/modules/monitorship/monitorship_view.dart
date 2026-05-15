import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'monitorship_controller.dart';

class MonitorshipView extends GetView<MonitorshipController> {
  const MonitorshipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Monitorship',
      subtitle:
          'Structure mentor and monitor relationships with clear cadence, shared goals, and honest feedback loops. '
          'AIR keeps both parties accountable and makes progress visible over time.',
      icon: Icons.supervisor_account_outlined,
      items: const [
        SampleContentItem(
          title: 'Monitor Assignments',
          subtitle:
              'Assign monitors to individuals, teams, or processes and define the scope and duration of each engagement. '
              'Clear assignments prevent overlap and ensure every monitored entity has a named point of accountability.',
          icon: Icons.assignment_ind_outlined,
        ),
        SampleContentItem(
          title: 'Check-in Cadence',
          subtitle:
              'Set recurring check-in schedules — weekly, monthly, or milestone-based — and log attendance and outcomes. '
              'Consistent cadence is the single biggest predictor of whether a monitorship relationship delivers results.',
          icon: Icons.event_repeat,
        ),
        SampleContentItem(
          title: 'Goal Tracking',
          subtitle:
              'Define measurable goals for each monitorship period and track progress against them in real time. '
              'Shared goal visibility keeps both monitor and monitored party aligned on what success looks like.',
          icon: Icons.track_changes,
        ),
        SampleContentItem(
          title: 'Feedback Logs',
          subtitle:
              'Record structured feedback after each session — strengths observed, areas for improvement, and agreed next steps. '
              'A searchable feedback history reveals patterns that single sessions cannot surface.',
          icon: Icons.rate_review_outlined,
        ),
        SampleContentItem(
          title: 'Escalation Protocols',
          subtitle:
              'Define what triggers an escalation — missed check-ins, goal regression, or conduct concerns — and who gets notified. '
              'Pre-agreed escalation paths remove ambiguity and speed up intervention when things go off track.',
          icon: Icons.escalator_warning,
        ),
        SampleContentItem(
          title: 'Progress Reports',
          subtitle:
              'Generate periodic summaries of monitorship activity, goal attainment, and outstanding issues for stakeholders. '
              'Structured reports build trust with oversight bodies and create a defensible record of due diligence.',
          icon: Icons.summarize_outlined,
        ),
      ],
    );
  }
}
