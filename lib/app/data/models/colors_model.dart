class ColorsModel {
  String? colorId;
  String? colorName;
  String? createdAt;
  String? updatedAt;

  ColorsModel({this.colorId, this.colorName, this.createdAt, this.updatedAt});

  ColorsModel.fromJson(Map<String, dynamic> json) {
    colorId = json['color_id'].toString();
    colorName = json['color_name'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color_id'] = colorId.toString();
    data['color_name'] = colorName.toString();
    data['created_at'] = createdAt.toString();
    data['updated_at'] = updatedAt.toString();
    return data;
  }
}
