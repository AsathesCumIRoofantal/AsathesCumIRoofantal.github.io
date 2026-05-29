// ============================================================
//  AIR App – Meeting Room View  (Zoom-inspired in-call UI)
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/meeting_room_controller.dart';
import '../../../models/meeting_model.dart';
import '../../../../core/responsive/responsive_helper.dart';

class MeetingRoomView extends StatelessWidget {
  final MeetingModel meeting;
  const MeetingRoomView({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    final ctrl  = Get.put(MeetingRoomController(meeting: meeting));
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1117),
      body: Obx(() {
        if (ctrl.isWaiting.value) return _buildWaitingRoom(ctrl, theme);
        return _buildMeetingRoom(context, ctrl, theme);
      }),
    );
  }

  // ── Waiting Room ─────────────────────────────────────
  Widget _buildWaitingRoom(MeetingRoomController ctrl, ThemeData theme) => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 200.w, height: 150.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade900, borderRadius: BorderRadius.circular(16.r)),
        child: Center(child: Icon(Icons.videocam_off_rounded,
            size: 40.r, color: Colors.grey)),
      ),
      SizedBox(height: 24.h),
      Text(meeting.title,
          style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
      SizedBox(height: 8.h),
      Text('Joining…',
          style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
      SizedBox(height: 24.h),
      const CircularProgressIndicator(color: Colors.white),
    ]),
  );

  // ── In-Meeting Room ───────────────────────────────────
  Widget _buildMeetingRoom(BuildContext ctx, MeetingRoomController ctrl, ThemeData theme) {
    return Stack(
      children: [
        // ── Participant grid ─────────────────────────────
        Positioned.fill(child: _ParticipantGrid(ctrl: ctrl)),

        // ── Side panels (desktop) ────────────────────────
        if (Responsive.isDesktop(ctx))
          Positioned(
            top: 0, right: 0, bottom: 0, width: 300.w,
            child: Obx(() {
              if (ctrl.isChatOpen.value) return _ChatSidePanel(ctrl: ctrl);
              if (ctrl.isParticipantPanelOpen.value) return _ParticipantSidePanel(ctrl: ctrl);
              return const SizedBox.shrink();
            }),
          ),

        // ── Top bar ──────────────────────────────────────
        Positioned(
          top: 0, left: 0, right: 0,
          child: _MeetingTopBar(ctrl: ctrl, meeting: meeting),
        ),

        // ── Bottom controls ──────────────────────────────
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: _MeetingControls(ctrl: ctrl, ctx: ctx),
        ),
      ],
    );
  }
}

// ── Participant Grid ─────────────────────────────────────
class _ParticipantGrid extends StatelessWidget {
  final MeetingRoomController ctrl;
  const _ParticipantGrid({required this.ctrl});

  @override
  Widget build(BuildContext context) => Obx(() {
    final parts = ctrl.participants;
    if (parts.isEmpty) {
      return Container(
        color: const Color(0xFF1A1D27),
        child: Center(child: Text('Waiting for others…',
            style: TextStyle(color: Colors.grey, fontSize: 16.sp))),
      );
    }

    if (ctrl.layoutMode.value == 'spotlight') {
      return _SpotlightLayout(ctrl: ctrl);
    }

    final cols = parts.length == 1 ? 1
        : parts.length <= 4        ? 2
        : parts.length <= 9        ? 3 : 4;

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(8.w, 56.h, 8.w, 80.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: 4.w,
        mainAxisSpacing:  4.h,
      ),
      itemCount: parts.length,
      itemBuilder: (_, i) => _ParticipantTile(participant: parts[i], ctrl: ctrl),
    );
  });
}

