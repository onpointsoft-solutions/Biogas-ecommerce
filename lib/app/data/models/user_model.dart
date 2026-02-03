class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role; // 'customer', 'technician', 'admin'
  final String? profileImage;
  final String? address;
  final double? rating;
  final int? completedJobs;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImage,
    this.address,
    this.rating,
    this.completedJobs,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'customer',
      profileImage: json['profileImage'],
      address: json['address'],
      rating: json['rating']?.toDouble(),
      completedJobs: json['completedJobs'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'profileImage': profileImage,
      'address': address,
      'rating': rating,
      'completedJobs': completedJobs,
    };
  }
}
