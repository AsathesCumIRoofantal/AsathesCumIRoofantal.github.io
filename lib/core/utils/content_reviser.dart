import 'package:air_app/data/auth_service.dart';

class ContentReviser {
  static String revise(String content, {String? title}) {
    if (AuthService.to.userRole.value == 'Mazeasta') {
      return "[EXPERT REVISION] $content\n\nExpert Insight: This node has been optimized for peak performance and strategic alignment within the AIR ecosystem. Recommended for advanced practitioners.";
    }
    return content;
  }

  static String reviseTitle(String title) {
    if (AuthService.to.userRole.value == 'Mazeasta') {
      return "★ $title (Optimized)";
    }
    return title;
  }
}
