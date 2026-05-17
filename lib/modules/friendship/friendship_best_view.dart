import 'package:flutter/material.dart';

/// DESIGN: Chat Interface — friendship as a conversation with themed message cards
class FriendshipBestView extends StatelessWidget {
  const FriendshipBestView({super.key});

  static const _sky = Color(0xFF0EA5E9);
  static const _green = Color(0xFF10B981);
  static const _violet = Color(0xFF7C3AED);
  static const _amber = Color(0xFFF59E0B);
  static const _rose = Color(0xFFF43F5E);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF02060E);

  @override
  Widget build(BuildContext context) {
    final msgs = [
      _ChatMsg(isLeft: true, name: 'AIR', avatar: '🤖', color: _sky, time: '09:00', text: 'Good morning! Did you know that the quality of your friendships is the single strongest predictor of daily wellbeing — stronger than income, health, or career success? Let\'s talk about friendship today.'),
      _ChatMsg(isLeft: false, name: 'You', avatar: '🧑', color: _green, time: '09:01', text: 'Interesting. I\'ve been thinking about why some friendships last decades and others fade after a year or two.'),
      _ChatMsg(isLeft: true, name: 'AIR', avatar: '🤖', color: _sky, time: '09:02', text: 'Great question. Research suggests lasting friendships have three things in common: shared experiences accumulated over time, mutual vulnerability (both people have shown their imperfect selves), and a pattern of showing up during difficulty — not just during the good times.'),
      _ChatMsg(isLeft: false, name: 'You', avatar: '🧑', color: _green, time: '09:03', text: 'What about friendships where you only see each other every few months? Can those still be close?'),
      _ChatMsg(isLeft: true, name: 'AIR', avatar: '🤖', color: _sky, time: '09:04', text: 'Yes — frequency is less important than depth and the feeling that you can pick up exactly where you left off. These are sometimes called "low-maintenance" friendships — they require less regular contact but the connection is deep enough to survive gaps. The key is ensuring the gaps don\'t become permanent.'),
      _ChatMsg(isLeft: false, name: 'You', avatar: '🧑', color: _green, time: '09:05', text: 'What about making new friends as an adult? It feels so much harder than when we were kids.'),
      _ChatMsg(isLeft: true, name: 'AIR', avatar: '🤖', color: _sky, time: '09:06', text: 'It IS harder — and that\'s well-established in the research. Adult friendship formation requires repeated unplanned contact (proximity), shared vulnerability, and time together outside of role contexts (not just work colleagues). It\'s harder because adult life provides fewer natural contexts for these three conditions to coincide. You have to engineer them deliberately.'),
      _ChatMsg(isLeft: false, name: 'You', avatar: '🧑', color: _green, time: '09:07', text: 'How do I maintain friendships when life gets busy?'),
      _ChatMsg(isLeft: true, name: 'AIR', avatar: '🤖', color: _sky, time: '09:08', text: 'Schedule them like meetings — because they are the most important meetings you have. A 15-minute voice call beats 12 text chains. A once-quarterly dinner beats a dozen "we should catch up soon" messages. Make it easy for both of you: have a recurring slot that doesn\'t require planning every time.'),
      _ChatMsg(isLeft: true, name: 'AIR', avatar: '🤖', color: _violet, time: '09:09', text: '💡 AIR FRIENDSHIP INSIGHT: People who actively maintain 3–5 close friendships report 47% higher life satisfaction than those who let friendships drift. Start with one friend you haven\'t spoken to in 3+ months. Call them today.'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF050A14),
        foregroundColor: Colors.white,
        title: Row(children: [
          Container(width: 32, height: 32, decoration: BoxDecoration(shape: BoxShape.circle, color: _sky.withOpacity(0.15), border: Border.all(color: _sky.withOpacity(0.4))), child: const Center(child: Text('🤖', style: TextStyle(fontSize: 16)))),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('AIR Friendship Guide', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white)),
            Row(children: [Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)), const SizedBox(width: 4), Text('Online', style: TextStyle(fontSize: 9, color: _green.withOpacity(0.8)))]),
          ]),
        ]),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 40),
        children: [
          Center(child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5), decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(12)), child: const Text('Today — May 16, 2026', style: TextStyle(color: Colors.white38, fontSize: 10)))),
          const SizedBox(height: 16),
          ...msgs.map((m) => _MsgBubble(msg: m)),
          const SizedBox(height: 12),
          // FRIENDSHIP TOOLS
          Container(
            padding: const EdgeInsets.all(16), margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(color: _violet.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: _violet.withOpacity(0.2))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('FRIENDSHIP TRACKER', style: TextStyle(color: _violet, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 12),
              ...[('Inner Circle', 4, _sky), ('Regular Friends', 11, _green), ('Occasional', 23, _amber)].map((t) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(children: [
                  SizedBox(width: 110, child: Text(t.$1, style: const TextStyle(color: Colors.white60, fontSize: 11))),
                  Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, color: t.$3.withOpacity(0.12), border: Border.all(color: t.$3.withOpacity(0.3))), child: Center(child: Text('${t.$2}', style: TextStyle(color: t.$3, fontSize: 11, fontWeight: FontWeight.w900)))),
                  const SizedBox(width: 10),
                  Expanded(child: Stack(children: [
                    Container(height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(3))),
                    FractionallySizedBox(widthFactor: t.$2 / 30, child: Container(height: 6, decoration: BoxDecoration(color: t.$3, borderRadius: BorderRadius.circular(3)))),
                  ])),
                ]),
              )),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ChatMsg {
  final bool isLeft; final String name, avatar, text, time; final Color color;
  const _ChatMsg({required this.isLeft, required this.name, required this.avatar, required this.color, required this.time, required this.text});
}

class _MsgBubble extends StatelessWidget {
  final _ChatMsg msg;
  const _MsgBubble({required this.msg});
  @override
  Widget build(BuildContext context) {
    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: 280),
      margin: EdgeInsets.only(bottom: 10, left: msg.isLeft ? 0 : 40, right: msg.isLeft ? 40 : 0),
      child: Column(crossAxisAlignment: msg.isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end, children: [
        Row(mainAxisAlignment: msg.isLeft ? MainAxisAlignment.start : MainAxisAlignment.end, children: [
          if (msg.isLeft) Text(msg.avatar, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(msg.name, style: TextStyle(color: msg.color, fontSize: 9, fontWeight: FontWeight.w700)),
          const SizedBox(width: 6),
          Text(msg.time, style: const TextStyle(color: Colors.white24, fontSize: 8)),
          if (!msg.isLeft) ...[const SizedBox(width: 4), Text(msg.avatar, style: const TextStyle(fontSize: 14))],
        ]),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: msg.color.withOpacity(0.10),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(msg.isLeft ? 4 : 16), topRight: Radius.circular(msg.isLeft ? 16 : 4),
              bottomLeft: const Radius.circular(16), bottomRight: const Radius.circular(16),
            ),
            border: Border.all(color: msg.color.withOpacity(0.22)),
          ),
          child: Text(msg.text, style: const TextStyle(color: Colors.white80, fontSize: 12, height: 1.45)),
        ),
      ]),
    );
    return Align(alignment: msg.isLeft ? Alignment.centerLeft : Alignment.centerRight, child: bubble);
  }
}