// ── Participant Tile ─────────────────────────────────────
class _ParticipantTile extends StatelessWidget {
  final MeetingParticipant participant;
  final MeetingRoomController ctrl;
  const _ParticipantTile({required this.participant, required this.ctrl});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onDoubleTap: () => ctrl.spotlightUser(participant.userId),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2130),
        borderRadius: BorderRadius.circular(12.r),
        border: participant.isScreenSharing
            ? Border.all(color: Colors.green, width: 2)
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (participant.isCameraOff)
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: Colors.grey.shade800,
                child: Text(participant.name[0].toUpperCase(),
                    style: TextStyle(fontSize: 24.sp, color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ),
            ])
          else
            Container(color: Colors.grey.shade800,
                child: Center(child: Icon(Icons.videocam_rounded,
                    color: Colors.grey.shade600, size: 32.r))),

          // Overlay: name + controls
          Positioned(
            bottom: 8.h, left: 8.w, right: 8.w,
            child: Row(
              children: [
                Expanded(child: Text(
                  participant.role == ParticipantRole.host
                      ? '${participant.name} (Host)' : participant.name,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp,
                      shadows: const [Shadow(color: Colors.black54, blurRadius: 4)]),
                  overflow: TextOverflow.ellipsis,
                )),
                if (participant.isMuted)
                  Icon(Icons.mic_off_rounded, size: 14.r, color: Colors.red),
                if (participant.isHandRaised)
                  Icon(Icons.back_hand_rounded, size: 14.r, color: Colors.yellow),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ── Spotlight Layout ─────────────────────────────────────
class _SpotlightLayout extends StatelessWidget {
  final MeetingRoomController ctrl;
  const _SpotlightLayout({required this.ctrl});

  @override
  Widget build(BuildContext context) => Obx(() {
    final active = ctrl.participants.firstWhereOrNull(
            (p) => p.userId == ctrl.activeView.value)
        ?? (ctrl.participants.isNotEmpty ? ctrl.participants.first : null);
    if (active == null) return const SizedBox.shrink();

    return Column(
      children: [
        Expanded(flex: 3,
          child: _ParticipantTile(participant: active, ctrl: ctrl)),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            itemCount: ctrl.participants.length,
            itemBuilder: (_, i) {
              final p = ctrl.participants[i];
              if (p.userId == active.userId) return const SizedBox.shrink();
              return SizedBox(
                width: 130.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: _ParticipantTile(participant: p, ctrl: ctrl),
                ),
              );
            },
          ),
        ),
      ],
    );
  });
}

// ── Top Bar ──────────────────────────────────────────────
class _MeetingTopBar extends StatelessWidget {
  final MeetingRoomController ctrl;
  final MeetingModel meeting;
  const _MeetingTopBar({required this.ctrl, required this.meeting});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(16.w, MediaQuery.paddingOf(context).top + 8.h, 16.w, 12.h),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter, end: Alignment.bottomCenter,
        colors: [Colors.black.withOpacity(0.7), Colors.transparent],
      ),
    ),
    child: Row(
      children: [
        Obx(() => Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8.r)),
          child: Row(children: [
            Container(width: 6.r, height: 6.r,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
            SizedBox(width: 4.w),
            Text('LIVE', style: TextStyle(color: Colors.white,
                fontSize: 11.sp, fontWeight: FontWeight.w700)),
          ]),
        )),
        SizedBox(width: 12.w),
        Expanded(child: Text(meeting.title,
            style: TextStyle(color: Colors.white, fontSize: 15.sp,
                fontWeight: FontWeight.w600))),
        Obx(() => Text('${ctrl.participants.length} 👤',
            style: TextStyle(color: Colors.white, fontSize: 13.sp))),
        SizedBox(width: 12.w),
        // Layout switch
        IconButton(
          icon: const Icon(Icons.grid_view_rounded, color: Colors.white),
          onPressed: () => ctrl.setLayout(ctrl.layoutMode.value == 'grid' ? 'spotlight' : 'grid'),
        ),
      ],
    ),
  );
}

