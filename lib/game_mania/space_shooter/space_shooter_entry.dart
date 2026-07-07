import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';

// ── GetX state ───────────────────────────────────────────────────────────────
class ShooterController extends GetxController {
  final score = 0.obs;
  final lives = 3.obs;
  final isOver = false.obs;

  void addScore(int v) => score.value += v;
  void loseLife() {
    lives.value--;
    if (lives.value <= 0) isOver.value = true;
  }

  void restart() {
    score.value = 0;
    lives.value = 3;
    isOver.value = false;
  }
}

// ── Entry widget (wraps the game canvas + HUD) ───────────────────────────────
class SpaceShooterEntry extends StatelessWidget {
  const SpaceShooterEntry({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShooterController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            const _ShooterCanvas(),
            // HUD
            Positioned(
              top: 12,
              left: 16,
              child: Obx(() {
                final c = Get.find<ShooterController>();
                return Row(
                  children: [
                    Text(
                      '⭐ ${c.score.value}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 16),
                    ...List.generate(
                      c.lives.value,
                      (_) => const Text('❤️', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                );
              }),
            ),
            Positioned(
              top: 12,
              right: 16,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white70,
                ),
                onPressed: Get.back,
              ),
            ),
            // Game over overlay
            Obx(() {
              final c = Get.find<ShooterController>();
              if (!c.isOver.value) return const SizedBox.shrink();
              return Container(
                color: Colors.black87,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'GAME OVER',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => Text(
                          'Score: ${c.score.value}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: c.restart,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                        ),
                        child: const Text(
                          'Play again',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: Get.back,
                        child: const Text(
                          'Exit',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ── Game canvas (CustomPainter + Ticker loop) ────────────────────────────────
class _ShooterCanvas extends StatefulWidget {
  const _ShooterCanvas();
  @override
  State<_ShooterCanvas> createState() => _ShooterCanvasState();
}

class _ShooterCanvasState extends State<_ShooterCanvas>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _last = Duration.zero;

  double _px = 0, _py = 0; // player centre (set on first frame)
  double _vx = 0;
  final _bullets = <Rect>[];
  final _enemies = <Rect>[];
  final _stars = <Offset>[];
  final Set<LogicalKeyboardKey> _keys = {};
  final _rng = Random();
  double _spawnTimer = 0;
  bool _initialized = false;

  static const _pW = 40.0, _pH = 48.0;
  static const _bW = 6.0, _bH = 18.0;
  static const _eW = 38.0, _eH = 38.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick)..start();
    HardwareKeyboard.instance.addHandler(_onKey);
  }

  @override
  void dispose() {
    _ticker.dispose();
    HardwareKeyboard.instance.removeHandler(_onKey);
    super.dispose();
  }

  bool _onKey(KeyEvent e) {
    if (e is KeyDownEvent) _keys.add(e.logicalKey);
    if (e is KeyUpEvent) _keys.remove(e.logicalKey);
    if (e is KeyDownEvent && e.logicalKey == LogicalKeyboardKey.space) _shoot();
    return false;
  }

  void _shoot() {
    _bullets.add(
      Rect.fromCenter(
        center: Offset(_px, _py - _pH / 2 - 4),
        width: _bW,
        height: _bH,
      ),
    );
  }

  void _tick(Duration elapsed) {
    final ctrl = Get.find<ShooterController>();
    if (ctrl.isOver.value) return;

    final dt = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;

    final size = context.size ?? const Size(400, 800);
    if (!_initialized) {
      _px = size.width / 2;
      _py = size.height - 80;
      _initialized = true;
      for (var i = 0; i < 60; i++)
        _stars.add(
          Offset(
            _rng.nextDouble() * size.width,
            _rng.nextDouble() * size.height,
          ),
        );
    }

    // Player movement
    if (_keys.contains(LogicalKeyboardKey.arrowLeft))
      _vx = -300;
    else if (_keys.contains(LogicalKeyboardKey.arrowRight))
      _vx = 300;
    else
      _vx *= 0.85;
    _px = (_px + _vx * dt).clamp(_pW / 2, size.width - _pW / 2);

    // Move bullets
    for (final b in _bullets.toList()) {
      _bullets[_bullets.indexOf(b)] = b.translate(0, -500 * dt);
    }
    _bullets.removeWhere((b) => b.bottom < 0);

    // Spawn enemies
    _spawnTimer += dt;
    if (_spawnTimer >= 1.1) {
      _spawnTimer = 0;
      final ex = _rng.nextDouble() * (size.width - _eW) + _eW / 2;
      _enemies.add(
        Rect.fromCenter(center: Offset(ex, -_eH), width: _eW, height: _eH),
      );
    }
    for (final e in _enemies.toList()) {
      _enemies[_enemies.indexOf(e)] = e.translate(0, 140 * dt);
    }

    // Collisions
    for (final e in _enemies.toList()) {
      for (final b in _bullets.toList()) {
        if (e.overlaps(b)) {
          _enemies.remove(e);
          _bullets.remove(b);
          ctrl.addScore(10);
          break;
        }
      }
      if (e.bottom > size.height) {
        _enemies.remove(e);
        ctrl.loseLife();
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (d) =>
          _px = (_px + d.delta.dx).clamp(0, context.size?.width ?? 400),
      onTapDown: (_) => _shoot(),
      child: CustomPaint(
        painter: _ShooterPainter(
          px: _px,
          py: _py,
          bullets: List.of(_bullets),
          enemies: List.of(_enemies),
          stars: _stars,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _ShooterPainter extends CustomPainter {
  const _ShooterPainter({
    required this.px,
    required this.py,
    required this.bullets,
    required this.enemies,
    required this.stars,
  });
  final double px, py;
  final List<Rect> bullets, enemies;
  final List<Offset> stars;

  @override
  void paint(Canvas c, Size s) {
    // Background gradient
    c.drawRect(
      Rect.fromLTWH(0, 0, s.width, s.height),
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF020617), Color(0xFF0F172A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, s.width, s.height)),
    );
    // Stars
    final starP = Paint()..color = Colors.white.withOpacity(.6);
    for (final st in stars) c.drawCircle(st, 1, starP);
    // Player ship (triangle)
    final shipP = Paint()..color = const Color(0xFF6366F1);
    final path = Path()
      ..moveTo(px, py - 24)
      ..lineTo(px - 16, py + 16)
      ..lineTo(px, py + 8)
      ..lineTo(px + 16, py + 16)
      ..close();
    c.drawPath(path, shipP);
    // Engine glow
    c.drawCircle(
      Offset(px, py + 14),
      6,
      Paint()
        ..color = Colors.blueAccent.withOpacity(.7)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    // Bullets
    final bulletP = Paint()
      ..color = const Color(0xFFFCD34D)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    for (final b in bullets)
      c.drawRRect(
        RRect.fromRectAndRadius(b, const Radius.circular(3)),
        bulletP,
      );
    // Enemies
    final enemyP = Paint()..color = const Color(0xFFEF4444);
    for (final e in enemies) {
      c.drawRRect(RRect.fromRectAndRadius(e, const Radius.circular(8)), enemyP);
      c.drawCircle(
        e.center,
        6,
        Paint()
          ..color = Colors.orangeAccent.withOpacity(.8)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ShooterPainter old) => true;
}
