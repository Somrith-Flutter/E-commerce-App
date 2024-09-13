class ProductModel {
  String id;
  String categoryId;
  String subCategoryId;
  String productName;
  String description;
  List<String> imageUrl;
  String addFavorite;
  double prices;
  String shippingStatus;
  double discount;
  String status;
  String sortOrder;
  String rate;
  String reviewer;
  String imageThumbnail;
  String createdAt;
  String updatedAt;
  List<String> colors;

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
    required this.rate,
    required this.reviewer,
    required this.imageThumbnail,
    required this.createdAt,
    required this.updatedAt,
    required this.colors,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      categoryId: json['category_id'].toString(),
      subCategoryId: json['sub_category_id'].toString(),
      productName: json['product_name'].toString(),
      description: json['description'].toString(),
      
      // Parsing image URLs as List of Strings
      imageUrl: List<String>.from(json['image_url']
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .split(',')),

      addFavorite: json['add_favorit'].toString(),
      prices: json['prices'].toDouble(),
      shippingStatus: json['shipping_status'].toString(),
      discount: json['discount'].toDouble(),
      status: json['status'].toString(),
      sortOrder: json['sort_order'].toString(),
      
      // Additional fields
      rate: json['rate'].toString(),
      reviewer: json['reviewer'].toString(),
      imageThumbnail: json['image_thumbnail'].toString(),
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString(),
      
      // Colors as List<String>
      colors: List<String>.from(json['colors'] ?? []),
    );
  }
}
