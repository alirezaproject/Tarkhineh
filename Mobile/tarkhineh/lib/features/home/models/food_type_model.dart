class FoodTypeModel {
  final String id;
  final String name;
  final String imageUrl;

  const FoodTypeModel({required this.id, required this.name, required this.imageUrl});

  factory FoodTypeModel.fromJson(Map<String, dynamic> json) {
    return FoodTypeModel(id: json['id'], name: json['name'], imageUrl: json['imageUrl']);
  }
}
