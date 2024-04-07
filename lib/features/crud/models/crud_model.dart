class CrudModel {
  final String title;
  final String messge;
  CrudModel({
    required this.title,
    required this.messge,
  });

  factory CrudModel.fromJson(Map<String, dynamic> json) {
    return CrudModel(title: json['title'], messge: json['message']);
  }
}
