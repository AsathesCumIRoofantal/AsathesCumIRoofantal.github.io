# Making 2D & 3D Games with Flutter
### A complete developer handbook — packages, architecture, patterns, and full examples

> **Who this is for:** Flutter developers who know widgets and GetX, and want to build real games — from simple 2D arcade to full 3D worlds — using the Flutter/Dart ecosystem in 2026.

---

## TABLE OF CONTENTS

1. [Why Flutter for games?](#1-why-flutter-for-games)
2. [The engine landscape](#2-the-engine-landscape)
3. [2D Games — Flame engine deep dive](#3-2d-games--flame-engine)
4. [2D without Flame — CustomPainter approach](#4-2d-without-flame--custompainter)
5. [3D Games — Flutter GPU & Impeller](#5-3d-games--flutter-gpu--impeller)
6. [3D with three_dart](#6-3d-with-three_dart)
7. [3D with Babylon.js inside Flutter Web](#7-3d-with-babylonjs-inside-flutter-web)
8. [Physics engines](#8-physics-engines)
9. [Input handling](#9-input-handling)
10. [Audio — bgm, sfx, spatial](#10-audio)
11. [State management for games (GetX pattern)](#11-state-management-for-games)
12. [Asset pipeline — sprites, atlases, tilemaps](#12-asset-pipeline)
13. [Networking — multiplayer](#13-networking--multiplayer)
14. [Community packages cheatsheet](#14-community-packages-cheatsheet)
15. [Complete 2D game example — Space Shooter](#15-complete-2d-example--space-shooter)
16. [Complete 3D scene example — Spinning planet](#16-complete-3d-example--spinning-planet)
17. [Performance tips](#17-performance-tips)
18. [Publishing — Android, iOS, Web, Desktop](#18-publishing)

---

## 1. WHY FLUTTER FOR GAMES?

Flutter's rendering pipeline (Impeller on iOS/Android, Skia fallback on older devices) draws directly to a GPU surface at 60/120 fps. There is no DOM, no layout recalculation on every frame — just a rasterized scene rebuilt from a retained widget tree or a raw canvas. That makes it fast enough for serious 2D games and increasingly capable for 3D.

**Strengths:**
- Single codebase → Android, iOS, Web, Windows, macOS, Linux
- Hot reload shortens the game-feel iteration loop dramatically
- Dart is fast (AOT compiled), GC pauses are short and predictable
- Flame (2D) has a large, active community and is production-proven
- Flutter GPU (3D, 2026) gives direct access to the Impeller HAL

**Honest limits:**
- No built-in scene graph for 3D (you bring your own or use Flutter GPU)
- Shader compilation stutter on first run (Impeller mostly solves this)
- No native Vulkan/Metal API surface from Dart (Flutter GPU is the bridge)
- Heavy 3D worlds still belong in Unity/Godot exported as a Flutter plugin

---

## 2. THE ENGINE LANDSCAPE

| Approach | Best for | Package | Maturity |
|---|---|---|---|
| **Flame** | 2D arcade, RPG, platformer | `flame ^1.18.0` | Production ✅ |
| **CustomPainter loop** | Simple 2D, data viz games | Flutter SDK | Production ✅ |
| **Flutter GPU** | 3D scenes, custom shaders | `flutter_gpu` (SDK, 2026) | Beta ⚡ |
| **three_dart** | Three.js-style 3D in Flutter Web | `three_dart ^0.0.16` | Experimental 🧪 |
| **Babylon.js in WebView** | Full 3D world, Web only | `webview_flutter` | Production (Web) ✅ |
| **Unity as a plugin** | AAA-quality 3D, mobile | `flutter_unity_widget` | Production ✅ |
| **Godot as plugin** | Open-source 3D | `godot_flutter` | Experimental 🧪 |


---

## 3. 2D GAMES — FLAME ENGINE

### 3.1 Install

```yaml
# pubspec.yaml
dependencies:
  flame: ^1.18.0
  flame_audio: ^2.10.0       # bgm + sfx
  flame_tiled: ^1.18.0       # Tiled map editor support
  flame_forge2d: ^0.18.0     # Box2D physics integration
  flame_lottie: ^0.4.0       # Lottie animations as Flame components
```

### 3.2 Core concepts

```
FlameGame                  ← root game class (extends Game)
  └── World                ← contains all game objects
        └── Component      ← every object in the game
              ├── PositionComponent  (has x, y, size, angle)
              ├── SpriteComponent    (renders a sprite)
              ├── SpriteAnimationComponent (frame animation)
              ├── TextComponent      (in-game text)
              └── ShapeComponent     (hitbox, collisions)
```

Flame uses a **game loop** — `update(double dt)` is called every frame with delta time in seconds. `render(Canvas canvas)` draws it.

### 3.3 Minimal Flame game

```dart
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  late SpriteComponent _player;

  @override
  Future<void> onLoad() async {
    // Load sprite from assets/images/player.png
    final sprite = await loadSprite('player.png');
    _player = SpriteComponent(
      sprite: sprite,
      size: Vector2(64, 64),
      position: size / 2,       // center of screen
    );
    world.add(_player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _player.position.x += 100 * dt; // move right at 100 px/s
  }
}
```

### 3.4 Sprite animation

```dart
// Load a sprite sheet with 8 frames, each 64x64
final animationData = SpriteAnimationData.sequenced(
  amount: 8,
  stepTime: 0.1,      // seconds per frame
  textureSize: Vector2.all(64),
);
final animation = await game.loadSpriteAnimation('run.png', animationData);
final animComp = SpriteAnimationComponent(animation: animation, size: Vector2(64, 64));
world.add(animComp);
```

### 3.5 Collision detection

```dart
// Add a hitbox to a component
class Player extends SpriteComponent with CollisionCallbacks {
  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());   // or CircleHitbox(), PolygonHitbox()
  }

  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    if (other is Enemy) { takeDamage(); }
  }
}

// Enable collision detection in the game
class MyGame extends FlameGame with HasCollisionDetection { ... }
```

### 3.6 Camera and viewport

```dart
// Follow the player smoothly
camera.follow(player, maxSpeed: 150); // 150 px/s max follow speed

// Set a world boundary (player can't go past it)
camera.setBounds(Rectangle.fromLTWH(0, 0, 3000, 2000));

// Zoom in / out
camera.viewfinder.zoom = 1.5;
```

### 3.7 Tiled map (tilemap editor support)

```dart
// Load a .tmx map created in Tiled editor
final tiled = await TiledComponent.load('level1.tmx', Vector2.all(16));
world.add(tiled);
// Access object layers for spawn points
final spawnLayer = tiled.tileMap.getObjectGroupFromLayer('spawns');
```


---

## 4. 2D WITHOUT FLAME — CustomPainter APPROACH

When you don't need a full game engine (particle systems, ECS, physics) but want smooth 60 fps animation with full control, use a `CustomPainter` driven by a `Ticker`.

```dart
class GameCanvas extends StatefulWidget {
  const GameCanvas({super.key});
  @override State<GameCanvas> createState() => _GameCanvasState();
}

class _GameCanvasState extends State<GameCanvas>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _elapsed = Duration.zero;

  // Game state
  double _ballX = 100, _ballY = 100;
  double _vx = 200, _vy = 150; // pixels per second

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick)..start();
  }

  void _onTick(Duration elapsed) {
    final dt = (elapsed - _elapsed).inMicroseconds / 1e6;
    _elapsed = elapsed;
    setState(() {
      _ballX += _vx * dt;
      _ballY += _vy * dt;
      // Bounce off walls (assume 400x800 canvas)
      if (_ballX < 0 || _ballX > 400) _vx = -_vx;
      if (_ballY < 0 || _ballY > 800) _vy = -_vy;
    });
  }

  @override
  void dispose() { _ticker.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _BallPainter(_ballX, _ballY),
    child: const SizedBox.expand(),
  );
}

class _BallPainter extends CustomPainter {
  _BallPainter(this.x, this.y);
  final double x, y;
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset(x, y), 20,
      Paint()..color = Colors.redAccent,
    );
  }
  @override bool shouldRepaint(_BallPainter old) => true;
}
```

**When to use this over Flame:**
- Puzzle games, board games, card games
- Data-driven animations (charts that animate like games)
- Games embedded inside a normal Flutter app without a full `GameWidget`

---

## 5. 3D GAMES — Flutter GPU & IMPELLER

Flutter GPU (available in Flutter master/beta, 2026) gives Dart code direct access to Impeller's rendering HAL — you can write vertex shaders, fragment shaders, and build a scene graph from scratch.

### 5.1 Enable Flutter GPU

```yaml
# pubspec.yaml
dependencies:
  flutter_gpu: any      # tracks Flutter SDK version

# In flutter section:
flutter:
  shaders:
    - shaders/my_vertex.glsl
    - shaders/my_fragment.glsl
```

```dart
// main.dart — requires Impeller enabled
void main() {
  // Impeller is default on iOS since Flutter 3.10
  // Android: --enable-impeller flag or AndroidManifest meta-data
  runApp(const MyApp());
}
```

### 5.2 Minimal Flutter GPU triangle

```dart
import 'package:flutter_gpu/flutter_gpu.dart' as gpu;

class GpuTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Get the GPU context
    final ctx = gpu.gpuContext;

    // Create a render target
    final rt = gpu.RenderTarget.singleColor(
      gpu.ColorAttachment(
        texture: ctx.createTexture(
          gpu.StorageMode.devicePrivate,
          size.width.toInt(), size.height.toInt(),
        ),
      ),
    );

    final cmd = ctx.createCommandBuffer();
    final pass = cmd.createRenderPass(rt);

    // Load compiled shader bundle
    final lib = gpu.ShaderLibrary.fromAsset('shaders/triangle.shaderbundle')!;
    final vert = lib['TriangleVertex']!;
    final frag = lib['TriangleFragment']!;
    final pipeline = ctx.createRenderPipeline(vert, frag);

    pass.bindPipeline(pipeline);

    // Vertex buffer: 3 x (x, y) pairs in NDC
    final vertices = Float32List.fromList([
       0.0,  0.5,   // top
      -0.5, -0.5,   // bottom-left
       0.5, -0.5,   // bottom-right
    ]);
    final vbo = ctx.createDeviceBufferWithCopy(
      ByteData.sublistView(vertices));
    pass.bindVertexBuffer(gpu.BufferView(vbo, offsetInBytes: 0,
        lengthInBytes: vbo.sizeInBytes), 3);

    pass.draw();
    cmd.submit();

    // Paint the rendered texture onto the Flutter canvas
    // (use gpu.Picture or Image conversion)
  }
  @override bool shouldRepaint(_) => true;
}
```

> **Note:** Flutter GPU API is still evolving. Check `flutter/flutter` GitHub for the latest API surface. The pattern above matches the 2026 beta API.


---

## 6. 3D WITH three_dart

`three_dart` is a Dart port of Three.js. It runs on Flutter Web (WebGL) and partially on mobile (via `flutter_gl`).

```yaml
dependencies:
  three_dart: ^0.0.16
  flutter_gl: ^0.0.8      # OpenGL context for mobile
```

### 6.1 Spinning cube — Flutter Web

```dart
import 'package:three_dart/three_dart.dart' as three;
import 'package:three_dart_jsm/three_dart_jsm.dart' as jsm;

class ThreeScene extends StatefulWidget {
  const ThreeScene({super.key});
  @override State<ThreeScene> createState() => _ThreeSceneState();
}

class _ThreeSceneState extends State<ThreeScene> {
  late three.WebGLRenderer renderer;
  late three.Scene scene;
  late three.PerspectiveCamera camera;
  late three.Mesh cube;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    scene = three.Scene();

    camera = three.PerspectiveCamera(75, 1.0, 0.1, 1000);
    camera.position.z = 5;

    final geometry = three.BoxGeometry(1, 1, 1);
    final material = three.MeshPhongMaterial({'color': 0x00ff88});
    cube = three.Mesh(geometry, material);
    scene.add(cube);

    // Ambient + directional light
    scene.add(three.AmbientLight(0xffffff, 0.4));
    final light = three.DirectionalLight(0xffffff, 0.8);
    light.position.set(5, 5, 5);
    scene.add(light);
  }

  void _animate(double t) {
    cube.rotation.x += 0.01;
    cube.rotation.y += 0.015;
    renderer.render(scene, camera);
  }

  @override
  Widget build(BuildContext context) => three.WebGLWidget(
    // three_dart provides this widget for web
    onCreated: (r) { renderer = r; },
    onAnimate: _animate,
  );
}
```

### 6.2 Loading a GLTF model

```dart
final loader = jsm.GLTFLoader(null);
loader.load('assets/models/spaceship.glb', (gltf) {
  scene.add(gltf.scene);
}, onProgress: (p) {}, onError: (e) => debugPrint('Error: $e'));
```

### 6.3 Adding a skybox

```dart
final cubeLoader = three.CubeTextureLoader();
final skyTexture = cubeLoader.load([
  'assets/skybox/px.jpg', 'assets/skybox/nx.jpg',
  'assets/skybox/py.jpg', 'assets/skybox/ny.jpg',
  'assets/skybox/pz.jpg', 'assets/skybox/nz.jpg',
]);
scene.background = skyTexture;
```

---

## 7. 3D WITH BABYLON.JS INSIDE FLUTTER WEB

For a full production-quality 3D experience on Flutter Web, embed Babylon.js in a `HtmlElementView` (or `WebViewController` on mobile). This is the highest-fidelity option — you get PBR materials, shadow maps, skeletal animation, and physics out of the box.

### 7.1 Flutter Web: HtmlElementView bridge

```dart
// In web/index.html — add Babylon CDN script tag:
// <script src="https://cdn.babylonjs.com/babylon.js"></script>

// In Dart:
import 'dart:html' as html;
import 'dart:js' as js;

class BabylonScene extends StatelessWidget {
  const BabylonScene({super.key});

  @override
  Widget build(BuildContext context) {
    // Register the canvas element
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'babylon-canvas',
      (int viewId) {
        final canvas = html.CanvasElement()
          ..id = 'renderCanvas'
          ..style.width = '100%'
          ..style.height = '100%';
        // Boot Babylon after frame renders
        Future.microtask(() => js.context.callMethod('initBabylon', [canvas]));
        return canvas;
      },
    );
    return const HtmlElementView(viewType: 'babylon-canvas');
  }
}
```

```javascript
// web/babylon_init.js
function initBabylon(canvas) {
  const engine = new BABYLON.Engine(canvas, true);
  const scene  = new BABYLON.Scene(engine);
  const camera = new BABYLON.ArcRotateCamera(
    'cam', -Math.PI/2, Math.PI/4, 5, BABYLON.Vector3.Zero(), scene);
  camera.attachControl(canvas, true);
  new BABYLON.HemisphericLight('light', new BABYLON.Vector3(1,1,0), scene);
  BABYLON.MeshBuilder.CreateSphere('sphere', {diameter: 1}, scene);
  engine.runRenderLoop(() => scene.render());
  window.addEventListener('resize', () => engine.resize());
}
```


---

## 8. PHYSICS ENGINES

### 8.1 Flame Forge2D (Box2D for 2D games)

```yaml
dependencies:
  flame_forge2d: ^0.18.0
```

```dart
// In your FlameGame
class MyPhysicsGame extends Forge2DGame {
  MyPhysicsGame() : super(gravity: Vector2(0, 98.1)); // 98.1 = scaled gravity

  @override
  Future<void> onLoad() async {
    // Ground body
    final ground = BodyDef()..type = BodyType.static;
    final groundBody = world.createBody(ground);
    groundBody.createFixture(FixtureDef(
      EdgeShape()..set(Vector2(-50, 0), Vector2(50, 0)),
    ));

    // Dynamic ball
    final ballDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = Vector2(0, 20);
    final ball = world.createBody(ballDef);
    ball.createFixture(FixtureDef(
      CircleShape()..radius = 1,
      restitution: 0.8,   // bounciness
      friction: 0.4,
    ));
  }
}
```

### 8.2 dart_physics (simple AABB/circle physics without Box2D)

```yaml
dependencies:
  dart_physics: ^1.0.0    # lightweight, no FFI required
```

Useful when you need basic collision response for small games without the full Box2D overhead.

### 8.3 Rapier.rs via WASM (Web only)

For high-performance 3D physics on Flutter Web, load the Rapier WASM bundle in `web/index.html` and call it via `dart:js`. This gives you rigid bodies, joints, raycasting identical to what Godot uses internally.

---

## 9. INPUT HANDLING

### 9.1 Flame keyboard input

```dart
class Player extends SpriteComponent
    with KeyboardHandler, HasGameRef<MyGame> {
  final Set<LogicalKeyboardKey> _keysDown = {};

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keys) {
    _keysDown
      ..clear()
      ..addAll(keys);
    return true; // handled
  }

  @override
  void update(double dt) {
    final speed = 200.0;
    if (_keysDown.contains(LogicalKeyboardKey.arrowLeft))  position.x -= speed * dt;
    if (_keysDown.contains(LogicalKeyboardKey.arrowRight)) position.x += speed * dt;
    if (_keysDown.contains(LogicalKeyboardKey.arrowUp))    position.y -= speed * dt;
    if (_keysDown.contains(LogicalKeyboardKey.arrowDown))  position.y += speed * dt;
  }
}
```

### 9.2 Touch / tap input

```dart
class TapTarget extends SpriteComponent with TapCallbacks {
  @override
  void onTapDown(TapDownEvent event) {
    scale = Vector2.all(1.2); // visual feedback
  }
  @override
  void onTapUp(TapUpEvent event) {
    scale = Vector2.all(1.0);
    // handle tap
  }
}
```

### 9.3 Joystick (on-screen)

```dart
// Flame built-in joystick component
final joystick = JoystickComponent(
  knob: CircleComponent(radius: 30, paint: Paint()..color = Colors.white54),
  background: CircleComponent(radius: 60, paint: Paint()..color = Colors.black38),
  margin: const EdgeInsets.only(left: 24, bottom: 24),
);
add(joystick);

// In player update:
void update(double dt) {
  if (!joystick.delta.isZero()) {
    position.add(joystick.relativeDelta * 200 * dt);
    angle = joystick.delta.screenAngle();
  }
}
```

### 9.4 Gamepad (flutter_gamepad)

```yaml
dependencies:
  flutter_gamepad: ^1.0.0
```

```dart
FlutterGamepad.eventStream.listen((event) {
  if (event is GamepadButtonEvent) {
    if (event.button == GamepadButton.buttonA && event.value == 1.0) jump();
  }
  if (event is GamepadThumbstickEvent) {
    moveX = event.x; moveY = event.y;
  }
});
```

---

## 10. AUDIO

### 10.1 Flame Audio (bgm + sfx)

```yaml
dependencies:
  flame_audio: ^2.10.0
```

```dart
// Pre-cache on game load
await FlameAudio.audioCache.loadAll(['bgm.mp3', 'shoot.wav', 'explosion.wav']);

// Background music (loops)
FlameAudio.bgm.play('bgm.mp3', volume: 0.6);
FlameAudio.bgm.pause();
FlameAudio.bgm.resume();
FlameAudio.bgm.stop();

// One-shot sound effects
FlameAudio.play('shoot.wav', volume: 1.0);
FlameAudio.playLongAudio('explosion.wav'); // for longer clips
```

### 10.2 Spatial audio (just_audio + audioplayers)

```yaml
dependencies:
  audioplayers: ^6.1.0
```

```dart
// Simulate spatial audio: volume based on distance to player
final distance = (enemyPosition - playerPosition).length;
final volume = (1 - (distance / maxHearingDistance)).clamp(0.0, 1.0);
await AudioPlayer().play(AssetSource('shoot.wav'), volume: volume);
```

### 10.3 Soloud (low-latency audio, 3D spatial)

```yaml
dependencies:
  flutter_soloud: ^2.6.0   # wraps SoLoud C++ library, very low latency
```

`flutter_soloud` supports real 3D positional audio with distance rolloff, Doppler effect, and reverb — ideal for 3D games.


---

## 11. STATE MANAGEMENT FOR GAMES (GetX PATTERN)

GetX works naturally with game state. The key is keeping your `GetxController` as the single source of truth and letting Flame components read from it reactively.

```dart
// Game state controller — lives outside Flame's world
class GameController extends GetxController {
  final score       = 0.obs;
  final lives       = 3.obs;
  final level       = 1.obs;
  final isPaused    = false.obs;
  final highScore   = 0.obs;

  void addScore(int points) {
    score.value += points;
    if (score.value > highScore.value) highScore.value = score.value;
  }
  void loseLife() {
    lives.value--;
    if (lives.value <= 0) _gameOver();
  }
  void _gameOver() {
    isPaused.value = true;
    Get.dialog(const GameOverDialog());
  }
  void restart() {
    score.value = 0;
    lives.value = 3;
    level.value = 1;
    isPaused.value = false;
    Get.back(); // close dialog
  }
}

// Register before game starts
Get.put(GameController(), permanent: true);

// In Flame component — read state
class EnemyComponent extends SpriteComponent {
  void onDeath() {
    Get.find<GameController>().addScore(100);
    removeFromParent();
  }
}

// In Flutter overlay HUD — reactive
class GameHud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gc = Get.find<GameController>();
    return Positioned(top: 16, left: 16, child: Obx(() => Row(children: [
      Text('Score: ${gc.score.value}', style: const TextStyle(color: Colors.white, fontSize: 18)),
      const SizedBox(width: 24),
      for (var i = 0; i < gc.lives.value; i++)
        const Icon(Icons.favorite, color: Colors.red, size: 20),
    ])));
  }
}

// Wire the HUD overlay into Flame
class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    overlays.add('hud');
  }
}

// In GameWidget:
GameWidget(
  game: MyGame(),
  overlayBuilderMap: {
    'hud': (ctx, game) => const GameHud(),
  },
)
```

---

## 12. ASSET PIPELINE

### 12.1 Sprites and sprite sheets

- **Create:** Aseprite (pixel art) or Photoshop → export as PNG sheet
- **Atlas packing:** use `TexturePacker` or `free_tex_packer` (free) → generates `.png` + `.json`
- **Load in Flame:**
```dart
// Single sprite
final sprite = await game.loadSprite('hero.png');

// Sprite sheet (TexturePacker JSON)
final sheet = await game.loadSpriteSheet(
  'characters.png',
  SpriteSheetData.sequenced(amount: 12, textureSize: Vector2(32, 32)),
);
```

### 12.2 Tile maps

- **Create:** Tiled Map Editor (free) → export `.tmx` + tilesets as `.png`
- **Load in Flame:**
```dart
final tiled = await TiledComponent.load(
  'level1.tmx',
  Vector2.all(16), // tile size in pixels
  prefix: 'tiles/',
);
world.add(tiled);
```

### 12.3 3D Models

- **Format:** `.glb` (binary GLTF) — most compact, widely supported
- **Tools:** Blender (free), Sketchfab (download free models)
- **Optimize:** Draco mesh compression — reduces .glb by 60-80%
- **Load in three_dart:** `GLTFLoader.load('model.glb', ...)`
- **Load in Babylon.js:** `BABYLON.SceneLoader.ImportMesh('', 'assets/', 'model.glb', scene, ...)`

### 12.4 Shaders (.glsl / .frag)

Flutter supports custom fragment shaders via `FragmentProgram`:
```dart
// In pubspec.yaml:
// flutter:
//   shaders:
//     - shaders/fire.frag

final program = await FragmentProgram.fromAsset('shaders/fire.frag');
final shader = program.fragmentShader();
shader.setFloat(0, time); // pass uniform
canvas.drawRect(rect, Paint()..shader = shader.imageShader(width, height));
```

---

## 13. NETWORKING — MULTIPLAYER

### 13.1 Supabase Realtime for turn-based multiplayer

Use `chat_rooms` style table pattern for game rooms. Realtime broadcasts game state changes.

```dart
// Game room subscription
final channel = Supabase.instance.client.channel('game:$roomId');
channel.onBroadcast(event: 'move', callback: (payload) {
  final uid   = payload['uid'] as int;
  final x     = (payload['x'] as num).toDouble();
  final y     = (payload['y'] as num).toDouble();
  game.updateRemotePlayer(uid, x, y);
});
channel.subscribe();

// Send a move
await channel.sendBroadcastMessage(event: 'move', payload: {
  'uid': localUid, 'x': player.x, 'y': player.y,
});
```

### 13.2 WebRTC data channel for real-time multiplayer

Reuse the existing `WebRtcService` from the AIR Meet module — the data channel gives you < 20ms P2P latency at 60fps. Send compact binary game state:

```dart
// Pack player state into 12 bytes: uid(4) + x(4) + y(4)
final bytes = ByteData(12)
  ..setUint32(0, localUid)
  ..setFloat32(4, player.x)
  ..setFloat32(8, player.y);
await engine.sendDataMessage(bytes.buffer.asUint8List());
```

### 13.3 Dedicated game server (Dart shelf)

For authoritative server-side game logic (anti-cheat, MMO):
```dart
// server/main.dart — Dart shelf WebSocket server
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_web_socket/shelf_web_socket.dart';

void main() async {
  final handler = webSocketHandler((WebSocketChannel ws) {
    ws.stream.listen((msg) {
      // parse, validate, broadcast to all players in room
    });
  });
  await io.serve(handler, 'localhost', 8080);
}
```


---

## 14. COMMUNITY PACKAGES CHEATSHEET

| Package | Version | Purpose |
|---|---|---|
| `flame` | `^1.18.0` | Core 2D game engine |
| `flame_forge2d` | `^0.18.0` | Box2D rigid-body physics for Flame |
| `flame_tiled` | `^1.18.0` | Tiled .tmx map loading |
| `flame_audio` | `^2.10.0` | BGM + SFX with caching |
| `flame_lottie` | `^0.4.0` | Lottie animations as Flame components |
| `flame_riverpod` | `^5.0.0` | Riverpod state for Flame (alternative to GetX) |
| `three_dart` | `^0.0.16` | Three.js port — 3D on Web |
| `flutter_gl` | `^0.0.8` | OpenGL context for mobile 3D |
| `flutter_gpu` | SDK | Flutter's own GPU API (Impeller, 2026) |
| `flutter_soloud` | `^2.6.0` | SoLoud C++ — low latency + 3D spatial audio |
| `audioplayers` | `^6.1.0` | Simple audio playback |
| `flutter_gamepad` | `^1.0.0` | Physical gamepad support |
| `particles_flutter` | `^1.0.1` | Particle system widget (explosions, rain, snow) |
| `spritesheet` | `^1.0.0` | Sprite sheet slicing helpers |
| `tiled` | `^3.1.0` | Parse Tiled .tmx without Flame |
| `a_star_dart` | `^1.0.0` | A* pathfinding |
| `bezier` | `^2.0.1` | Bezier curves for smooth paths |
| `noise` | `^3.0.0` | Perlin/simplex noise for procedural terrain |
| `leap` | `^0.9.0` | Platformer physics + Tiled integration (built on Flame) |
| `bonfire` | `^3.11.0` | RPG top-down engine built on Flame |
| `jenny` | `^2.1.1` | Yarn Spinner dialogue trees (in-game dialogue) |
| `flutter_unity_widget` | `^2022.2.1` | Embed a Unity scene inside Flutter |

---

## 15. COMPLETE 2D EXAMPLE — SPACE SHOOTER

Full working game: player ship moves left/right, shoots bullets, enemies spawn from top, collision destroys both, score HUD overlaid with GetX.

```dart
// lib/games/space_shooter/space_shooter_game.dart
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

// ── State ────────────────────────────────────────────────────────────────────
class ShooterController extends GetxController {
  final score = 0.obs;
  final lives = 3.obs;
  void addScore(int v) => score.value += v;
  void loseLife()      { lives.value--; }
}

// ── Components ────────────────────────────────────────────────────────────────
class PlayerShip extends SpriteComponent
    with HasGameRef<SpaceShooterGame>, KeyboardHandler, CollisionCallbacks {
  final Set<LogicalKeyboardKey> _keys = {};
  static const _speed = 300.0;

  PlayerShip() : super(size: Vector2(48, 48));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('ship.png');
    position = Vector2(gameRef.size.x / 2 - 24, gameRef.size.y - 80);
    add(RectangleHitbox());
  }

  @override
  bool onKeyEvent(KeyEvent e, Set<LogicalKeyboardKey> keys) {
    _keys..clear()..addAll(keys);
    if (e is KeyDownEvent && e.logicalKey == LogicalKeyboardKey.space) _shoot();
    return true;
  }

  void _shoot() {
    gameRef.world.add(Bullet(position: position + Vector2(20, -10)));
  }

  @override
  void update(double dt) {
    if (_keys.contains(LogicalKeyboardKey.arrowLeft))
      position.x = (position.x - _speed * dt).clamp(0, gameRef.size.x - width);
    if (_keys.contains(LogicalKeyboardKey.arrowRight))
      position.x = (position.x + _speed * dt).clamp(0, gameRef.size.x - width);
  }

  @override
  void onCollisionStart(Set<Vector2> _, PositionComponent other) {
    if (other is Enemy) {
      Get.find<ShooterController>().loseLife();
      other.removeFromParent();
    }
  }
}

class Bullet extends SpriteComponent
    with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  Bullet({required Vector2 position})
      : super(size: Vector2(6, 20), position: position);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bullet.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.y -= 400 * dt;
    if (position.y < -height) removeFromParent();
  }

  @override
  void onCollisionStart(Set<Vector2> _, PositionComponent other) {
    if (other is Enemy) {
      Get.find<ShooterController>().addScore(10);
      other.removeFromParent();
      removeFromParent();
    }
  }
}

class Enemy extends SpriteComponent with HasGameRef<SpaceShooterGame>, CollisionCallbacks {
  Enemy({required Vector2 position}) : super(size: Vector2(40, 40), position: position);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('enemy.png');
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.y += 120 * dt;
    if (position.y > gameRef.size.y) removeFromParent();
  }
}

// ── Game ─────────────────────────────────────────────────────────────────────
class SpaceShooterGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  double _spawnTimer = 0;

  @override
  Future<void> onLoad() async {
    Get.put(ShooterController());
    world.add(PlayerShip());
    overlays.add('hud');
  }

  @override
  void update(double dt) {
    super.update(dt);
    _spawnTimer += dt;
    if (_spawnTimer >= 1.2) {
      _spawnTimer = 0;
      final x = (size.x * 0.1) + (size.x * 0.8 * (DateTime.now().millisecond / 1000));
      world.add(Enemy(position: Vector2(x, -40)));
    }
  }
}

// ── Entry point ───────────────────────────────────────────────────────────────
Widget buildSpaceShooter() => GameWidget(
  game: SpaceShooterGame(),
  overlayBuilderMap: {
    'hud': (ctx, game) {
      final c = Get.find<ShooterController>();
      return Positioned(top: 16, left: 16,
        child: Obx(() => Row(children: [
          Text('⭐ ${c.score.value}',
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          ...List.generate(c.lives.value,
            (_) => const Icon(Icons.favorite, color: Colors.red, size: 20)),
        ])));
    },
  },
);
```

**Required assets** (place in `assets/images/`):
- `ship.png` — 48×48 player sprite
- `bullet.png` — 6×20 bullet sprite
- `enemy.png` — 40×40 enemy sprite


---

## 16. COMPLETE 3D EXAMPLE — SPINNING PLANET

A self-contained Flutter widget showing a textured sphere with a starfield, rotating at a configurable speed. Uses `CustomPainter` + `FragmentProgram` shader — no third-party 3D package required, runs on all platforms.

```glsl
// shaders/planet.frag
// Flutter fragment shader — sphere raymarching with texture simulation
#include <flutter/runtime_effect.glsl>

uniform float uTime;
uniform vec2  uResolution;
out vec4 fragColor;

// Simple hash-based noise
float hash(vec2 p) {
  return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

// Sphere SDF
float sphere(vec3 p, float r) { return length(p) - r; }

// Color the planet surface based on angle (simulates latitude bands)
vec3 planetColor(vec3 normal, float time) {
  float lat = asin(normal.y) / 3.14159 + 0.5;
  float lon = atan(normal.z, normal.x) / (2.0 * 3.14159) + time * 0.05;
  float n   = hash(vec2(floor(lon * 12.0), floor(lat * 8.0)));
  vec3 ocean = vec3(0.1, 0.3, 0.7);
  vec3 land  = vec3(0.2, 0.55, 0.2);
  vec3 polar = vec3(0.9, 0.95, 1.0);
  vec3 col   = mix(ocean, land, step(0.45, n));
  col        = mix(col, polar, smoothstep(0.8, 1.0, abs(normal.y)));
  return col;
}

void main() {
  vec2 uv  = (FlutterFragCoord().xy - uResolution * 0.5) / min(uResolution.x, uResolution.y);
  vec3 ro  = vec3(0.0, 0.0, 2.5);   // ray origin
  vec3 rd  = normalize(vec3(uv, -1.5)); // ray direction

  // Rotate planet
  float angle = uTime * 0.4;
  mat2 rot    = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));

  // Sphere intersection
  vec3 oc = ro;
  float a = dot(rd, rd);
  float b = 2.0 * dot(oc, rd);
  float c = dot(oc, oc) - 1.0;
  float disc = b*b - 4.0*a*c;

  vec3 col = vec3(0.02, 0.02, 0.05); // space background

  // Stars
  float star = step(0.995, hash(floor(uv * 80.0 + vec2(uTime * 0.01))));
  col += vec3(star);

  if (disc > 0.0) {
    float t    = (-b - sqrt(disc)) / (2.0 * a);
    vec3 hit   = ro + t * rd;
    vec3 normal = normalize(hit);
    // Apply rotation to normal for spinning effect
    normal.xz  = rot * normal.xz;

    // Lighting
    vec3 light = normalize(vec3(1.5, 1.0, 2.0));
    float diff = max(dot(normal, light), 0.0);
    float amb  = 0.08;

    col = planetColor(normal, uTime) * (diff + amb);

    // Atmosphere rim glow
    float rim = 1.0 - max(dot(-rd, normal), 0.0);
    col += vec3(0.1, 0.4, 1.0) * pow(rim, 3.0) * 0.6;
  }

  fragColor = vec4(col, 1.0);
}
```

```dart
// lib/games/planet/planet_widget.dart
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PlanetWidget extends StatefulWidget {
  const PlanetWidget({super.key});
  @override State<PlanetWidget> createState() => _PlanetWidgetState();
}

class _PlanetWidgetState extends State<PlanetWidget>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double _time = 0;
  ui.FragmentShader? _shader;

  @override
  void initState() {
    super.initState();
    _loadShader();
    _ticker = createTicker((elapsed) {
      setState(() => _time = elapsed.inMicroseconds / 1e6);
    })..start();
  }

  Future<void> _loadShader() async {
    final program = await ui.FragmentProgram.fromAsset('shaders/planet.frag');
    setState(() => _shader = program.fragmentShader());
  }

  @override
  void dispose() { _ticker.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (_shader == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return CustomPaint(
      painter: _PlanetPainter(_shader!, _time),
      child: const SizedBox.expand(),
    );
  }
}

class _PlanetPainter extends CustomPainter {
  _PlanetPainter(this.shader, this.time);
  final ui.FragmentShader shader;
  final double time;

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setFloat(0, time)
      ..setFloat(1, size.width)
      ..setFloat(2, size.height);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(_PlanetPainter old) => old.time != time;
}

// Usage in any screen:
// child: const PlanetWidget()
```

**Register in pubspec.yaml:**
```yaml
flutter:
  shaders:
    - shaders/planet.frag
```

---

## 17. PERFORMANCE TIPS

### 2D

| Problem | Fix |
|---|---|
| Too many `setState` calls | Use `GetX` reactives or Flame's own update loop — never call `setState` inside `update()` |
| Sprite redraw on every frame | Use `shouldRepaint` returning false when state unchanged |
| Many small images | Pack into a single atlas with TexturePacker, load once |
| GC pauses from object creation | Pool bullets/particles — reuse objects instead of `add/remove` |
| Tiled map stutters on load | Load in `onLoad()` with `await`, show loading screen |

### 3D (Flutter GPU / three_dart)

| Problem | Fix |
|---|---|
| Shader compile stutter | Pre-warm shaders in `initState` before first frame |
| High draw call count | Merge static meshes into one buffer, use instanced rendering |
| Texture memory | Use compressed textures (ASTC on mobile, BC7 on desktop) |
| Shadow map resolution | Start at 512x512, only increase if artefacts visible |
| Overdraw on particles | Use additive blending, cull particles behind opaque geometry |

### General

- Profile with Flutter DevTools → "Performance" tab → look for `rasterizer` jank
- Enable `debugRepaintRainbowEnabled = true` to spot unnecessary repaints
- Use `RepaintBoundary` around HUD widgets so they don't invalidate the game canvas
- On Android, add `android:hardwareAccelerated="true"` in AndroidManifest

---

## 18. PUBLISHING

### Android
```yaml
# android/app/build.gradle
android {
  defaultConfig {
    minSdkVersion 21      # Flame requires 21+
    targetSdkVersion 34
  }
}
```
- Enable Impeller: add `<meta-data android:name="io.flutter.embedding.android.EnableImpeller" android:value="true"/>` to AndroidManifest.
- For large games: use `abiFilters 'arm64-v8a', 'x86_64'` to reduce APK size.

### iOS
- Minimum iOS 12 for Flutter GPU.
- Impeller is default — no extra config.
- For Game Center: add `GameKit.framework` in Xcode.

### Web
- Build with `flutter build web --wasm` (Dart2Wasm) for best performance in 2026.
- Host on HTTPS (camera/WebGL/WebGPU require it).
- Add `<canvas>` tag optimization: `canvas { image-rendering: pixelated; }` for pixel art games.

### Desktop
- Windows/macOS/Linux: Flutter uses Impeller (Vulkan on Windows/Linux, Metal on macOS).
- For distribution: use `flutter build windows` → wrap with Inno Setup or MSIX.

---

## COMMUNITY RESOURCES

| Resource | URL |
|---|---|
| Flame official docs | https://docs.flame-engine.org |
| Flame GitHub | https://github.com/flame-engine/flame |
| Flutter GPU samples | https://github.com/flutter/flutter/tree/main/examples/flutter_gpu |
| three_dart examples | https://github.com/wasabia/three_dart |
| itch.io Flutter games | https://itch.io/games/tag-flutter |
| Bonfire RPG engine | https://bonfire-engine.github.io |
| Flutter shader playground | https://shadertoy.com (adapt to .frag format) |
| Tiled map editor | https://mapeditor.org |
| Kenney free assets | https://kenney.nl/assets (sprites, sounds, fonts) |
| Freesound.org | https://freesound.org (free SFX, CC license) |

---

*README_kiro_2-3-D_games.md — 2026-07-06*
*All code examples are MIT-licensed and ready to copy into any Flutter project.*
