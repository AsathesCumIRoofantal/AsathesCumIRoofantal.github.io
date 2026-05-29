import 'package:get/get.dart';
import '../../new_modules/new_app_role_catalog.dart';

class NewAppLearnFunController extends GetxController {
  final String title = "Learn And Fun";
  final String tagline = "Playful tiles where curiosity meets practice.";

  /// Live role / specific picked from login session.
  final role = 'Student'.obs;
  final specific = 'Alifiya (Beginner)'.obs;

  /// Beginner-first toggle: true => alifiyas content, false => advanced.
  final beginnerMode = true.obs;

  /// Resolved needs (common first, then role-specifics).
  RxList<NewAppNeedsBucket> get needs =>
      NewAppRoleNeeds.resolve(role.value).obs;

  /// All recognised specifics for the current role.
  List<String> get specificsForRole =>
      NewAppRoleCatalog.specifics[role.value] ?? const <String>[];

  final selectedCategory = 'Universal Orientation'.obs;

  final categories = [
    'Universal Orientation',
    'Knowledge Forest',
    'Digital World',
    'Real World',
    'Life Systems',
    'AI & Future',
    'Research',
    'Wisdom',
    'Doctorate Paths',
    'Civilization',
    'Economics',
    'Humanity',
    'Spiritual Balance',
    'Innovation',
  ];

  final knowledgeTree = {
    'Space': [
      'Galaxy',
      'Planet',
      'Civilization',
      'Human',
      'Knowledge',
      'Science',
      'Technology',
      'Wisdom',
    ],
    'Learning': [
      'Observe',
      'Understand',
      'Practice',
      'Build',
      'Teach',
      'Research',
      'Innovate',
    ],
  }.obs;

  final resourceLinks = [
    'https://ocw.mit.edu/',
    'https://developer.mozilla.org/',
    'https://flutter.dev/',
    'https://firebase.google.com/',
    'https://supabase.com/',
    'https://arxiv.org/',
    'https://www.nasa.gov/',
  ];

  void switchRole(String r) {
    if (!NewAppRoleCatalog.roles.contains(r)) return;
    role.value = r;
    final firstSpec =
        (NewAppRoleCatalog.specifics[r] ?? const <String>[]).first;
    specific.value = firstSpec;
  }

  void switchSpecific(String s) {
    if (NewAppRoleCatalog.isValid(role.value, s)) specific.value = s;
  }
}
