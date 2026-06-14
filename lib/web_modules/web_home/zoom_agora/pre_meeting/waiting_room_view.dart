import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../zoom_routes.dart';
import '../widgets/zoom_theme.dart';

/// Friendly waiting-room screen with animated avatars and host info.
class WaitingRoomView extends StatefulWidget {
  const WaitingRoomView({super.key});
  @override State<WaitingRoomView> createState() => _S();
}

class _S extends State<WaitingRoomView> with TickerProviderStateMixin {
  late final AnimationController _pulse =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);

  @override void dispose() { _pulse.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext c) => Scaffold(
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
                      blurRadius: 30 + _pulse.value * 30, spreadRadius: _pulse.value * 8)],
                  ),
                  child: const Icon(Icons.hourglass_top, color: Colors.white, size: 56),
                ),
              ),
              const SizedBox(height: 28),
              Text('You\'re in the waiting room', style: ZoomTheme.h2, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text('The host will let you in shortly.',
                style: ZoomTheme.muted, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: ZoomTheme.card(r: 14),
                child: Column(children: [
                  Row(children: [
                    const InitialsAvatar(name: 'Aarav Sharma', colorHex: 0xFF4F8CFF, size: 40),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Product weekly sync', style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600)),
                      Text('Hosted by Aarav Sharma', style: ZoomTheme.muted),
                    ])),
                  ]),
                  const Divider(color: ZoomTheme.stroke, height: 24),
                  Row(children: [
                    const Icon(Icons.access_time, size: 16, color: ZoomTheme.textMuted),
                    const SizedBox(width: 6),
                    Text('Scheduled · 10:00 – 10:45', style: ZoomTheme.muted),
                  ]),
                ]),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () => Get.offAllNamed(ZoomRoutes.home),
                icon: const Icon(Icons.close),
                label: const Text('Leave waiting room'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ZoomTheme.text, side: const BorderSide(color: ZoomTheme.stroke),
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
