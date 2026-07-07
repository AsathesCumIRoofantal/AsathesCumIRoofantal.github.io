import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'rtc_engine_interface.dart';
import 'web_input_injector.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CONTROL EVENT TYPES
// ─────────────────────────────────────────────────────────────────────────────

enum ControlEventType {
  /// Permission handshake
  controlRequest,
  controlGrant,
  controlDeny,
  controlRevoke,

  /// Input events
  mouseMove,
  mouseClick,
  mouseScroll,
  keyEvent,

  /// Clipboard
  clipboardSync,

  /// Heartbeat to keep control alive
  heartbeat,
}

enum MouseButton { left, right, middle }

enum InputEventAction { down, up, tap }

// ─────────────────────────────────────────────────────────────────────────────
// CONTROL EVENT MODEL
// ─────────────────────────────────────────────────────────────────────────────

/// A single remote-control event sent over the data channel.
class ControlEvent {
  final ControlEventType type;
  final int fromUid;
  final int toUid;
  final int timestamp;

  // Mouse move / click fields (normalised 0.0–1.0)
  final double? x;
  final double? y;
  final MouseButton? button;
  final InputEventAction? action;

  // Scroll
  final double? scrollDx;
  final double? scrollDy;

  // Key
  final int? keyCode;
  final int? modifiers; // bitmask: 1=shift, 2=ctrl, 4=alt, 8=meta
  final InputEventAction? keyAction;

  // Clipboard
  final String? clipboardText;

  const ControlEvent({
    required this.type,
    required this.fromUid,
    required this.toUid,
    int? timestamp,
    this.x,
    this.y,
    this.button,
    this.action,
    this.scrollDx,
    this.scrollDy,
    this.keyCode,
    this.modifiers,
    this.keyAction,
    this.clipboardText,
  }) : timestamp = timestamp ?? 0;

  // ── Factories ─────────────────────────────────────────────────────────

  factory ControlEvent.request(int fromUid, int toUid) => ControlEvent(
    type: ControlEventType.controlRequest,
    fromUid: fromUid,
    toUid: toUid,
    timestamp: DateTime.now().millisecondsSinceEpoch,
  );

  factory ControlEvent.grant(int fromUid, int toUid) => ControlEvent(
    type: ControlEventType.controlGrant,
    fromUid: fromUid,
    toUid: toUid,
    timestamp: DateTime.now().millisecondsSinceEpoch,
  );

  factory ControlEvent.deny(int fromUid, int toUid) => ControlEvent(
    type: ControlEventType.controlDeny,
    fromUid: fromUid,
    toUid: toUid,
    timestamp: DateTime.now().millisecondsSinceEpoch,
  );

  factory ControlEvent.revoke(int fromUid, int toUid) => ControlEvent(
    type: ControlEventType.controlRevoke,
    fromUid: fromUid,
    toUid: toUid,
    timestamp: DateTime.now().millisecondsSinceEpoch,
  );

