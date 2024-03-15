class UserModel{
  String? id;
  String? name;
  String? mobile;

  UserModel({this.id, this.name, this.mobile});

  factory UserModel.fromJSON(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      name: json['name'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id' : id,
      'name': name,
      'mobile': mobile,
    };
  }
}