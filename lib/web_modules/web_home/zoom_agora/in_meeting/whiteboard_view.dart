import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/whiteboard_stroke.dart';
import '../models/whiteboard_text.dart';
import '../models/participant.dart';
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
  bool textTool = false;
  List<List<double>>? _current; // in-progress stroke, normalized points

  bool get _isHost =>
      controller.participants[controller.localUid]?.role == ParticipantRole.host;

  bool get _isLockedForMe =>
      controller.whiteboardLocked.value &&
      controller.participants[controller.localUid]?.role == ParticipantRole.attendee;

  static const _palette = [
    Colors.black, Colors.red, Colors.blue, Colors.green,
    Colors.orange, Colors.purple,
  ];

  void _startStroke(Offset local, Size canvasSize) {
    if (_isLockedForMe) return;
    if (textTool) return;
    setState(() => _current = [
      [local.dx / canvasSize.width, local.dy / canvasSize.height],
    ]);
  }

  void _extendStroke(Offset local, Size canvasSize) {
    if (_isLockedForMe) return;
    if (textTool || _current == null) return;
    setState(() => _current!.add([local.dx / canvasSize.width, local.dy / canvasSize.height]));
  }

  void _endStroke() {
    if (_isLockedForMe) { setState(() => _current = null); return; }
    if (textTool || _current == null || _current!.length < 2) {
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

  void _handleTap(Offset local, Size canvasSize) {
    if (_isLockedForMe) return;
    if (!textTool) return;
    final nx = local.dx / canvasSize.width;
    final ny = local.dy / canvasSize.height;
    _showTextPopup(nx, ny);
  }

  Future<void> _showTextPopup(double nx, double ny, [WhiteboardText? existing]) async {
    final textCtrl = TextEditingController(text: existing?.text ?? '');
    double fontSize = existing?.fontSize ?? 18;
    bool bold = existing?.bold ?? false;
    bool italic = existing?.italic ?? false;
    Color selectedColor = existing != null ? Color(existing.colorValue) : color;

    await Get.dialog(
      StatefulBuilder(builder: (ctx, setS) => AlertDialog(
        backgroundColor: ZoomTheme.surface2,
        title: Text(existing == null ? 'Add text' : 'Edit text',
            style: const TextStyle(color: Colors.white)),
        content: SizedBox(width: 340, child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: textCtrl,
            autofocus: true,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Type your text…',
              hintStyle: const TextStyle(color: ZoomTheme.textMuted),
              filled: true, fillColor: ZoomTheme.surface,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 12),
          Row(children: [
            const Text('Size', style: TextStyle(color: ZoomTheme.textMuted, fontSize: 12)),
            Expanded(child: Slider(
              value: fontSize, min: 10, max: 48, divisions: 19,
              activeColor: ZoomTheme.primary,
              onChanged: (v) => setS(() => fontSize = v),
            )),
            Text('${fontSize.round()}', style: const TextStyle(color: Colors.white, fontSize: 12)),
          ]),
          Row(children: [
            ToggleButtons(
              isSelected: [bold, italic],
              onPressed: (i) => setS(() { if (i == 0) bold = !bold; else italic = !italic; }),
              borderColor: ZoomTheme.stroke,
              selectedBorderColor: ZoomTheme.primary,
              selectedColor: ZoomTheme.primary,
              color: ZoomTheme.textMuted,
              borderRadius: BorderRadius.circular(8),
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('B', style: TextStyle(fontWeight: FontWeight.bold))),
                Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('I', style: TextStyle(fontStyle: FontStyle.italic))),
              ],
            ),
            const SizedBox(width: 12),
            ...([Colors.black, Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.white]).map((c) =>
              GestureDetector(
                onTap: () => setS(() => selectedColor = c),
                child: Container(
                  width: 22, height: 22, margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: c, shape: BoxShape.circle,
                    border: Border.all(color: selectedColor == c ? Colors.white : Colors.transparent, width: 2),
                  ),
                ),
              )),
          ]),
        ])),
        actions: [
          if (existing != null)
            TextButton(
              onPressed: () {
                controller.deleteWhiteboardText(existing.id);
                Get.back();
              },
              child: const Text('Delete', style: TextStyle(color: ZoomTheme.danger)),
            ),
          TextButton(onPressed: Get.back, child: const Text('Cancel', style: TextStyle(color: ZoomTheme.textMuted))),
          FilledButton(
            onPressed: () {
              if (textCtrl.text.trim().isEmpty) return;
              if (existing != null) {
                // Delete old copy for everyone, then broadcast the new one.
                controller.deleteWhiteboardText(existing.id);
              }
              final t = WhiteboardText(
                id: '${controller.localUid}_${DateTime.now().microsecondsSinceEpoch}',
                uid: controller.localUid,
                text: textCtrl.text.trim(),
                x: nx, y: ny,
                fontSize: fontSize,
                colorValue: selectedColor.value,
                bold: bold, italic: italic,
              );
              controller.addWhiteboardText(t);
              Get.back();
            },
            child: Text(existing == null ? 'Add' : 'Save'),
          ),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: [
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
              onTapUp: (d) => _handleTap(d.localPosition, size),
              child: Stack(children: [
                Obx(() => CustomPaint(
                  size: size,
                  painter: _WhiteboardPainter(
                    strokes: controller.whiteboardStrokes.toList(),
                    current: _current,
                    currentColor: eraser ? Colors.white : color,
                    currentWidth: eraser ? width * 4 : width,
                  ),
                )),
                // Text annotations rendered as positioned widgets so they can be tapped
                ...controller.whiteboardTexts.map((t) => Positioned(
                  left: t.x * size.width,
                  top: t.y * size.height,
                  child: GestureDetector(
                    onLongPress: () {
                      // Owner can always edit; host can delete anyone's text
                      if (t.uid == controller.localUid || _isHost) {
                        _showTextPopup(t.x, t.y, t);
                      }
                    },
                    child: Text(
                      t.text,
                      style: TextStyle(
                        fontSize: t.fontSize,
                        color: Color(t.colorValue),
                        fontWeight: t.bold ? FontWeight.bold : FontWeight.normal,
                        fontStyle: t.italic ? FontStyle.italic : FontStyle.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                )),
              ]),
            );
          }),
        ),
      ),
    ]));
  }

  Widget _toolbar() => Container(
    color: ZoomTheme.surface2,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(children: [
      for (final c in _palette)
        GestureDetector(
          onTap: () => setState(() { color = c; eraser = false; textTool = false; }),
          child: Container(
            width: 26, height: 26,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: c, shape: BoxShape.circle,
              border: Border.all(
                color: (!eraser && !textTool && color == c) ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
          ),
        ),
      const SizedBox(width: 8),
      // Text tool
      IconButton(
        tooltip: 'Add text',
        icon: Icon(Icons.text_fields_rounded,
            color: textTool ? ZoomTheme.primary : Colors.white70),
        onPressed: () => setState(() { textTool = !textTool; eraser = false; }),
      ),
      Expanded(
        child: Slider(
          value: width, min: 1, max: 12,
          activeColor: ZoomTheme.primary,
          onChanged: (v) => setState(() => width = v),
        ),
      ),
      IconButton(
        tooltip: 'Eraser',
        icon: Icon(Icons.auto_fix_normal,
            color: eraser ? ZoomTheme.primary : Colors.white70),
        onPressed: () => setState(() { eraser = !eraser; textTool = false; }),
      ),
      // Lock board (host only)
      if (_isHost)
        Obx(() => IconButton(
          tooltip: controller.whiteboardLocked.value ? 'Unlock board' : 'Lock board',
          icon: Icon(
            controller.whiteboardLocked.value ? Icons.lock : Icons.lock_open,
            color: controller.whiteboardLocked.value ? ZoomTheme.danger : Colors.white70,
          ),
          onPressed: controller.toggleWhiteboardLock,
        )),
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
