// _rich_widgets.dart
// Tiny reusable building blocks for the 8 rich web pages.
import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Animated number that counts up when first painted.
class CountUp extends StatefulWidget {
  final num end;
  final Duration duration;
  final String suffix;
  final TextStyle? style;
  const CountUp(this.end,
      {super.key,
      this.duration = const Duration(milliseconds: 1400),
      this.suffix = '',
      this.style});
  @override
  State<CountUp> createState() => _CountUpState();
}

class _CountUpState extends State<CountUp>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: widget.duration)..forward();
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _c,
        builder: (_, __) {
          final v = (widget.end * Curves.easeOutCubic.transform(_c.value));
          final txt = widget.end is int
              ? v.toInt().toString()
              : v.toStringAsFixed(1);
          return Text('$txt${widget.suffix}', style: widget.style);
        },
      );
}

/// Soft glow gradient hero background.
class GlowBackground extends StatefulWidget {
  final List<Color> colors;
  final Widget child;
  const GlowBackground({super.key, required this.colors, required this.child});
  @override
  State<GlowBackground> createState() => _GlowBackgroundState();
}

class _GlowBackgroundState extends State<GlowBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(seconds: 8))
        ..repeat();
  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _c,
        builder: (_, child) {
          final t = _c.value * 2 * math.pi;
          return Stack(children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.colors,
                    begin: Alignment(math.cos(t), math.sin(t)),
                    end: Alignment(-math.cos(t), -math.sin(t)),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 60 + 40 * math.sin(t),
              top: 40 + 30 * math.cos(t),
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [
                    Colors.white.withValues(alpha: .25),
                    Colors.white.withValues(alpha: 0),
                  ]),
                ),
              ),
            ),
            child!,
          ]);
        },
        child: widget.child,
      );
}

/// Reveal-on-mount fade + slide.
class Reveal extends StatefulWidget {
  final Widget child;
  final int delayMs;
  final Offset offset;
  const Reveal({
    super.key,
    required this.child,
    this.delayMs = 0,
    this.offset = const Offset(0, 24),
  });
  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 700));
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _c.forward();
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
    return AnimatedBuilder(
      animation: t,
      builder: (_, child) => Opacity(
        opacity: t.value,
        child: Transform.translate(
          offset: Offset(widget.offset.dx * (1 - t.value),
              widget.offset.dy * (1 - t.value)),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}

/// Hover-lift wrapper (web/desktop).
class HoverLift extends StatefulWidget {
  final Widget child;
  final double lift;
  final BorderRadius radius;
  const HoverLift({
    super.key,
    required this.child,
    this.lift = 6,
    this.radius = const BorderRadius.all(Radius.circular(20)),
  });
  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..translate(0.0, _hover ? -widget.lift : 0.0),
          decoration: BoxDecoration(
            borderRadius: widget.radius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: _hover ? .18 : .06),
                blurRadius: _hover ? 28 : 14,
                offset: Offset(0, _hover ? 16 : 8),
              ),
            ],
          ),
          child: widget.child,
        ),
      );
}