// ── Bottom Controls ──────────────────────────────────────
class _MeetingControls extends StatelessWidget {
  final MeetingRoomController ctrl;
  final BuildContext ctx;
  const _MeetingControls({required this.ctrl, required this.ctx});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, MediaQuery.paddingOf(context).bottom + 16.h),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter, end: Alignment.topCenter,
        colors: [Colors.black.withOpacity(0.85), Colors.transparent],
      ),
    ),
    child: Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _CtrlBtn(
          icon:    ctrl.isMicOn.value ? Icons.mic_rounded : Icons.mic_off_rounded,
          label:   ctrl.isMicOn.value ? 'Mute'           : 'Unmute',
          color:   ctrl.isMicOn.value ? Colors.white70   : Colors.red,
          onTap:   ctrl.toggleMic,
        ),
        SizedBox(width: 12.w),
        _CtrlBtn(
          icon:    ctrl.isCameraOn.value ? Icons.videocam_rounded : Icons.videocam_off_rounded,
          label:   ctrl.isCameraOn.value ? 'Stop Video'           : 'Start Video',
          color:   ctrl.isCameraOn.value ? Colors.white70         : Colors.red,
          onTap:   ctrl.toggleCamera,
        ),
        SizedBox(width: 12.w),
        _CtrlBtn(icon: Icons.screen_share_rounded,
            label: 'Share', color: ctrl.isScreenSharing.value ? Colors.green : Colors.white70,
            onTap: ctrl.toggleScreenShare),
        SizedBox(width: 12.w),
        _CtrlBtn(icon: Icons.chat_rounded,
            label: 'Chat', color: ctrl.isChatOpen.value ? Colors.blue : Colors.white70,
            onTap: ctrl.toggleChat),
        SizedBox(width: 12.w),
        _CtrlBtn(icon: Icons.people_rounded,
            label: 'People', color: Colors.white70,
            onTap: ctrl.toggleParticipants),
        SizedBox(width: 12.w),
        _CtrlBtn(icon: Icons.back_hand_rounded,
            label: 'Raise', color: ctrl.isHandRaised.value ? Colors.yellow : Colors.white70,
            onTap: ctrl.raiseHand),
        SizedBox(width: 12.w),
        // End call
        GestureDetector(
          onTap: () => _confirmEnd(context, ctrl),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(12.r)),
            child: Row(children: [
              Icon(Icons.call_end_rounded, color: Colors.white, size: 20.r),
              SizedBox(width: 6.w),
              Text('End', style: TextStyle(color: Colors.white,
                  fontSize: 13.sp, fontWeight: FontWeight.w700)),
            ]),
          ),
        ),
      ],
    )),
  );

  void _confirmEnd(BuildContext context, MeetingRoomController ctrl) {
    Get.defaultDialog(
      title: 'Leave Meeting',
      content: Text('Do you want to leave or end the meeting for everyone?',
          style: TextStyle(fontSize: 14.sp)),
      actions: [
        TextButton(onPressed: Get.back, child: const Text('Cancel')),
        OutlinedButton(onPressed: () { Get.back(); ctrl.leaveMeeting(); },
            child: const Text('Leave')),
        FilledButton(
          onPressed: () { Get.back(); ctrl.endMeeting(); },
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('End for All'),
        ),
      ],
    );
  }
}

class _CtrlBtn extends StatelessWidget {
  final IconData icon;
  final String   label;
  final Color    color;
  final VoidCallback onTap;
  const _CtrlBtn({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Column(children: [
      Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Colors.white12, shape: BoxShape.circle),
        child: Icon(icon, color: color, size: 22.r),
      ),
      SizedBox(height: 4.h),
      Text(label, style: TextStyle(color: Colors.white70, fontSize: 10.sp)),
    ]),
  );
}

// ── Side Panels ──────────────────────────────────────────
class _ChatSidePanel extends StatelessWidget {
  final MeetingRoomController ctrl;
  const _ChatSidePanel({required this.ctrl});

  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFF1A1D27),
    child: Column(
      children: [
        SizedBox(height: MediaQuery.paddingOf(context).top + 60.h),
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              Text('Meeting Chat',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
              const Spacer(),
              IconButton(icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: ctrl.toggleChat),
            ],
          ),
        ),
        Expanded(child: Center(
          child: Text('Chat messages appear here', style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
        )),
        Padding(
          padding: EdgeInsets.all(12.r),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Message everyone…',
              filled:   true, fillColor: Colors.white10,
              border:   OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: const Icon(Icons.send_rounded, color: Colors.white70),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

class _ParticipantSidePanel extends StatelessWidget {
  final MeetingRoomController ctrl;
  const _ParticipantSidePanel({required this.ctrl});

  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFF1A1D27),
    child: Column(
      children: [
        SizedBox(height: MediaQuery.paddingOf(context).top + 60.h),
        Padding(
          padding: EdgeInsets.all(16.r),
          child: Row(children: [
            Obx(() => Text('Participants (${ctrl.participants.length})',
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700))),
            const Spacer(),
            IconButton(icon: const Icon(Icons.close, color: Colors.white),
                onPressed: ctrl.toggleParticipants),
          ]),
        ),
        Expanded(
          child: Obx(() => ListView.builder(
            itemCount: ctrl.participants.length,
            itemBuilder: (_, i) {
              final p = ctrl.participants[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueGrey.shade700,
                  child: Text(p.name[0], style: const TextStyle(color: Colors.white)),
                ),
                title: Text(p.name,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                subtitle: p.role == ParticipantRole.host
                    ? Text('Host', style: TextStyle(color: Colors.green, fontSize: 12.sp))
                    : null,
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  if (p.isHandRaised) Icon(Icons.back_hand_rounded, size: 16.r, color: Colors.yellow),
                  if (p.isMuted)      Icon(Icons.mic_off_rounded,    size: 16.r, color: Colors.red),
                  if (p.isCameraOff)  Icon(Icons.videocam_off_rounded, size: 16.r, color: Colors.red),
                ]),
              );
            },
          )),
        ),
      ],
    ),
  );
}
