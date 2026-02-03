import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/dummy_data.dart';

class MyBookingsController extends GetxController {
  final bookings = <BookingModel>[].obs;
  final selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookings();
  }

  void loadBookings() {
    final currentUser = DummyData.getCurrentUser();
    bookings.value =
        DummyData.getBookingsForUser(currentUser.id, currentUser.role);
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  List<BookingModel> get filteredBookings {
    switch (selectedTab.value) {
      case 0: // All
        return bookings;
      case 1: // Pending
        return bookings
            .where((b) => b.status == 'pending' || b.status == 'confirmed')
            .toList();
      case 2: // Completed
        return bookings.where((b) => b.status == 'completed').toList();
      default:
        return bookings;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Get.theme.colorScheme.secondary;
      case 'confirmed':
        return Color(0xFFFF8C00);
      case 'in_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    return status
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
