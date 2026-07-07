import 'package:get/get.dart';
import 'game_mania_home.dart';
import 'space_shooter/space_shooter_entry.dart';
import 'snake/snake_entry.dart';


/// All 2-D and 3-D F-D (fixed) and C-D (customized and controlled) games
abstract class GameManiaRoutes {
  static const home = '/game-mania';
  static const spaceShooter = '/game-mania/space-shooter';
  static const snake = '/game-mania/snake';

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
  ];
}
