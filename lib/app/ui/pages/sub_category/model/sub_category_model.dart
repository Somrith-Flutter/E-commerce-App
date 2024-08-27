class SubCategoryModel {
  final int id;
  final int categoryId;
  final String title;
  final String imageUrl;
  final String status;
  final String isSlide;
  final String imageSlide;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.imageUrl,
    required this.status,
    required this.isSlide,
    required this.imageSlide,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      categoryId: json['category_id'],
      title: json['tittle'], // Assuming there's a typo in the API with "tittle"
      imageUrl: json['image_url'],
      status: json['status'],
      isSlide: json['is_silde'], // Assuming there's a typo in the API with "is_silde"
      imageSlide: json['image_slide'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
