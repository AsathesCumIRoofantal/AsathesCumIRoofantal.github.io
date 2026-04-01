class LearningDocModel {
  final String id;
  final String categoryId;
  final String title;
  final String description;
  final String type;
  final String classCategory;
  final String targetAge;
  final String url;

  LearningDocModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.type,
    required this.classCategory,
    required this.targetAge,
    required this.url,
  });

  factory LearningDocModel.fromJson(Map<String, dynamic> json) {
    return LearningDocModel(
      id: json['id'],
      categoryId: json['categoryId'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      classCategory: json['classCategory'],
      targetAge: json['targetAge'],
      url: json['url'],
    );
  }
}
