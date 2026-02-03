class ServiceModel {
  int id;
  String image;
  String name;
  String description;
  String duration;
  double price;
  String technician;
  double rating;

  ServiceModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.technician,
    this.rating = 0.0,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as int,
      image: json['image'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      technician: json['technician'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
