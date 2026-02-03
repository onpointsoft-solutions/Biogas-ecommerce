class BookingModel {
  final String id;
  final String customerId;
  final String customerName;
  final String serviceId;
  final String serviceName;
  final String? technicianId;
  final String? technicianName;
  final DateTime bookingDate;
  final DateTime serviceDate;
  final String status; // 'pending', 'confirmed', 'in_progress', 'completed', 'cancelled'
  final double totalPrice;
  final String address;
  final String? notes;
  final List<PartModel> selectedParts;
  final String? rating;
  final String? review;

  BookingModel({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.serviceId,
    required this.serviceName,
    this.technicianId,
    this.technicianName,
    required this.bookingDate,
    required this.serviceDate,
    required this.status,
    required this.totalPrice,
    required this.address,
    this.notes,
    this.selectedParts = const [],
    this.rating,
    this.review,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      customerId: json['customerId'] ?? '',
      customerName: json['customerName'] ?? '',
      serviceId: json['serviceId'] ?? '',
      serviceName: json['serviceName'] ?? '',
      technicianId: json['technicianId'],
      technicianName: json['technicianName'],
      bookingDate: DateTime.parse(json['bookingDate']),
      serviceDate: DateTime.parse(json['serviceDate']),
      status: json['status'] ?? 'pending',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      address: json['address'] ?? '',
      notes: json['notes'],
      selectedParts: (json['selectedParts'] as List?)
              ?.map((e) => PartModel.fromJson(e))
              .toList() ??
          [],
      rating: json['rating'],
      review: json['review'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'technicianId': technicianId,
      'technicianName': technicianName,
      'bookingDate': bookingDate.toIso8601String(),
      'serviceDate': serviceDate.toIso8601String(),
      'status': status,
      'totalPrice': totalPrice,
      'address': address,
      'notes': notes,
      'selectedParts': selectedParts.map((e) => e.toJson()).toList(),
      'rating': rating,
      'review': review,
    };
  }
}

class PartModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String? image;
  final bool inStock;
  int quantity;

  PartModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.image,
    this.inStock = true,
    this.quantity = 1,
  });

  factory PartModel.fromJson(Map<String, dynamic> json) {
    return PartModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      category: json['category'] ?? '',
      image: json['image'],
      inStock: json['inStock'] ?? true,
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
      'inStock': inStock,
      'quantity': quantity,
    };
  }
}
