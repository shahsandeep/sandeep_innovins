class UserRegisterModel {
  String? title;
  String? message;
  Data? data;

  UserRegisterModel({this.title, this.message, this.data});

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userToken;
  int? id;
  String? name;
  String? mobile;
  String? email;

  Data({this.userToken, this.id, this.name, this.mobile, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    userToken = json['user_token'];
    id = json['id'] is String ? int.parse(json['id']) : json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_token'] = userToken;
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    return data;
  }
}
