import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';

class AdminDashboardView extends GetView<AdminController> {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF8C00),
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: () => controller.loadData(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            color: Colors.grey[100],
            child: Obx(() => Row(
                  children: [
                    _buildTab('Services', 0),
                    _buildTab('Bookings', 1),
                    _buildTab('Parts', 2),
                  ],
                )),
          ),
          // Content
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              switch (controller.selectedTab.value) {
                case 0:
                  return _buildServicesTab();
                case 1:
                  return _buildBookingsTab();
                case 2:
                  return _buildPartsTab();
                default:
                  return _buildServicesTab();
              }
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(() {
        if (controller.selectedTab.value == 0) {
          return FloatingActionButton(
            onPressed: () => controller.showAddServiceDialog(),
            backgroundColor: Color(0xFFFF8C00),
            child: Icon(Icons.add, color: Colors.white),
          );
        }
        return SizedBox.shrink();
      }),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = controller.selectedTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Color(0xFFFF8C00) : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Color(0xFFFF8C00) : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServicesTab() {
    return Obx(() {
      if (controller.services.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.eco_rounded, size: 64.sp, color: Colors.grey[300]),
              16.verticalSpace,
              Text(
                'No services yet',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
              8.verticalSpace,
              Text(
                'Tap + to add a service',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: controller.services.length,
        itemBuilder: (context, index) {
          final service = controller.services[index];
          return Card(
            margin: EdgeInsets.only(bottom: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(12.w),
              leading: Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F9E8),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.eco_rounded, color: Color(0xFFFF8C00)),
              ),
              title: Text(
                service.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  4.verticalSpace,
                  Text(
                    '\$${service.price.toStringAsFixed(2)} • ${service.duration}',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  4.verticalSpace,
                  Text(
                    service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('Edit'),
                    value: 'edit',
                  ),
                  PopupMenuItem(
                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                    value: 'delete',
                  ),
                ],
                onSelected: (value) {
                  if (value == 'delete') {
                    controller.deleteService(service.id.toString());
                  }
                },
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildBookingsTab() {
    return Obx(() {
      if (controller.bookings.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today, size: 64.sp, color: Colors.grey[300]),
              16.verticalSpace,
              Text(
                'No bookings yet',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: controller.bookings.length,
        itemBuilder: (context, index) {
          final booking = controller.bookings[index];
          return Card(
            margin: EdgeInsets.only(bottom: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          booking.serviceName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: controller
                              .getStatusColor(booking.status)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          booking.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: controller.getStatusColor(booking.status),
                          ),
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Text(
                    'Customer: ${booking.customerName}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                  ),
                  4.verticalSpace,
                  Text(
                    'Date: ${booking.serviceDate.day}/${booking.serviceDate.month}/${booking.serviceDate.year}',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                  ),
                  4.verticalSpace,
                  Text(
                    'Total: \$${booking.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF8C00),
                    ),
                  ),
                  if (booking.selectedParts.isNotEmpty) ...[
                    8.verticalSpace,
                    Text(
                      'Parts: ${booking.selectedParts.length} items',
                      style:
                          TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                    ),
                  ],
                  12.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => controller.updateBookingStatus(
                              booking, 'confirmed'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.blue),
                          ),
                          child: Text('Confirm',
                              style: TextStyle(fontSize: 11.sp)),
                        ),
                      ),
                      8.horizontalSpace,
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => controller.updateBookingStatus(
                              booking, 'completed'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.green),
                          ),
                          child: Text('Complete',
                              style: TextStyle(fontSize: 11.sp)),
                        ),
                      ),
                      8.horizontalSpace,
                      IconButton(
                        icon:
                            Icon(Icons.delete, color: Colors.red, size: 20.sp),
                        onPressed: () => controller.deleteBooking(booking.id),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildPartsTab() {
    return Obx(() {
      if (controller.parts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.build, size: 64.sp, color: Colors.grey[300]),
              16.verticalSpace,
              Text(
                'No parts yet',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: controller.parts.length,
        itemBuilder: (context, index) {
          final part = controller.parts[index];
          return Card(
            margin: EdgeInsets.only(bottom: 12.h),
            child: ListTile(
              leading: Icon(Icons.build, color: Color(0xFFFF8C00)),
              title: Text(part.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(part.description),
              trailing: Text(
                '\$${part.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF8C00),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
