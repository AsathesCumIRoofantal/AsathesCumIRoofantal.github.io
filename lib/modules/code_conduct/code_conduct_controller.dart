import 'package:get/get.dart';

class ConductRule {
  final String title;
  final String description;
  final String category;

  ConductRule({
    required this.title,
    required this.description,
    required this.category,
  });
}

class CodeConductController extends GetxController {
  final rules = <ConductRule>[
    ConductRule(
      title: 'Integrity in Data',
      description: 'Ensure all records and digitalizations are accurate and verifiable.',
      category: 'Core Values',
    ),
    ConductRule(
      title: 'Distributed Respect',
      description: 'Treat all nodes and their human operators with professional courtesy.',
      category: 'Core Values',
    ),
    ConductRule(
      title: 'Resource Responsibility',
      description: 'Optimize usage of system resources to ensure equitable access for all.',
      category: 'Core Values',
    ),
    ConductRule(
      title: 'Knowledge Sharing',
      description: 'Actively contribute to the Wisdom Node when new anomalies are checked.',
      category: 'Operations',
    ),
    ConductRule(
      title: 'Security First',
      description: 'Never share private/confidential credentials outside authorized channels.',
      category: 'Operations',
    ),
    ConductRule(
      title: 'Continuous Improvement',
      description: 'Strive to elevate from Alifiyas to Mazeasta through diligent practice.',
      category: 'Growth',
    ),
  ].obs;
}
