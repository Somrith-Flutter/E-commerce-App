class CategoryModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String status;
  final String isSlide;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.isSlide,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      status: json['status'],
      isSlide: json['is_silde'],
      sortOrder: json['sort_order'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'status': status,
      'is_silde': isSlide,
      'sort_order': sortOrder,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
