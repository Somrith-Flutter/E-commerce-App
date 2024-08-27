class ProductModel {
  final int id;
  final int categoryId;
  final int subCategoryId;
  final String productName;
  final String description;
  final String imageUrl;
  final String addFavorite;
  final double prices;
  final String shippingStatus;
  final double discount;
  final String status;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.productName,
    required this.description,
    required this.imageUrl,
    required this.addFavorite,
    required this.prices,
    required this.shippingStatus,
    required this.discount,
    required this.status,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: json['category_id'],
      subCategoryId: json['sub_category_id'],
      productName: json['product_name'],
      description: json['description'],
      imageUrl: json['image_url'],
      addFavorite: json['add_favorit'],
      prices: json['prices'],
      shippingStatus: json['shipping_status'],
      discount: json['discount'].toDouble(),
      status: json['status'],
      sortOrder: json['sort_order'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
