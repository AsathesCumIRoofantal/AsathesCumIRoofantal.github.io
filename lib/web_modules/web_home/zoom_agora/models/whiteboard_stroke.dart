/// One freehand stroke on the whiteboard. Points are normalized to 0..1
/// against the canvas size so the drawing lines up the same way on every
/// participant's screen regardless of their device's resolution.
class WhiteboardStroke {
  final String id;
  final int uid;
  final List<List<double>> points; // [[x0,y0],[x1,y1],...]
  final int colorValue; // Color(...).value
  final double strokeWidth;
  final bool isEraser;

  const WhiteboardStroke({
    required this.id,
    required this.uid,
    required this.points,
    required this.colorValue,
    required this.strokeWidth,
    this.isEraser = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'points': points,
    'color': colorValue,
    'width': strokeWidth,
    'eraser': isEraser,
  };

  factory WhiteboardStroke.fromJson(Map<String, dynamic> j) => WhiteboardStroke(
    id: j['id'] as String,
    uid: j['uid'] as int,
    points: (j['points'] as List)
        .map((p) => [(p[0] as num).toDouble(), (p[1] as num).toDouble()])
        .toList(),
    colorValue: j['color'] as int,
    strokeWidth: (j['width'] as num).toDouble(),
    isEraser: j['eraser'] as bool? ?? false,
  );
}
