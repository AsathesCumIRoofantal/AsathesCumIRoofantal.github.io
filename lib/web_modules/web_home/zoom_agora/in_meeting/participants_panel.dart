import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/participant.dart';
import '../widgets/zoom_theme.dart';
import '../mock/mock_data.dart';
import 'zoom_meeting_controller.dart';

/// Search-enabled participants list with waiting-room banner and host actions.
class ParticipantsPanel extends GetView<ZoomMeetingController> {
  const ParticipantsPanel({super.key});

  @override
  Widget build(BuildContext c) {
    final query = ''.obs;

    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: ZoomTheme.stroke))),
        child: Row(children: [
          Text('Participants', style: ZoomTheme.h3),
          const SizedBox(width: 8),
          Obx(() => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: ZoomTheme.surface2, borderRadius: BorderRadius.circular(20)),
            child: Text('${controller.participants.length}',
              style: const TextStyle(color: ZoomTheme.textMuted, fontSize: 11, fontWeight: FontWeight.w600)),
          )),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_add_alt, color: ZoomTheme.textMuted, size: 18)),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
        child: TextField(
          onChanged: (v) => query.value = v.toLowerCase(),
          style: const TextStyle(color: ZoomTheme.text),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, size: 18, color: ZoomTheme.textMuted),
            hintText: 'Search…',
            hintStyle: const TextStyle(color: ZoomTheme.textMuted),
            filled: true, fillColor: ZoomTheme.surface2,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            isDense: true,
          ),
        ),
      ),
      // Waiting room
      Obx(() => controller.waiting.isEmpty
        ? const SizedBox.shrink()
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ZoomTheme.warn.withOpacity(.10),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ZoomTheme.warn.withOpacity(.4)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(Icons.meeting_room, color: ZoomTheme.warn, size: 16),
                const SizedBox(width: 6),
                Text('Waiting room (${controller.waiting.length})',
                  style: const TextStyle(color: ZoomTheme.warn, fontWeight: FontWeight.w700, fontSize: 12)),
                const Spacer(),
                TextButton(onPressed: () { for (final p in [...controller.waiting]) controller.admit(p.uid); },
                  child: const Text('Admit all', style: TextStyle(color: ZoomTheme.warn))),
              ]),
              ...controller.waiting.map((p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(children: [
                  InitialsAvatar(name: p.name, colorHex: MockMeetingSim.colorFor(p.uid), size: 28),
                  const SizedBox(width: 10),
                  Expanded(child: Text(p.name, style: ZoomTheme.body, overflow: TextOverflow.ellipsis)),
                  TextButton(onPressed: () => controller.admit(p.uid), child: const Text('Admit')),
                  TextButton(onPressed: () => controller.waiting.remove(p),
                    child: const Text('Deny', style: TextStyle(color: ZoomTheme.danger))),
                ]),
              )),
            ]),
          )),
      Expanded(child: Obx(() {
        final q = query.value;
        final list = controller.participants.values
          .where((p) => q.isEmpty || p.name.toLowerCase().contains(q)).toList()
          ..sort((a, b) => a.role.index.compareTo(b.role.index));
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) => _Row(p: list[i]),
        );
      })),
      Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: ZoomTheme.stroke))),
        child: Row(children: [
          Expanded(child: OutlinedButton.icon(
            onPressed: controller.muteAll,
            icon: const Icon(Icons.mic_off, size: 16),
            label: const Text('Mute all'),
            style: OutlinedButton.styleFrom(
              foregroundColor: ZoomTheme.text,
              side: const BorderSide(color: ZoomTheme.stroke),
            ),
          )),
          const SizedBox(width: 8),
          Obx(() => Expanded(child: OutlinedButton.icon(
            onPressed: () => controller.lockMeeting(!controller.isLocked.value),
            icon: Icon(controller.isLocked.value ? Icons.lock : Icons.lock_open, size: 16),
            label: Text(controller.isLocked.value ? 'Unlock' : 'Lock'),
            style: OutlinedButton.styleFrom(
              foregroundColor: ZoomTheme.text,
              side: const BorderSide(color: ZoomTheme.stroke),
            ),
          ))),
        ]),
      ),
    ]);
  }
}

class _Row extends GetView<ZoomMeetingController> {
  const _Row({required this.p});
  final Participant p;
  @override
  Widget build(BuildContext c) {
    final color = MockMeetingSim.colorFor(p.uid);
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(children: [
          Stack(children: [
            InitialsAvatar(name: p.name, colorHex: color, size: 36),
            if (p.isSpeaking)
              Positioned(right: -2, bottom: -2,
                child: Container(width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: ZoomTheme.success, shape: BoxShape.circle,
                    border: Border.all(color: ZoomTheme.surface, width: 2),
                  ))),
          ]),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Flexible(child: Text(p.name,
                overflow: TextOverflow.ellipsis,
                style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600))),
              if (p.role != ParticipantRole.attendee) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(color: ZoomTheme.primary.withOpacity(.18), borderRadius: BorderRadius.circular(6)),
                  child: Text(_roleLabel(p.role),
                    style: const TextStyle(color: ZoomTheme.primary, fontSize: 10, fontWeight: FontWeight.w700)),
                ),
              ],
            ]),
            const SizedBox(height: 2),
            Text(p.audioMuted ? 'Muted' : (p.isSpeaking ? 'Speaking' : 'Listening'),
              style: ZoomTheme.muted.copyWith(fontSize: 11)),
          ])),
          if (p.handRaised) const Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: Text('✋', style: TextStyle(fontSize: 16))),
          Icon(p.audioMuted ? Icons.mic_off : Icons.mic,
            size: 16, color: p.audioMuted ? ZoomTheme.danger : ZoomTheme.success),
          const SizedBox(width: 6),
          Icon(p.videoOff ? Icons.videocam_off : Icons.videocam,
            size: 16, color: p.videoOff ? ZoomTheme.danger : ZoomTheme.textMuted),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: ZoomTheme.textMuted, size: 18),
            color: ZoomTheme.surface2,
            onSelected: (v) {
              switch (v) {
                case 'pin':  controller.togglePin(p.uid); break;
                case 'spot': controller.toggleSpotlight(p.uid); break;
                case 'co':   controller.makeCoHost(p.uid); break;
                case 'host': controller.transferHost(p.uid); break;
                case 'kick': controller.removeParticipant(p.uid); break;
                case 'reqctrl':
                  controller.remoteControl?.requestControl(p.uid, controller.localUid);
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'pin',  child: Text('Pin',                style: TextStyle(color: Colors.white))),
              const PopupMenuItem(value: 'spot', child: Text('Spotlight for all',  style: TextStyle(color: Colors.white))),
              if (p.isScreenSharing && p.uid != controller.localUid)
                const PopupMenuItem(value: 'reqctrl', child: Text('Request control of screen', style: TextStyle(color: Colors.white))),
              const PopupMenuItem(value: 'co',   child: Text('Make co-host',       style: TextStyle(color: Colors.white))),
              const PopupMenuItem(value: 'host', child: Text('Make host',          style: TextStyle(color: Colors.white))),
              const PopupMenuItem(value: 'kick', child: Text('Remove from meeting',style: TextStyle(color: Color(0xFFFF5C7A)))),
            ],
          ),
        ]),
      ),
    );
  }
  String _roleLabel(ParticipantRole r) => switch (r) {
    ParticipantRole.host     => 'HOST',
    ParticipantRole.coHost   => 'CO-HOST',
    ParticipantRole.panelist => 'PANEL',
    ParticipantRole.attendee => '',
  };
}
