class LearningMenuModel {
  final String id;
  final String title;
  final String description;
  final String iconIdentifier;
  final String colorHex;

  LearningMenuModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconIdentifier,
    required this.colorHex,
  });

  factory LearningMenuModel.fromJson(Map<String, dynamic> json) {
    return LearningMenuModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      iconIdentifier: json['iconIdentifier'],
      colorHex: json['colorHex'],
    );
  }
}
