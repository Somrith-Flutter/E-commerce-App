class CategoriesModel {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? status;
  String? isSilde;
  String? sortOrder;
  String? createdAt;
  String? updatedAt;

  CategoriesModel(
      {this.id,
        this.name,
        this.description,
        this.imageUrl,
        this.status,
        this.isSilde,
        this.sortOrder,
        this.createdAt,
        this.updatedAt});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    description = json['description'].toString();
    imageUrl = json['image_url'].toString();
    status = json['status'].toString();
    isSilde = json['is_silde'].toString();
    sortOrder = json['sort_order'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['name'] = name.toString();
    data['description'] = description.toString();
    data['image_url'] = imageUrl.toString();
    data['status'] = status.toString();
    data['is_silde'] = isSilde.toString();
    data['sort_order'] = sortOrder.toString();
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    return data;
  }
}
