import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../zoom_routes.dart';
import '../widgets/zoom_theme.dart';
import '../widgets/backend_toggle.dart';

/// Polished, responsive home screen for the Zoom-parity module.
/// Adapts from a single column on mobile to a 2-column hero layout on desktop.
class ZoomHomeView extends StatelessWidget {
  const ZoomHomeView({super.key});

  @override
  Widget build(BuildContext c) {
    return Scaffold(
      backgroundColor: ZoomTheme.bg,
      body: SafeArea(
        child: LayoutBuilder(builder: (c, cons) {
          final wide = cons.maxWidth >= 980;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: wide ? 48 : 20, vertical: wide ? 32 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TopBar(),
                const SizedBox(height: 24),
                if (wide)
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(flex: 7, child: _Hero()),
                    const SizedBox(width: 24),
                    Expanded(flex: 5, child: _UpcomingList()),
                  ])
                else ...[
                  _Hero(),
                  const SizedBox(height: 24),
                  _UpcomingList(),
                ],
                const SizedBox(height: 28),
                Text('Quick actions', style: ZoomTheme.h2),
                const SizedBox(height: 12),
                _QuickActions(),
                const SizedBox(height: 28),
                _RecentRecordings(),
                const SizedBox(height: 40),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext c) => Row(children: [
    Container(width: 36, height: 36,
      decoration: BoxDecoration(gradient: ZoomTheme.heroGradient,
        borderRadius: BorderRadius.circular(10)),
      child: const Icon(Icons.videocam_rounded, color: Colors.white, size: 20)),
    const SizedBox(width: 12),
    Text('AIR Meet', style: ZoomTheme.h3),
    const Spacer(),
    const BackendToggle(),
    const SizedBox(width: 12),
    IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline, color: ZoomTheme.textMuted)),
    IconButton(onPressed: () => Get.toNamed(ZoomRoutes.settings),
      icon: const Icon(Icons.settings_outlined, color: ZoomTheme.textMuted)),
    const SizedBox(width: 8),
    const InitialsAvatar(name: 'You', colorHex: 0xFF4F8CFF, size: 36),
  ]);
}

class _Hero extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: ZoomTheme.heroGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [BoxShadow(color: Color(0x554F8CFF), blurRadius: 32, offset: Offset(0,12))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Tuesday, 14 January',
          style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: .4)),
        const SizedBox(height: 6),
        const Text('Good morning, Aarav',
          style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700, height: 1.1)),
        const SizedBox(height: 6),
        const Text('Your next meeting starts in 12 minutes.',
          style: TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 20),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _heroBtn(Icons.videocam_rounded, 'New meeting', Colors.white, Colors.black,
            () => Get.toNamed(ZoomRoutes.devicePreview, arguments: {'mode':'instant'})),
          _heroBtn(Icons.add_box_outlined, 'Join', Colors.white24, Colors.white,
            () => Get.toNamed(ZoomRoutes.join)),
          _heroBtn(Icons.event_outlined, 'Schedule', Colors.white24, Colors.white,
            () => Get.toNamed(ZoomRoutes.schedule)),
        ]),
      ]),
    );
  }
  Widget _heroBtn(IconData i, String l, Color bg, Color fg, VoidCallback onTap) =>
    FilledButton.icon(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        backgroundColor: bg, foregroundColor: fg,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      icon: Icon(i, size: 18),
      label: Text(l, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
}

class _UpcomingList extends StatelessWidget {
  static final _items = <Map<String, String>>[
    {'time':'10:00', 'title':'Product weekly sync',   'meta':'8 invitees · Recurring',  'id':'824-731-9056'},
    {'time':'12:30', 'title':'1:1 with Priya',         'meta':'2 invitees',              'id':'901-118-2003'},
    {'time':'16:00', 'title':'Q3 roadmap review',      'meta':'12 invitees · Webinar',   'id':'553-220-7711'},
  ];
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.all(20),
    decoration: ZoomTheme.card(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text('Upcoming', style: ZoomTheme.h3),
        const Spacer(),
        TextButton(onPressed: (){}, child: const Text('View all', style: TextStyle(color: ZoomTheme.primary))),
      ]),
      const SizedBox(height: 8),
      ..._items.map((m) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Container(width:54, padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(color: ZoomTheme.surface2,
              borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            child: Text(m['time']!, style: const TextStyle(color: ZoomTheme.text, fontWeight: FontWeight.w600))),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(m['title']!, style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(m['meta']!, style: ZoomTheme.muted),
          ])),
          FilledButton(
            onPressed: () => Get.toNamed(ZoomRoutes.devicePreview, arguments: {'mode':'join','meetingId':m['id']}),
            style: FilledButton.styleFrom(
              backgroundColor: ZoomTheme.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Start')),
        ]),
      )),
    ]),
  );
}

