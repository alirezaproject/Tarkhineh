// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  String id;
  String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
