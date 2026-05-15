import 'package:get/get.dart';

class Skill {
  final String name;
  final double level;
  final String category;

  Skill({required this.name, required this.level, required this.category});
}

class SkillsTalentsController extends GetxController {
  final skills = <Skill>[
    Skill(name: "Data Mining", level: 0.9, category: "Technical"),
    Skill(name: "System Architecture", level: 0.75, category: "Technical"),
    Skill(name: "Strategic Planning", level: 0.6, category: "Management"),
    Skill(name: "Creative Design", level: 0.4, category: "Creative"),
  ].obs;
}
