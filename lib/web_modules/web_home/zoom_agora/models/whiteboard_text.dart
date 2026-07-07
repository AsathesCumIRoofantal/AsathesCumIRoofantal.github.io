/// A text annotation placed on the whiteboard at a normalised (0–1) position.
/// Synced over the data channel the same way strokes are.
class WhiteboardText {
  final String id;
  final int uid;
  String text;
  final double x;   // normalised 0–1
  final double y;   // normalised 0–1
  final double fontSize;
  final int colorValue;
  final bool bold;
  final bool italic;

  WhiteboardText({
    required this.id,
    required this.uid,
    required this.text,
    required this.x,
    required this.y,
    this.fontSize = 18,
    this.colorValue = 0xFF000000,
    this.bold = false,
    this.italic = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'uid': uid,
    'text': text,
    'x': x,
    'y': y,
    'fs': fontSize,
    'c': colorValue,
    'b': bold ? 1 : 0,
    'i': italic ? 1 : 0,
  };

  factory WhiteboardText.fromJson(Map<String, dynamic> j) => WhiteboardText(
    id: j['id'] as String,
    uid: j['uid'] as int,
    text: j['text'] as String,
    x: (j['x'] as num).toDouble(),
    y: (j['y'] as num).toDouble(),
    fontSize: (j['fs'] as num?)?.toDouble() ?? 18,
    colorValue: j['c'] as int? ?? 0xFF000000,
    bold: j['b'] == 1,
    italic: j['i'] == 1,
  );
}
