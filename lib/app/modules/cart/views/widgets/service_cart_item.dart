import 'package:biogas_technician_app/app/data/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
// import '../../../data/models/service_model.dart';
import 'package:biogas_technician_app/app/components/custom_icon_button.dart';

// Local ServiceModel class to bypass import issues
class LocalServiceModel {
  int id;
  String image;
  String name;
  String description;
  String duration;
  double price;
  String technician;
  double rating;

  LocalServiceModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.technician,
    required this.rating,
  });
}

class ServiceCartItem extends StatelessWidget {
  final service;
  final int quantity;
  final void Function()? onIncrease;
  final void Function()? onDecrease;

  ServiceCartItem({
    Key? key,
    required this.service,
    required this.quantity,
    this.onIncrease,
    this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                  ),
                  child: service.image.contains('.svg')
                      ? SvgPicture.asset(service.image, fit: BoxFit.contain)
                      : service.image.contains('assets')
                          ? Image.asset(service.image, fit: BoxFit.cover)
                          : Icon(Icons.miscellaneous_services,
                              size: 30.sp, color: theme.primaryColor),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.verticalSpace,
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            service.duration,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        8.horizontalSpace,
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 12.sp),
                            4.horizontalSpace,
                            Text(
                              service.rating.toStringAsFixed(1),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    4.verticalSpace,
                    Text(
                      service.technician,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          8.verticalSpace,
          // Service description
          Text(
            service.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.hintColor,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          8.verticalSpace,
          // Price and quantity controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${service.price.toStringAsFixed(0)}',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  CustomIconButton(
                    width: 32.w,
                    height: 32.h,
                    onPressed: onDecrease,
                    icon: SvgPicture.asset(
                      Constants.removeIcon,
                      fit: BoxFit.none,
                    ),
                    backgroundColor: theme.cardColor,
                  ),
                  8.horizontalSpace,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      quantity.toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  CustomIconButton(
                    width: 32.w,
                    height: 32.h,
                    onPressed: onIncrease,
                    icon: SvgPicture.asset(
                      Constants.addIcon,
                      fit: BoxFit.none,
                    ),
                    backgroundColor: theme.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
