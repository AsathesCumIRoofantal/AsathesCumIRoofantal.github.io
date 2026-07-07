import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../zoom_routes.dart';
import '../widgets/zoom_theme.dart';

/// Waiting room that auto-navigates when the host admits the user.
/// Subscribes to the `meetings` Supabase Realtime channel and fires
/// Get.toNamed the moment the row's status flips to 'live'.
class WaitingRoomView extends StatefulWidget {
  const WaitingRoomView({super.key});
  @override
  State<WaitingRoomView> createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoomView>
    with TickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);

  RealtimeChannel? _channel;
  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _subscribeToMeeting();
  }

  void _subscribeToMeeting() {
    final args = Get.arguments as Map? ?? {};
    final channelId = args['channelId'] as String?;
    if (channelId == null) return;

    _channel = Supabase.instance.client
        .channel('waiting:$channelId')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'meetings',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'channel_name',
            value: channelId,
          ),
          callback: (payload) {
            final newStatus = payload.newRecord['status'] as String?;
            if (newStatus == 'live' && !_navigating && mounted) {
              _navigating = true;
              // Small delay so the server finishes its transaction
              Future.delayed(const Duration(milliseconds: 400), () {
                Get.toNamed(ZoomRoutes.inMeeting, arguments: args);
              });
            }
          },
        )
        .subscribe();
  }

  @override
  void dispose() {
    _pulse.dispose();
    if (_channel != null) {
      Supabase.instance.client.removeChannel(_channel!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args   = Get.arguments as Map? ?? {};
    final title  = args['meetingTitle'] as String? ?? 'Meeting';
    final host   = args['hostName']     as String? ?? 'The host';

    return Scaffold(
      backgroundColor: ZoomTheme.bg,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                AnimatedBuilder(
                  animation: _pulse,
                  builder: (_, __) => Container(
                    width: 140, height: 140,
                    decoration: BoxDecoration(
                      gradient: ZoomTheme.heroGradient,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(
                        color: ZoomTheme.primary.withOpacity(.4 + _pulse.value * .3),
                        blurRadius: 30 + _pulse.value * 30,
                        spreadRadius: _pulse.value * 8,
                      )],
                    ),
                    child: const Icon(Icons.hourglass_top, color: Colors.white, size: 56),
                  ),
                ),
                const SizedBox(height: 28),
                Text("You're in the waiting room",
                    style: ZoomTheme.h2, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text('$host will let you in shortly.',
                    style: ZoomTheme.muted, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ZoomTheme.card(r: 14),
                  child: Column(children: [
                    Row(children: [
                      InitialsAvatar(name: host, colorHex: 0xFF4F8CFF, size: 40),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(title,
                            style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis),
                        Text('Hosted by $host', style: ZoomTheme.muted),
                      ])),
                    ]),
                    const Divider(color: ZoomTheme.stroke, height: 24),
                    Row(children: [
                      const Icon(Icons.wifi_tethering, size: 16, color: ZoomTheme.success),
                      const SizedBox(width: 6),
                      Text('Listening for host admission…', style: ZoomTheme.muted),
                    ]),
                  ]),
                ),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () => Get.offAllNamed(ZoomRoutes.home),
                  icon: const Icon(Icons.close),
                  label: const Text('Leave waiting room'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ZoomTheme.text,
                    side: const BorderSide(color: ZoomTheme.stroke),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
