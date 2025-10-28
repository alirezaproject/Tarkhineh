class BranchModel {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final String workHours;
  final String phoneNumber;
  final double latitude; // عرض جغرافیایی X
  final double longitude; // طول جغرافیایی Y

  BranchModel({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.workHours,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
  });

  // Deserialize from JSON
  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      workHours: json['workHours'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }
}
