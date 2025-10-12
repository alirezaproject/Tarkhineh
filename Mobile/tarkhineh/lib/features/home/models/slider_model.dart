class SliderModel {
  final String id;
  final String imageUrl;
  final String title;

  SliderModel({required this.id, required this.imageUrl, required this.title});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(id: json['id'], title: json['title'], imageUrl: json['imageUrl']);
  }
}
