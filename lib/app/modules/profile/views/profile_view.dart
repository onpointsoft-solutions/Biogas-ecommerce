import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_icon_button.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/unsplash_service.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final authService = AuthService.to;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: theme.textTheme.headlineSmall),
        centerTitle: true,
      ),
      body: Obx(() => SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                // User Profile Section
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: theme.primaryColor,
                        backgroundImage: authService.user?.photoURL != null
                            ? NetworkImage(authService.user!.photoURL!)
                            : NetworkImage(UnsplashService.getProfileAvatar()),
                        child: authService.user?.photoURL == null ? null : null,
                      ),
                      20.verticalSpace,
                      Text(
                        authService.user?.displayName ?? 'Guest User',
                        style: theme.textTheme.titleLarge,
                      ),
                      8.verticalSpace,
                      Text(
                        authService.user?.email ?? 'Not signed in',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                    ],
                  ),
                ),
                30.verticalSpace,

                // Authentication Buttons
                if (!authService.isSignedIn) ...[
                  CustomIconButton(
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                    backgroundColor: Colors.white,
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.account_circle,
                            color: Colors.white, size: 24.w),
                        12.horizontalSpace,
                        Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 50.h,
                  ),
                ] else ...[
                  CustomIconButton(
                    onPressed: () => authService.signOut(),
                    backgroundColor: theme.primaryColor,
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: SvgPicture.asset(Constants.googleLogo,
                              width: 24.w, height: 24.h),
                        ),
                        12.horizontalSpace,
                        Text(
                          'Sign Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 50.h,
                  ),
                ],

                30.verticalSpace,

                // Service Information
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Biogas Technician Services',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.sp, // Reduced font size
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      16.verticalSpace,
                      _buildInfoRow(
                          'Emergency Service', '24/7 Available', theme),
                      _buildInfoRow(
                          'Certified Technicians', 'Professional Team', theme),
                      _buildInfoRow(
                          'Service Areas', 'Nationwide Coverage', theme),
                      _buildInfoRow(
                          'Customer Support', 'Dedicated Help', theme),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildInfoRow(String title, String value, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
