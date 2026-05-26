class QuestionnaireModel {
  final String id;
  final String question;
  final List<String> options;
  final String traitMapped;

  QuestionnaireModel({
    required this.id,
    required this.question,
    required this.options,
    required this.traitMapped,
  });

  factory QuestionnaireModel.fromJson(Map<String, dynamic> json) {
    return QuestionnaireModel(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options'] ?? []),
      traitMapped: json['traitMapped'],
    );
  }
}
