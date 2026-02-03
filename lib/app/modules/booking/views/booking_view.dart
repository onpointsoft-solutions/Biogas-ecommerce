import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/dummy_data.dart';
import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Book Service',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service Info Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Color(0xFFF5F9E8),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.eco_rounded,
                        color: Color(0xFFFF8C00), size: 30.sp),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.service.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          '\$${controller.service.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF8C00),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,

            // Select Date
            Text(
              'Select Date & Time',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            12.verticalSpace,
            Obx(() => InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today, color: Color(0xFFFF8C00)),
                        12.horizontalSpace,
                        Text(
                          controller.selectedDate.value != null
                              ? '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}'
                              : 'Select service date',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: controller.selectedDate.value != null
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            24.verticalSpace,

            // Select Technician
            Text(
              'Select Technician',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            12.verticalSpace,
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: DummyData.getTechnicians().length,
                itemBuilder: (context, index) {
                  final technician = DummyData.getTechnicians()[index];
                  return Obx(() => GestureDetector(
                        onTap: () => controller.selectTechnician(technician),
                        child: Container(
                          width: 80.w,
                          margin: EdgeInsets.only(right: 12.w),
                          child: Column(
                            children: [
                              Container(
                                width: 60.w,
                                height: 60.w,
                                decoration: BoxDecoration(
                                  color:
                                      controller.selectedTechnician.value?.id ==
                                              technician.id
                                          ? Color(0xFFFF8C00)
                                          : Colors.grey[200],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: controller
                                                .selectedTechnician.value?.id ==
                                            technician.id
                                        ? Color(0xFFFF8C00)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color:
                                      controller.selectedTechnician.value?.id ==
                                              technician.id
                                          ? Colors.white
                                          : Colors.grey,
                                  size: 30.sp,
                                ),
                              ),
                              8.verticalSpace,
                              Text(
                                technician.name.split(' ')[0],
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ));
                },
              ),
            ),
            24.verticalSpace,

            // Parts Selection
            Text(
              'Select Parts/Goods (Optional)',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            8.verticalSpace,
            Text(
              'Choose parts needed for repair or installation',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
            12.verticalSpace,
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: DummyData.parts.length,
              itemBuilder: (context, index) {
                final part = DummyData.parts[index];
                return Obx(() {
                  final isSelected = controller.isPartSelected(part.id);
                  final selectedPart = controller.selectedParts
                      .firstWhereOrNull((p) => p.id == part.id);

                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFFFFF4E6) : Colors.grey[50],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color:
                            isSelected ? Color(0xFFFF8C00) : Colors.grey[200]!,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isSelected,
                          onChanged: (value) => controller.togglePart(part),
                          activeColor: Color(0xFFFF8C00),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                part.name,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              4.verticalSpace,
                              Text(
                                part.description,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              4.verticalSpace,
                              Text(
                                '\$${part.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF8C00),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected) ...[
                          12.horizontalSpace,
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline,
                                    size: 20.sp),
                                onPressed: () {
                                  if (selectedPart != null &&
                                      selectedPart.quantity > 1) {
                                    controller.updatePartQuantity(
                                        part.id, selectedPart.quantity - 1);
                                  }
                                },
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                              8.horizontalSpace,
                              Text(
                                '${selectedPart?.quantity ?? 1}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              8.horizontalSpace,
                              IconButton(
                                icon:
                                    Icon(Icons.add_circle_outline, size: 20.sp),
                                onPressed: () {
                                  if (selectedPart != null) {
                                    controller.updatePartQuantity(
                                        part.id, selectedPart.quantity + 1);
                                  }
                                },
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                });
              },
            ),
            24.verticalSpace,

            // Total Price
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Color(0xFFF5F9E8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Obx(() => Text(
                        '\$${controller.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF8C00),
                        ),
                      )),
                ],
              ),
            ),
            24.verticalSpace,

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.confirmBooking(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF8C00),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFFFF8C00),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.selectDate(picked);
    }
  }
}
