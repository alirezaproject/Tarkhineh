class FoodModel {
  final String id;
  final String name;
  final String ingredients;
  final String imageUrl;
  final int price;
  final int? discountPercent;
  final bool isSpecialOffer;
  final bool isFavorite;
  final int star;
  final int rateCount;

  FoodModel({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.imageUrl,
    required this.price,
    this.discountPercent,
    required this.isSpecialOffer,
    required this.isFavorite,
    required this.star,
    required this.rateCount,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: json['id'] as String,
      name: json['name'] as String,
      ingredients: json['ingredients'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as int,
      discountPercent: json['discountPercent'] as int?,
      isSpecialOffer: json['isSpecialOffer'] as bool,
      isFavorite: json['isFavorite'] as bool,
      star: json['star'] as int,
      rateCount: json['rateCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'imageUrl': imageUrl,
      'price': price,
      'discountPercent': discountPercent,
      'isSpecialOffer': isSpecialOffer,
      'isFavorite': isFavorite,
      'star': star,
      'rateCount': rateCount,
    };
  }
}
