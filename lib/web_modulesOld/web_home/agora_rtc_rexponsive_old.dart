// // webrtc_web_interop.dart
// import 'dart:js_interop';
// import 'package:web/web.dart' as web;

// @JS('window')
// external web.Window get window;

// class CustomWebRTCWeb {
//   late web.RTCPeerConnection _peerConnection;
//   web.MediaStream? _localStream;

//   // Initialize a native browser Peer Connection
//   void initializePeer() {
//     final config = web.RTCConfiguration(
//       iceServers: [
//         web.RTCIceServer(urls: ['stun:://google.com'].toJS),
//       ].toJS,
//     );
//     _peerConnection = web.RTCPeerConnection(config);
//   }

//   // Request browser camera and microphone
//   Future<web.MediaStream> getUserMedia() async {
//     final constraints = web.MediaStreamConstraints(
//       video: true.toJS,
//       audio: true.toJS,
//     );

//     final mediaDevices = window.navigator.mediaDevices;
//     final promise = mediaDevices.getUserMedia(constraints);

//     // Convert JS Promise to Dart Future
//     _localStream = await promise.toDart;
//     return _localStream!;
//   }
// }
