// video_render_widget.dart
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;

class CustomWebVideoPlayer extends StatefulWidget {
  final web.MediaStream stream;
  const CustomWebVideoPlayer({required this.stream, super.key});

  @override
  State<CustomWebVideoPlayer> createState() => _CustomWebVideoPlayerState();
}

class _CustomWebVideoPlayerState extends State<CustomWebVideoPlayer> {
  late String _viewId;
  late web.HTMLVideoElement _videoElement;

  @override
  void initState() {
    super.initState();
    // Unique ID for the factory registration
    _viewId = 'video-view-${DateTime.now().millisecondsSinceEpoch}';

    // Create the HTML Video Element natively
    _videoElement = web.HTMLVideoElement()
      ..srcObject = widget.stream
      ..autoplay = true
      ..playsInline = true;
    _videoElement.style.width = '100%';
    _videoElement.style.height = '100%';
    _videoElement.style.objectFit = 'cover';

    // Register the element with Flutter Web's platform view registry
    ui_web.platformViewRegistry.registerViewFactory(
      _viewId,
      (int viewId) => _videoElement,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 300,
      child: HtmlElementView(viewType: _viewId),
    );
  }
}