class _QuickActions extends StatelessWidget {
  static final _tiles = <_Tile>[
    _Tile(Icons.videocam_rounded, 'New meeting', 0xFFFF5C7A,
      ZoomRoutes.devicePreview, args: {'mode':'instant'}),
    _Tile(Icons.add_box_outlined, 'Join', 0xFF4F8CFF, ZoomRoutes.join),
    _Tile(Icons.event_outlined, 'Schedule', 0xFF2EE6A6, ZoomRoutes.schedule),
    _Tile(Icons.screen_share_outlined, 'Share screen', 0xFF7C5CFF,
      ZoomRoutes.devicePreview, args: {'mode':'share'}),
    _Tile(Icons.contacts_outlined, 'Contacts', 0xFFFFB020, ZoomRoutes.home),
    _Tile(Icons.history_rounded, 'Recordings', 0xFF06B6D4, ZoomRoutes.home),
  ];
  @override
  Widget build(BuildContext c) {
    final w = MediaQuery.of(c).size.width;
    final cols = w >= 1100 ? 6 : w >= 720 ? 4 : 3;
    return GridView.count(
      crossAxisCount: cols, shrinkWrap: true,
      mainAxisSpacing: 12, crossAxisSpacing: 12,
      childAspectRatio: 1.05,
      physics: const NeverScrollableScrollPhysics(),
      children: _tiles.map((t) => InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Get.toNamed(t.route, arguments: t.args),
        child: Container(
          decoration: ZoomTheme.card(),
          padding: const EdgeInsets.all(14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(width: 40, height: 40,
              decoration: BoxDecoration(color: Color(t.color).withOpacity(.18),
                borderRadius: BorderRadius.circular(10)),
              child: Icon(t.icon, color: Color(t.color))),
            Text(t.label, style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600)),
          ]),
        ),
      )).toList(),
    );
  }
}
class _Tile { final IconData icon; final String label; final int color; final String route; final Object? args;
  _Tile(this.icon, this.label, this.color, this.route, {this.args}); }

class _RecentRecordings extends StatelessWidget {
  static const _items = [
    ('Design crit · v4',     '47 min', 'Yesterday'),
    ('Customer interview',   '32 min', '2 days ago'),
    ('All-hands · January',  '58 min', 'Last week'),
  ];
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.all(20),
    decoration: ZoomTheme.card(),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Recent recordings', style: ZoomTheme.h3),
      const SizedBox(height: 12),
      ..._items.map((r) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Container(width: 64, height: 40,
            decoration: BoxDecoration(gradient: ZoomTheme.heroGradient,
              borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.play_arrow_rounded, color: Colors.white)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(r.$1, style: ZoomTheme.body.copyWith(fontWeight: FontWeight.w600)),
            Text('${r.$2} · ${r.$3}', style: ZoomTheme.muted),
          ])),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz, color: ZoomTheme.textMuted)),
        ]),
      )),
    ]),
  );
}
