import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/meeting.dart';
import '../services/calendar_service.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final titleController = TextEditingController(text: 'New Meeting');
  final passController = TextEditingController();

  DateTime when = DateTime.now().add(const Duration(hours: 1));
  Duration duration = const Duration(hours: 1);

  bool waiting = true;
  bool muteOnEntry = true;
  bool record = false;
  bool webinar = false;

  @override
  void dispose() {
    titleController.dispose();
    passController.dispose();
    super.dispose();
  }

  String _dateText(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/'
        '${dt.month.toString().padLeft(2, '0')}/'
        '${dt.year}';
  }

  String _timeText(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $ampm';
  }

  Future<void> _pickDateTime() async {
    final d = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: when,
    );

    if (d == null) return;

    final t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(when),
    );

    if (t == null) return;

    setState(() {
      when = DateTime(d.year, d.month, d.day, t.hour, t.minute);
    });
  }

  void _saveMeeting() {
    final m = Meeting(
      id: DateTime.now().millisecondsSinceEpoch.toString().substring(0, 11),
      title: titleController.text.trim(),
      hostUid: 'me',
      startAt: when,
      duration: duration,
      passcode: passController.text.trim().isEmpty
          ? null
          : passController.text.trim(),
      waitingRoom: waiting,
      muteOnEntry: muteOnEntry,
      recordOnStart: record,
      isWebinar: webinar,
    );

    final ics = CalendarService().toIcs(m);

    Get.dialog(
      AlertDialog(
        title: const Text('Meeting Scheduled'),
        content: SizedBox(
          width: 500,
          child: SingleChildScrollView(
            child: SelectableText(
              'Share Link:\n${m.shareLink}\n\n'
              'ICS File:\n\n$ics',
            ),
          ),
        ),
        actions: [FilledButton(onPressed: Get.back, child: const Text('Done'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Meeting'), centerTitle: false),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: _saveMeeting,
          icon: const Icon(Icons.event_available_rounded),
          label: const Text('Save & Generate Invite'),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final desktop = constraints.maxWidth >= 900;
          final tablet = constraints.maxWidth >= 650;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: desktop ? 24 : 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          colors: [cs.primary, cs.primary.withOpacity(.75)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Schedule Meeting',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Create and share your meeting invitation.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    tablet
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 2, child: _meetingSection(cs)),
                              const SizedBox(width: 20),
                              Expanded(child: _optionsSection(cs)),
                            ],
                          )
                        : Column(
                            children: [
                              _meetingSection(cs),
                              const SizedBox(height: 20),
                              _optionsSection(cs),
                            ],
                          ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _meetingSection(ColorScheme cs) {
    return _SectionCard(
      title: 'Meeting Details',
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Meeting Topic',
              prefixIcon: Icon(Icons.video_call_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  icon: Icons.calendar_month_rounded,
                  title: 'Date',
                  value: _dateText(when),
                  onTap: _pickDateTime,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoCard(
                  icon: Icons.schedule_rounded,
                  title: 'Time',
                  value: _timeText(when),
                  onTap: _pickDateTime,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<Duration>(
            value: duration,
            decoration: const InputDecoration(
              labelText: 'Duration',
              prefixIcon: Icon(Icons.timelapse_rounded),
            ),
            items:
                const [
                      Duration(minutes: 30),
                      Duration(hours: 1),
                      Duration(hours: 2),
                      Duration(hours: 3),
                    ]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text('${e.inMinutes} Minutes'),
                      ),
                    )
                    .toList(),
            onChanged: (v) {
              if (v != null) {
                setState(() => duration = v);
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passController,
            decoration: const InputDecoration(
              labelText: 'Passcode',
              prefixIcon: Icon(Icons.lock_outline_rounded),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionsSection(ColorScheme cs) {
    return _SectionCard(
      title: 'Meeting Options',
      child: Column(
        children: [
          _SettingTile(
            icon: Icons.meeting_room_outlined,
            title: 'Waiting Room',
            subtitle: 'Approve participants before joining',
            value: waiting,
            onChanged: (v) => setState(() => waiting = v),
          ),
          _SettingTile(
            icon: Icons.mic_off_outlined,
            title: 'Mute On Entry',
            subtitle: 'Join participants muted',
            value: muteOnEntry,
            onChanged: (v) => setState(() => muteOnEntry = v),
          ),
          _SettingTile(
            icon: Icons.fiber_manual_record_rounded,
            title: 'Auto Recording',
            subtitle: 'Record meeting automatically',
            value: record,
            onChanged: (v) => setState(() => record = v),
          ),
          _SettingTile(
            icon: Icons.live_tv_outlined,
            title: 'Webinar Mode',
            subtitle: 'Broadcast style event',
            value: webinar,
            onChanged: (v) => setState(() => webinar = v),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest.withOpacity(.45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            child,
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 4),
                  Text(value, style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}
