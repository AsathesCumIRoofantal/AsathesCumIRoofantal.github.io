class EntityModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final String imageUrl;

  EntityModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imageUrl,
  });

  factory EntityModel.fromJson(Map<String, dynamic> json) {
    return EntityModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