  factory ControlEvent.mouseMove({
    required int fromUid,
    required int toUid,
    required double x,
    required double y,
  }) =>
      ControlEvent(
        type: ControlEventType.mouseMove,
        fromUid: fromUid,
        toUid: toUid,
        x: x,
        y: y,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

  factory ControlEvent.mouseClick({
    required int fromUid,
    required int toUid,
    required double x,
    required double y,
    MouseButton button = MouseButton.left,
    InputEventAction action = InputEventAction.tap,
  }) =>
      ControlEvent(
        type: ControlEventType.mouseClick,
        fromUid: fromUid,
        toUid: toUid,
        x: x,
        y: y,
        button: button,
        action: action,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

  factory ControlEvent.scroll({
    required int fromUid,
    required int toUid,
    required double dx,
    required double dy,
  }) =>
      ControlEvent(
        type: ControlEventType.mouseScroll,
        fromUid: fromUid,
        toUid: toUid,
        scrollDx: dx,
        scrollDy: dy,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

  factory ControlEvent.key({
    required int fromUid,
    required int toUid,
    required int keyCode,
    int modifiers = 0,
    InputEventAction action = InputEventAction.tap,
  }) =>
      ControlEvent(
        type: ControlEventType.keyEvent,
        fromUid: fromUid,
        toUid: toUid,
        keyCode: keyCode,
        modifiers: modifiers,
        keyAction: action,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

  factory ControlEvent.clipboard({
    required int fromUid,
    required int toUid,
    required String text,
  }) =>
      ControlEvent(
        type: ControlEventType.clipboardSync,
        fromUid: fromUid,
        toUid: toUid,
        clipboardText: text,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

  // ── Serialisation ─────────────────────────────────────────────────────

  Map<String, dynamic> toJson() => {
    '_ctrl': true, // marker so we can distinguish from chat data
    't': type.index,
    'f': fromUid,
    'to': toUid,
    'ts': timestamp,
    if (x != null) 'x': x,
    if (y != null) 'y': y,
    if (button != null) 'b': button!.index,
    if (action != null) 'a': action!.index,
    if (scrollDx != null) 'sdx': scrollDx,
    if (scrollDy != null) 'sdy': scrollDy,
    if (keyCode != null) 'k': keyCode,
    if (modifiers != null) 'm': modifiers,
    if (keyAction != null) 'ka': keyAction!.index,
    if (clipboardText != null) 'ct': clipboardText,
  };

  Uint8List toBytes() => Uint8List.fromList(utf8.encode(jsonEncode(toJson())));

  static ControlEvent? fromBytes(Uint8List bytes) {
    try {
      final json = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      if (json['_ctrl'] != true) return null;
      return ControlEvent(
        type: ControlEventType.values[json['t'] as int],
        fromUid: json['f'] as int,
        toUid: json['to'] as int,
        timestamp: json['ts'] as int? ?? 0,
        x: (json['x'] as num?)?.toDouble(),
        y: (json['y'] as num?)?.toDouble(),
        button: json['b'] != null ? MouseButton.values[json['b'] as int] : null,
        action: json['a'] != null ? InputEventAction.values[json['a'] as int] : null,
        scrollDx: (json['sdx'] as num?)?.toDouble(),
        scrollDy: (json['sdy'] as num?)?.toDouble(),
        keyCode: json['k'] as int?,
        modifiers: json['m'] as int?,
        keyAction: json['ka'] != null
            ? InputEventAction.values[json['ka'] as int]
            : null,
        clipboardText: json['ct'] as String?,
      );
    } catch (_) {
      return null;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REMOTE CONTROL SERVICE
// ─────────────────────────────────────────────────────────────────────────────

/// Manages the AnyDesk-style remote control lifecycle:
/// permission handshake, throttled event sending, and incoming event dispatch.
class RemoteControlService {
  RemoteControlService(this._engine);
  final RtcEngineInterface _engine;
  final _injector = const WebInputInjector();

  // ── Observable state ──────────────────────────────────────────────────

  /// UID of the user we are currently controlling (null = not controlling anyone).
  final controllingUid = Rxn<int>();

  /// UID of the user currently controlling US (null = nobody).
  final controlledByUid = Rxn<int>();

  /// Pending incoming request (uid that wants to control us).
  final pendingRequestFromUid = Rxn<int>();

  /// Remote cursor position (normalised 0–1), observed to render cursor overlay.
  final remoteCursorX = 0.0.obs;
  final remoteCursorY = 0.0.obs;
  final showRemoteCursor = false.obs;

  bool get isControlling => controllingUid.value != null;
  bool get isBeingControlled => controlledByUid.value != null;

  // ── Internals ─────────────────────────────────────────────────────────

  final _eventCtrl = StreamController<ControlEvent>.broadcast();
  Stream<ControlEvent> get onControlEvent => _eventCtrl.stream;

  StreamSubscription? _dataSub;
  DateTime _lastMouseMoveSent = DateTime.now();
  Timer? _heartbeatTimer;
  Timer? _watchdogTimer;
  DateTime _lastHeartbeat = DateTime.fromMillisecondsSinceEpoch(0);
  int _localUid = 0;

  /// Minimum interval between mouse-move sends (≈60 fps cap).
  static const _mouseMoveThrottleMs = 16;

  // ── Lifecycle ─────────────────────────────────────────────────────────

  void start({required int localUid}) {
    _localUid = localUid;
    _dataSub = _engine.events
        .where((e) => e.type == RtcEventType.dataMessageReceived)
        .listen(_handleDataMessage);
  }

  void stop() {
    _dataSub?.cancel();
    _heartbeatTimer?.cancel();
    _watchdogTimer?.cancel();
    controllingUid.value = null;
    controlledByUid.value = null;
    pendingRequestFromUid.value = null;
    showRemoteCursor.value = false;
  }

  // ── Permission flow ───────────────────────────────────────────────────

  /// Request control of [targetUid]'s screen.
  Future<void> requestControl(int targetUid, int localUid) async {
    final evt = ControlEvent.request(localUid, targetUid);
    await _engine.sendDataMessage(evt.toBytes());
    debugPrint('🎮 Sent control request to UID $targetUid');
  }

  /// Grant control to the requesting user.
  Future<void> grantControl(int requesterUid, int localUid) async {
    controlledByUid.value = requesterUid;
    pendingRequestFromUid.value = null;
    final evt = ControlEvent.grant(localUid, requesterUid);
    await _engine.sendDataMessage(evt.toBytes());
    debugPrint('🎮 Granted control to UID $requesterUid');

    _lastHeartbeat = DateTime.now();
    _watchdogTimer?.cancel();
    _watchdogTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      if (!isBeingControlled) return;
      if (DateTime.now().difference(_lastHeartbeat).inSeconds > 15) {
        await revokeControl(_localUid);
      }
    });
  }

  /// Deny a pending control request.
  Future<void> denyControl(int requesterUid, int localUid) async {
    pendingRequestFromUid.value = null;
    final evt = ControlEvent.deny(localUid, requesterUid);
    await _engine.sendDataMessage(evt.toBytes());
  }

  /// Revoke control (either side can call).
  Future<void> revokeControl(int localUid) async {
    final targetUid = controllingUid.value ?? controlledByUid.value;
    if (targetUid == null) return;
    controllingUid.value = null;
    controlledByUid.value = null;
    showRemoteCursor.value = false;
    _heartbeatTimer?.cancel();
    _watchdogTimer?.cancel();
    final evt = ControlEvent.revoke(localUid, targetUid);
    await _engine.sendDataMessage(evt.toBytes());
    debugPrint('🎮 Revoked control');
  }

  // ── Sending input events (controller side) ────────────────────────────

  /// Throttled mouse move — skips if called faster than 60fps.
  Future<void> sendMouseMove(int localUid, double x, double y) async {
    final now = DateTime.now();
    if (now.difference(_lastMouseMoveSent).inMilliseconds <
        _mouseMoveThrottleMs) {
      return;
    }
    _lastMouseMoveSent = now;
    final targetUid = controllingUid.value;
    if (targetUid == null) return;
    final evt = ControlEvent.mouseMove(
      fromUid: localUid,
      toUid: targetUid,
      x: x,
      y: y,
    );
    await _engine.sendDataMessage(evt.toBytes());
  }

  Future<void> sendMouseClick(
    int localUid,
    double x,
    double y, {
    MouseButton button = MouseButton.left,
    InputEventAction action = InputEventAction.tap,
  }) async {
    final targetUid = controllingUid.value;
    if (targetUid == null) return;
    final evt = ControlEvent.mouseClick(
      fromUid: localUid,
      toUid: targetUid,
      x: x,
      y: y,
      button: button,
      action: action,
    );
    await _engine.sendDataMessage(evt.toBytes());
  }

  Future<void> sendScroll(int localUid, double dx, double dy) async {
    final targetUid = controllingUid.value;
    if (targetUid == null) return;
    final evt = ControlEvent.scroll(
      fromUid: localUid,
      toUid: targetUid,
      dx: dx,
      dy: dy,
    );
    await _engine.sendDataMessage(evt.toBytes());
  }

  Future<void> sendKeyEvent(
    int localUid, {
    required int keyCode,
    int modifiers = 0,
    InputEventAction action = InputEventAction.tap,
  }) async {
    final targetUid = controllingUid.value;
    if (targetUid == null) return;
    final evt = ControlEvent.key(
      fromUid: localUid,
      toUid: targetUid,
      keyCode: keyCode,
      modifiers: modifiers,
      action: action,
    );
    await _engine.sendDataMessage(evt.toBytes());
  }

  Future<void> sendClipboard(int localUid, String text) async {
    final targetUid = controllingUid.value;
    if (targetUid == null) return;
    final evt = ControlEvent.clipboard(
      fromUid: localUid,
      toUid: targetUid,
      text: text,
    );
    await _engine.sendDataMessage(evt.toBytes());
  }

  // ── Receiving ─────────────────────────────────────────────────────────

  void _handleDataMessage(RtcEvent rtcEvent) {
    final bytes = rtcEvent.data['bytes'] as Uint8List?;
    if (bytes == null) return;
    final ctrl = ControlEvent.fromBytes(bytes);
    if (ctrl == null) return; // not a control message

    switch (ctrl.type) {
      case ControlEventType.controlRequest:
        pendingRequestFromUid.value = ctrl.fromUid;
        break;
      case ControlEventType.controlGrant:
        controllingUid.value = ctrl.fromUid;
        debugPrint('🎮 Control granted by UID ${ctrl.fromUid}');
        _heartbeatTimer?.cancel();
        _heartbeatTimer = Timer.periodic(const Duration(seconds: 5), (_) {
          final target = controllingUid.value;
          if (target == null) return;
          final hb = ControlEvent(
            type: ControlEventType.heartbeat,
            fromUid: _localUid,
            toUid: target,
            timestamp: DateTime.now().millisecondsSinceEpoch,
          );
          _engine.sendDataMessage(hb.toBytes());
        });
        break;
      case ControlEventType.controlDeny:
        debugPrint('🎮 Control denied by UID ${ctrl.fromUid}');
        break;
      case ControlEventType.controlRevoke:
        controllingUid.value = null;
        controlledByUid.value = null;
        showRemoteCursor.value = false;
        _heartbeatTimer?.cancel();
        _watchdogTimer?.cancel();
        debugPrint('🎮 Control revoked by UID ${ctrl.fromUid}');
        break;
      case ControlEventType.mouseMove:
        remoteCursorX.value = ctrl.x ?? 0;
        remoteCursorY.value = ctrl.y ?? 0;
        showRemoteCursor.value = true;
        _injector.mouseMove(remoteCursorX.value, remoteCursorY.value);
        break;
      case ControlEventType.mouseClick:
        _injector.mouseClick(ctrl.x ?? 0, ctrl.y ?? 0);
        break;
      case ControlEventType.mouseScroll:
        _injector.mouseScroll(ctrl.scrollDx ?? 0, ctrl.scrollDy ?? 0);
        break;
      case ControlEventType.keyEvent:
        _injector.keyEvent(
          ctrl.keyCode ?? 0,
          modifiers: ctrl.modifiers ?? 0,
          action: (ctrl.keyAction == InputEventAction.down)
              ? 'down'
              : (ctrl.keyAction == InputEventAction.up ? 'up' : 'tap'),
        );
        break;
      case ControlEventType.clipboardSync:
        final t = ctrl.clipboardText;
        if (t != null) {
          Clipboard.setData(ClipboardData(text: t));
          // Web may also need Clipboard API explicitly.
          _injector.clipboardWrite(t);
        }
        break;
      case ControlEventType.heartbeat:
        _lastHeartbeat = DateTime.now();
        break;
    }
    _eventCtrl.add(ctrl);
  }

  void dispose() {
    stop();
    _eventCtrl.close();
  }
}
