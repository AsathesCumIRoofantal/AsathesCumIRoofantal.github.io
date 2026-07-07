import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';

enum _Dir { up, down, left, right }

class _SnakeController extends GetxController {
  static const _cols = 20, _rows = 28;
  final score  = 0.obs;
  final isOver = false.obs;
  List<Point<int>> snake = [const Point(10, 14), const Point(10, 15)];
  Point<int> food = const Point(5, 5);
  _Dir dir = _Dir.up;
  _Dir _next = _Dir.up;
  final _rng = Random();
  Timer? _timer;

  @override void onInit() { super.onInit(); _spawnFood(); _startTimer(); }
  @override void onClose() { _timer?.cancel(); super.onClose(); }

  void setDir(_Dir d) {
    if ((d == _Dir.up && dir == _Dir.down) || (d == _Dir.down && dir == _Dir.up) ||
        (d == _Dir.left && dir == _Dir.right) || (d == _Dir.right && dir == _Dir.left)) return;
    _next = d;
  }

  void restart() { snake = [const Point(10,14), const Point(10,15)]; dir = _Dir.up;
    _next = _Dir.up; score.value = 0; isOver.value = false; _spawnFood(); _startTimer(); }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 150), (_) => _step());
  }

  void _step() {
    if (isOver.value) return;
    dir = _next;
    final head = snake.first;
    Point<int> next;
    switch (dir) {
      case _Dir.up:    next = Point(head.x, (head.y - 1 + _rows) % _rows); break;
      case _Dir.down:  next = Point(head.x, (head.y + 1) % _rows);         break;
      case _Dir.left:  next = Point((head.x - 1 + _cols) % _cols, head.y); break;
      case _Dir.right: next = Point((head.x + 1) % _cols, head.y);         break;
    }
    if (snake.contains(next)) { _timer?.cancel(); isOver.value = true; return; }
    snake = [next, ...snake];
    if (next == food) { score.value += 10; _spawnFood(); } else { snake.removeLast(); }
    isOver.refresh();
  }

  void _spawnFood() {
    do { food = Point(_rng.nextInt(_cols), _rng.nextInt(_rows)); }
    while (snake.contains(food));
  }
}

class SnakeEntry extends StatelessWidget {
  const SnakeEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(_SnakeController());
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (e) {
        if (e is! RawKeyDownEvent) return;
        if (e.logicalKey == LogicalKeyboardKey.arrowUp)    c.setDir(_Dir.up);
        if (e.logicalKey == LogicalKeyboardKey.arrowDown)  c.setDir(_Dir.down);
        if (e.logicalKey == LogicalKeyboardKey.arrowLeft)  c.setDir(_Dir.left);
        if (e.logicalKey == LogicalKeyboardKey.arrowRight) c.setDir(_Dir.right);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF052E16),
        body: SafeArea(child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              IconButton(icon: const Icon(Icons.arrow_back_rounded, color: Colors.white70), onPressed: Get.back),
              const Spacer(),
              Obx(() => Text('🍎 ${c.score.value}',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
              const Spacer(),
            ]),
          ),
          Expanded(child: Obx(() => Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: AspectRatio(
                aspectRatio: _SnakeController._cols / _SnakeController._rows,
                child: CustomPaint(
                  painter: _SnakePainter(snake: c.snake, food: c.food),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            if (c.isOver.value)
              Container(color: Colors.black87, child: Center(child: Column(
                mainAxisSize: MainAxisSize.min, children: [
                  const Text('GAME OVER', style: TextStyle(color: Colors.greenAccent,
                      fontSize: 30, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Obx(() => Text('Score: ${c.score.value}', style: const TextStyle(color: Colors.white, fontSize: 18))),
                  const SizedBox(height: 16),
                  FilledButton(onPressed: c.restart,
                    style: FilledButton.styleFrom(backgroundColor: const Color(0xFF22C55E)),
                    child: const Text('Play again')),
                ],
              ))),
          ]))),
          // D-pad for mobile
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(children: [
              _dpad(Icons.keyboard_arrow_up_rounded,    () => c.setDir(_Dir.up)),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                _dpad(Icons.keyboard_arrow_left_rounded, () => c.setDir(_Dir.left)),
                const SizedBox(width: 48),
                _dpad(Icons.keyboard_arrow_right_rounded,() => c.setDir(_Dir.right)),
              ]),
              _dpad(Icons.keyboard_arrow_down_rounded,  () => c.setDir(_Dir.down)),
            ]),
          ),
        ])),
      ),
    );
  }

  Widget _dpad(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 48, height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF166534), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF22C55E).withOpacity(.5)),
      ),
      child: Icon(icon, color: const Color(0xFF22C55E)),
    ),
  );
}

class _SnakePainter extends CustomPainter {
  _SnakePainter({required this.snake, required this.food});
  final List<Point<int>> snake;
  final Point<int> food;

  @override
  void paint(Canvas c, Size s) {
    final cw = s.width  / _SnakeController._cols;
    final ch = s.height / _SnakeController._rows;
    // Grid
    final gridP = Paint()..color = const Color(0xFF14532D).withOpacity(.4)..style = PaintingStyle.stroke..strokeWidth = .5;
    for (var x = 0; x <= _SnakeController._cols; x++) c.drawLine(Offset(x * cw, 0), Offset(x * cw, s.height), gridP);
    for (var y = 0; y <= _SnakeController._rows; y++) c.drawLine(Offset(0, y * ch), Offset(s.width, y * ch), gridP);
    // Food
    c.drawCircle(Offset((food.x + .5) * cw, (food.y + .5) * ch), cw * .4,
      Paint()..color = const Color(0xFFEF4444)
             ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4));
    // Snake
    for (var i = 0; i < snake.length; i++) {
      final p = snake[i];
      final r = RRect.fromRectAndRadius(
        Rect.fromLTWH(p.x * cw + 1, p.y * ch + 1, cw - 2, ch - 2),
        const Radius.circular(4),
      );
      c.drawRRect(r, Paint()..color = i == 0 ? const Color(0xFF4ADE80) : const Color(0xFF22C55E));
    }
  }
  @override bool shouldRepaint(covariant _SnakePainter o) =>
      o.snake != snake || o.food != food;
}
