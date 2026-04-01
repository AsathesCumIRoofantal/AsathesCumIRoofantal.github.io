class UnionModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final List<String> unionedEntities;
  final String imageUrl;

  UnionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.unionedEntities,
    required this.imageUrl,
  });

  factory UnionModel.fromJson(Map<String, dynamic> json) {
    return UnionModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      unionedEntities: List<String>.from(json['unionedEntities'] ?? []),
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
