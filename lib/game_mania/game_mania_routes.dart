import 'package:get/get.dart';
import 'game_mania_home.dart';
import 'space_shooter/space_shooter_entry.dart';
import 'snake/snake_entry.dart';
// import 'bounce_ball/bounce_ball_entry.dart';
// import 'planet_3d/planet_entry.dart';

abstract class GameManiaRoutes {
  static const home = '/game-mania';
  static const spaceShooter = '/game-mania/space-shooter';
  static const snake = '/game-mania/snake';
  static const bounceBall = '/game-mania/bounce-ball';
  static const planet3d = '/game-mania/planet-3d';

  static final pages = <GetPage>[
    GetPage(
      name: home,
      page: () => const GameManiaHome(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: spaceShooter,
      page: () => const SpaceShooterEntry(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: snake,
      page: () => const SnakeEntry(),
      transition: Transition.fadeIn,
    ),
    // GetPage(name: bounceBall,   page: () => const BounceBallEntry(),transition: Transition.fadeIn),
    // GetPage(name: planet3d,     page: () => const PlanetEntry(),    transition: Transition.fadeIn),
  ];
}
