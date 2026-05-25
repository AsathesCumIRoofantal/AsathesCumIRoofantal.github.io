import 'package:flutter/material.dart';
/// Drawing layer that floats over a shared screen.
class AnnotationLayer extends StatefulWidget {
  const AnnotationLayer({super.key});
  @override State<AnnotationLayer> createState()=>_S();
}
class _S extends State<AnnotationLayer>{
  final strokes=<List<Offset>>[]; List<Offset>? current; Color color=Colors.red; double width=4;
  @override Widget build(BuildContext c)=>GestureDetector(
    onPanStart: (d)=>setState(()=>current=[d.localPosition]),
    onPanUpdate:(d)=>setState(()=>current?.add(d.localPosition)),
    onPanEnd:   (_)=>setState((){ if(current!=null) strokes.add(current!); current=null; }),
    child: CustomPaint(painter:_P(strokes,current,color,width), size: Size.infinite),
  );
}
class _P extends CustomPainter{
  final List<List<Offset>> strokes; final List<Offset>? current; final Color color; final double width;
  _P(this.strokes,this.current,this.color,this.width);
  @override void paint(Canvas c, Size s){
    final p=Paint()..color=color..strokeWidth=width..strokeCap=StrokeCap.round..style=PaintingStyle.stroke;
    for (final s in [...strokes, if(current!=null) current!]){
      for (var i=0;i<s.length-1;i++) c.drawLine(s[i],s[i+1],p);
    }
  }
  @override bool shouldRepaint(covariant _P o)=>true;
}
