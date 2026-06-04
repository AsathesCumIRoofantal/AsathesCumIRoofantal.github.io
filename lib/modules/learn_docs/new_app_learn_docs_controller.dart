import 'package:get/get.dart';
import '../../new_modules/new_app_role_catalog.dart';

class NewAppLearnDocsController extends GetxController {
  final String title = "Learn Docs";
  final String tagline = "Category-indexed reading rooms and primary papers.";

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
