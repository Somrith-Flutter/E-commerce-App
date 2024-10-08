class SubCategoryModel {
  String? id;
  String? categoryId;
  String? tittle;
  String? imageUrl;
  String? status;
  String? isSilde;
  String? imageSlide;
  String? createdAt;
  String? updatedAt;

  SubCategoryModel(
      {this.id,
        this.categoryId,
        this.tittle,
        this.imageUrl,
        this.status,
        this.isSilde,
        this.imageSlide,
        this.createdAt,
        this.updatedAt});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    categoryId = json['category_id'].toString();
    tittle = json['tittle'].toString();
    imageUrl = json['image_url'].toString();
    status = json['status'].toString();
    isSilde = json['is_silde'].toString();
    imageSlide = json['image_slide'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['category_id'] = categoryId.toString();
    data['tittle'] = tittle.toString();
    data['image_url'] = imageUrl.toString();
    data['status'] = status.toString();
    data['is_silde'] = isSilde.toString();
    data['image_slide'] = imageSlide.toString();
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    return data;
  }
}
