import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../data/models/category_model.dart';
import '../routes/app_pages.dart';

// Extension for vertical space
extension VerticalSpace on double {
  SizedBox get verticalSpace => SizedBox(height: this);
}

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PRODUCTS),
      child: Container(
        width: 90.w,
        child: Column(
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.primaryColor.withOpacity(0.15),
                    theme.primaryColor.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(0.1),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  category.image,
                  width: 32.w,
                  height: 32.w,
                ),
              ),
            ).animate().scale(duration: 300.ms, curve: Curves.easeOut),
            12.verticalSpace,
            Text(
              category.title,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
          ],
        ),
      ),
    );
  }
}
