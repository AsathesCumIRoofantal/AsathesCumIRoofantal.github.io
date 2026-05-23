import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_nav_data.dart';
import '../../_shared/web_shell.dart';
import 'web_events_controller.dart';

class WebEventsView extends GetView<WebEventsController> {
  static const routeName = '/web-profile/events';
  const WebEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFF5F3FF),
        body: _Body(isDark: isDark, ctrl: controller),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final bool isDark;
  final WebEventsController ctrl;
  const _Body({required this.isDark, required this.ctrl});
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late AnimationController _timelineCtrl;

  static const _events = [
    ('AIR Annual Summit 2026', 'Jun 15 · 10:00 AM', 'Community Hall A', Color(0xFF7C3AED), Icons.event_rounded, true),
    ('Flutter Web Workshop', 'Jun 18 · 2:00 PM', 'Online / Zoom', Color(0xFF0284C7), Icons.web_rounded, true),
    ('Profile Review Session', 'Jun 22 · 11:00 AM', 'Room 204', Color(0xFF059669), Icons.person_search_rounded, true),
    ('AIR Knowledge Fair', 'Jul 5 · 9:00 AM', 'Main Campus', Color(0xFFEA580C), Icons.school_rounded, false),
    ('Mentor Meet-Up', 'Jul 12 · 3:30 PM', 'Cafe Connect', Color(0xFFEC4899), Icons.people_rounded, false),
  ];

  @override
  void initState() {
    super.initState();
    _timelineCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
  }

  @override
  void dispose() { _timelineCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 290,
          pinned: true,
          backgroundColor: const Color(0xFF7C3AED),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Events', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFF6D28D9), Color(0xFF4C1D95)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(children: [
                Positioned(right: -20, top: 30,
                  child: Container(width: 180, height: 180,
                    decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.06), shape: BoxShape.circle))),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 56),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                        child: const Text('Schedule · Confirm · Follow-up', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 12),
                      const Text('Your Events\nTimeline', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900, height: 1.2)),
                      const SizedBox(height: 8),
                      Text('Plan, confirm, and follow up on AIR and profile events.',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),

        // View toggle
        SliverToBoxAdapter(
          child: Obx(() => Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: widget.isDark ? WColors.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
            ),
            child: Row(children: ['Upcoming', 'Past', 'Calendar'].asMap().entries.map((e) {
              final sel = widget.ctrl.viewType.value == e.value.toLowerCase();
              return Expanded(child: GestureDetector(
                onTap: () => widget.ctrl.viewType.value = e.value.toLowerCase(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: sel ? const Color(0xFF7C3AED) : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: sel ? [BoxShadow(color: const Color(0xFF7C3AED).withValues(alpha: 0.35), blurRadius: 10)] : [],
                  ),
                  child: Center(child: Text(e.value, style: TextStyle(
                    color: sel ? Colors.white : (widget.isDark ? Colors.white60 : Colors.black45),
                    fontWeight: sel ? FontWeight.w800 : FontWeight.w500, fontSize: 13,
                  ))),
                ),
              ));
            }).toList()),
          )),
        ),

        // Flutter 2026
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF2D1B69), Color(0xFF4C1D95)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [
                  Icon(Icons.calendar_month_rounded, color: Color(0xFFC084FC), size: 18),
                  SizedBox(width: 8),
                  Text('Flutter 2026 Calendar Engine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
                ]),
                const SizedBox(height: 10),
                Text(
                  'Custom sliver calendar views · AI conflict detection · Cross-timezone sync · Animated timeline slivers · Push reminders via FCM',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 12, height: 1.5),
                ),
              ]),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        // Timeline
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) {
                if (i >= _events.length) return null;
                final ev = _events[i];
                final delay = i / _events.length;
                return AnimatedBuilder(
                  animation: _timelineCtrl,
                  builder: (_, __) {
                    final progress = ((_timelineCtrl.value - delay * 0.6) / 0.4).clamp(0.0, 1.0);
                    return Opacity(
                      opacity: progress,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - progress)),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Column(children: [
                              Container(width: 36, height: 36, decoration: BoxDecoration(color: ev.$4.withValues(alpha: 0.15), shape: BoxShape.circle),
                                child: Icon(ev.$5, color: ev.$4, size: 18)),
                              if (i < _events.length - 1)
                                Container(width: 2, height: 40, color: ev.$4.withValues(alpha: 0.2)),
                            ]),
                            const SizedBox(width: 14),
                            Expanded(child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: widget.isDark ? WColors.cardDark : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: ev.$4.withValues(alpha: 0.2)),
                                boxShadow: [BoxShadow(color: ev.$4.withValues(alpha: 0.08), blurRadius: 12)],
                              ),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Row(children: [
                                  Expanded(child: Text(ev.$1, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: widget.isDark ? Colors.white : const Color(0xFF0F172A)))),
                                  if (ev.$6)
                                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: const Color(0xFF059669).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
                                      child: const Text('Confirmed', style: TextStyle(color: Color(0xFF059669), fontSize: 10, fontWeight: FontWeight.w800))),
                                ]),
                                const SizedBox(height: 6),
                                Row(children: [
                                  Icon(Icons.access_time_rounded, size: 13, color: ev.$4),
                                  const SizedBox(width: 4),
                                  Text(ev.$2, style: TextStyle(fontSize: 12, color: ev.$4, fontWeight: FontWeight.w600)),
                                  const SizedBox(width: 12),
                                  Icon(Icons.location_on_outlined, size: 13, color: widget.isDark ? Colors.white38 : Colors.black38),
                                  const SizedBox(width: 4),
                                  Expanded(child: Text(ev.$3, style: TextStyle(fontSize: 12, color: widget.isDark ? Colors.white54 : Colors.black45), overflow: TextOverflow.ellipsis)),
                                ]),
                              ]),
                            )),
                          ]),
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: _events.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );
  }
}
