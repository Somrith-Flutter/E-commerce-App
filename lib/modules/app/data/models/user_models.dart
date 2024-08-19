class UserModel {
  String? id;
  String? name;
  String? address;
  String? email;
  String? phone;
  String? notes;
  String? status;
  String? role;

  UserModel(
      {this.id,
        this.name,
        this.address,
        this.email,
        this.phone,
        this.notes,
        this.status,
        this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    address = json['address'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    notes = json['notes'].toString();
    status = json['status'].toString();
    role = json['role'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['name'] = name.toString();
    data['address'] = address.toString();
    data['email'] = email.toString();
    data['phone'] = phone.toString();
    data['notes'] = notes.toString();
    data['status'] = status.toString();
    data['role'] = role.toString();
    return data;
  }
}
