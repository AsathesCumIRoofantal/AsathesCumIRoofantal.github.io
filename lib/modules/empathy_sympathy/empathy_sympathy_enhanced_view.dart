import 'dart:math' as math;

import 'package:flutter/material.dart';


/// Auto-generated unique themed wrapper for Empathy Sympathy.
/// Adds a fresh design + new content sections while preserving original content
/// (the original EmpathySympathyView is embedded below the new sections).
///
/// Theme: Crimson Vault | Layout: blocks
class EmpathySympathyEnhancedView {
  final bool isEmbedded;
  final bool isDark;
  const EmpathySympathyEnhancedView({
    this.isEmbedded = false,
    required this.isDark,
  });

  static const Color _bg = Color(0xff1f0606);
  static const Color _bg2 = Color(0xff3d0c0c);
  static const Color _accent = Color(0xffdc2626);
  static const Color _soft = Color(0xfffca5a5);
  static const Color _gold = Color(0xfffcd34d);

  List<Widget> get slivers => [
    SliverAppBar(
      pinned: true,
      expandedHeight: 240,
      backgroundColor: _bg,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        'Empathy Sympathy',
        style: TextStyle(
          letterSpacing: 2,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: _Hero(
          palette: 'Crimson Vault',
          layout: 'blocks',
          bg: _bg,
          bg2: _bg2,
          accent: _accent,
          soft: _soft,
          gold: _gold,
          icon: Icons.emoji_objects_outlined,
          title: 'Empathy Sympathy',
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Container(
        color: isDark ? _bg : Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
        child: _Section(
          accent: _accent,
          gold: _gold,
          eyebrow: 'OVERVIEW',
          title: 'About Empathy Sympathy',
          child: Text(
            'Not a definition, but an invitation. Walk through the ideas, then bring one home with you.',
            style: TextStyle(
              fontSize: 15.5,
              height: 1.6,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Container(
        color: isDark ? _bg : Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: _Section(
          accent: _accent,
          gold: _gold,
          eyebrow: 'CORE PRINCIPLES',
          title: 'Four Pillars',
          child: Column(
            children: [
              _Pillar(
                n: 1,
                text: 'Roots before branches',
                accent: _accent,
                gold: _gold,
              ),
              _Pillar(
                n: 2,
                text: 'Direction before speed',
                accent: _accent,
                gold: _gold,
              ),
              _Pillar(
                n: 3,
                text: 'Character before applause',
                accent: _accent,
                gold: _gold,
              ),
              _Pillar(
                n: 4,
                text: 'Service before self',
                accent: _accent,
                gold: _gold,
              ),
            ],
          ),
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Container(
        color: isDark ? _bg : Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
        child: _Section(
          accent: _accent,
          gold: _gold,
          eyebrow: 'PRACTICE',
          title: 'Action Steps',
          child: Column(
            children: [
              _Step(
                n: 1,
                text: 'Choose one person to honour today',
                accent: _accent,
                gold: _gold,
              ),
              _Step(
                n: 2,
                text: 'Offer one specific appreciation',
                accent: _accent,
                gold: _gold,
              ),
              _Step(
                n: 3,
                text: 'Listen without interrupting',
                accent: _accent,
                gold: _gold,
              ),
              _Step(
                n: 4,
                text: 'Carry the warmth into tomorrow',
                accent: _accent,
                gold: _gold,
              ),
            ],
          ),
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Container(
        color: isDark ? _bg : Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: _Quote(
          text: 'The cave you fear to enter holds the treasure you seek.',
          author: 'Joseph Campbell',
          accent: _accent,
          gold: _gold,
          bg2: _bg2,
        ),
      ),
    ),
    SliverToBoxAdapter(
      child: Container(
        color: isDark ? _bg : Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
        child: Row(
          children: [
            Container(width: 4, height: 22, color: _accent),
            const SizedBox(width: 10),
            const Text(
              'ORIGINAL CONTENT',
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  ];
}

class _Hero extends StatelessWidget {
  final String palette, layout, title;
  final Color bg, bg2, accent, soft, gold;
  final IconData icon;
  const _Hero({
    required this.palette,
    required this.layout,
    required this.bg,
    required this.bg2,
    required this.accent,
    required this.soft,
    required this.gold,
    required this.icon,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [bg, bg2, accent.withValues(alpha: 0.35)],
            ),
          ),
        ),
        CustomPaint(
          painter: _HeroPainter(
            layout: layout,
            accent: accent,
            soft: soft,
            gold: gold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: gold.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: gold.withValues(alpha: 0.5)),
                ),
                child: Icon(icon, color: gold, size: 26),
              ),
              const SizedBox(height: 10),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                palette,
                style: TextStyle(
                  color: soft,
                  fontSize: 11,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroPainter extends CustomPainter {
  final String layout;
  final Color accent, soft, gold;
  _HeroPainter({
    required this.layout,
    required this.accent,
    required this.soft,
    required this.gold,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint();
    switch (layout) {
      case 'wave':
        p.color = accent.withValues(alpha: 0.22);
        final path = Path()
          ..moveTo(0, size.height * 0.55)
          ..quadraticBezierTo(
            size.width * 0.3,
            size.height * 0.35,
            size.width * 0.6,
            size.height * 0.55,
          )
          ..quadraticBezierTo(
            size.width * 0.85,
            size.height * 0.7,
            size.width,
            size.height * 0.5,
          )
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();
        canvas.drawPath(path, p);
        break;
      case 'diagonal':
        p.color = accent.withValues(alpha: 0.25);
        final path = Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width, size.height * 0.3)
          ..lineTo(size.width, size.height)
          ..close();
        canvas.drawPath(path, p);
        break;
      case 'circles':
        for (int i = 0; i < 6; i++) {
          p.color = (i.isEven ? accent : gold).withValues(alpha: 0.15);
          canvas.drawCircle(
            Offset(
              size.width * (0.1 + i * 0.18),
              size.height * (0.3 + (i % 3) * 0.18),
            ),
            22 + i * 6.0,
            p,
          );
        }
        break;
      case 'stripes':
        for (int i = 0; i < 8; i++) {
          p.color = accent.withValues(alpha: 0.08 + (i % 3) * 0.04);
          canvas.drawRect(
            Rect.fromLTWH(
              i * (size.width / 8),
              0,
              size.width / 16,
              size.height,
            ),
            p,
          );
        }
        break;
      case 'grid':
        p
          ..color = soft.withValues(alpha: 0.18)
          ..strokeWidth = 0.6
          ..style = PaintingStyle.stroke;
        for (double x = 0; x < size.width; x += 24) {
          canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
        }
        for (double y = 0; y < size.height; y += 24) {
          canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
        }
        break;
      case 'burst':
        p
          ..color = gold.withValues(alpha: 0.25)
          ..strokeWidth = 1.2
          ..style = PaintingStyle.stroke;
        final c = Offset(size.width * 0.85, size.height * 0.3);
        for (int i = 0; i < 14; i++) {
          final a = i * (math.pi * 2 / 14);
          canvas.drawLine(
            c,
            c + Offset(math.cos(a) * 100, math.sin(a) * 100),
            p,
          );
        }
        break;
      case 'rings':
        p
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4;
        for (int i = 0; i < 5; i++) {
          p.color = (i.isEven ? accent : gold).withValues(
            alpha: 0.3 - i * 0.04,
          );
          canvas.drawCircle(
            Offset(size.width * 0.2, size.height * 0.4),
            30.0 + i * 18,
            p,
          );
        }
        break;
      case 'blocks':
      default:
        for (int i = 0; i < 5; i++) {
          p.color = (i.isEven ? accent : gold).withValues(alpha: 0.18);
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(
                20.0 + i * 50,
                size.height * 0.3 + (i % 2) * 30,
                40,
                40,
              ),
              const Radius.circular(8),
            ),
            p,
          );
        }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _Section extends StatelessWidget {
  final String eyebrow, title;
  final Widget child;
  final Color accent, gold;
  const _Section({
    required this.eyebrow,
    required this.title,
    required this.child,
    required this.accent,
    required this.gold,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 28, height: 2, color: gold),
            const SizedBox(width: 8),
            Text(
              eyebrow,
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: gold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: accent,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

class _Pillar extends StatelessWidget {
  final int n;
  final String text;
  final Color accent, gold;
  const _Pillar({
    required this.n,
    required this.text,
    required this.accent,
    required this.gold,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: gold, width: 3)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$n',
                style: TextStyle(color: accent, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final int n;
  final String text;
  final Color accent, gold;
  const _Step({
    required this.n,
    required this.text,
    required this.accent,
    required this.gold,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.08),
            gold.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'STEP $n',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14.5, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

class _Quote extends StatelessWidget {
  final String text, author;
  final Color accent, gold, bg2;
  const _Quote({
    required this.text,
    required this.author,
    required this.accent,
    required this.gold,
    required this.bg2,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [bg2, accent],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.format_quote, color: gold, size: 32),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '— $author',
            style: TextStyle(
              color: gold,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
