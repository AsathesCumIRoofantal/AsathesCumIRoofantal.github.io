import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/whiteboard_stroke.dart';
import '../widgets/zoom_theme.dart';
import 'zoom_meeting_controller.dart';

class WhiteboardView extends StatefulWidget {
  const WhiteboardView({super.key});
  @override
  State<WhiteboardView> createState() => _WhiteboardViewState();
}

class _WhiteboardViewState extends State<WhiteboardView> {
  final controller = Get.find<ZoomMeetingController>();
  Color color = Colors.black;
  double width = 3;
  bool eraser = false;
  List<List<double>>? _current; // in-progress stroke, normalized points

  static const _palette = [
    Colors.black, Colors.red, Colors.blue, Colors.green,
    Colors.orange, Colors.purple,
  ];

  void _startStroke(Offset local, Size canvasSize) {
    setState(() => _current = [
      [local.dx / canvasSize.width, local.dy / canvasSize.height],
    ]);
  }

  void _extendStroke(Offset local, Size canvasSize) {
    if (_current == null) return;
    setState(() => _current!.add([local.dx / canvasSize.width, local.dy / canvasSize.height]));
  }

  void _endStroke() {
    if (_current == null || _current!.length < 2) {
      setState(() => _current = null);
      return;
    }
    final stroke = WhiteboardStroke(
      id: '${controller.localUid}_${DateTime.now().microsecondsSinceEpoch}',
      uid: controller.localUid,
      points: _current!,
      colorValue: color.value,
      strokeWidth: width,
      isEraser: eraser,
    );
    controller.addWhiteboardStroke(stroke);
    setState(() => _current = null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _toolbar(),
      Expanded(
        child: Container(
          color: Colors.white,
          child: LayoutBuilder(builder: (ctx, box) {
            final size = Size(box.maxWidth, box.maxHeight);
            return GestureDetector(
              onPanStart: (d) => _startStroke(d.localPosition, size),
              onPanUpdate: (d) => _extendStroke(d.localPosition, size),
              onPanEnd: (_) => _endStroke(),
              child: Obx(() => CustomPaint(
                size: size,
                painter: _WhiteboardPainter(
                  strokes: controller.whiteboardStrokes.toList(),
                  current: _current,
                  currentColor: eraser ? Colors.white : color,
                  currentWidth: eraser ? width * 4 : width,
                ),
              )),
            );
          }),
        ),
      ),
    ]);
  }

  Widget _toolbar() => Container(
    color: ZoomTheme.surface2,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(children: [
      for (final c in _palette)
        GestureDetector(
          onTap: () => setState(() { color = c; eraser = false; }),
          child: Container(
            width: 26, height: 26,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: c, shape: BoxShape.circle,
              border: Border.all(
                color: !eraser && color == c ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
          ),
        ),
      const SizedBox(width: 12),
      Expanded(
        child: Slider(
          value: width, min: 1, max: 12,
          activeColor: ZoomTheme.primary,
          onChanged: (v) => setState(() => width = v),
        ),
      ),
      IconButton(
        tooltip: 'Eraser',
        icon: Icon(Icons.auto_fix_normal, color: eraser ? ZoomTheme.primary : Colors.white70),
        onPressed: () => setState(() => eraser = !eraser),
      ),
      IconButton(
        tooltip: 'Clear board for everyone',
        icon: const Icon(Icons.delete_outline, color: Colors.white70),
        onPressed: controller.clearWhiteboard,
      ),
    ]),
  );
}

class _WhiteboardPainter extends CustomPainter {
  _WhiteboardPainter({required this.strokes, required this.current, required this.currentColor, required this.currentWidth});
  final List<WhiteboardStroke> strokes;
  final List<List<double>>? current;
  final Color currentColor;
  final double currentWidth;

  void _paintPoints(Canvas canvas, Size size, List<List<double>> points, Paint paint) {
    if (points.length < 2) return;
    final path = Path()..moveTo(points[0][0] * size.width, points[0][1] * size.height);
    for (final p in points.skip(1)) {
      path.lineTo(p[0] * size.width, p[1] * size.height);
    }
    canvas.drawPath(path, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final s in strokes) {
      final paint = Paint()
        ..color = s.isEraser ? Colors.white : Color(s.colorValue)
        ..strokeWidth = s.strokeWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      _paintPoints(canvas, size, s.points, paint);
    }
    if (current != null) {
      final paint = Paint()
        ..color = currentColor
        ..strokeWidth = currentWidth
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      _paintPoints(canvas, size, current!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WhiteboardPainter oldDelegate) =>
      oldDelegate.strokes.length != strokes.length || oldDelegate.current != current;
}
