import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_colors.dart';
import 'profile_controller.dart';
import 'widgets/profile_info_card.dart';
import 'edit_profile_screen.dart';

/// Profile screen displaying user information
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 22),
              Obx(
                () => Hero(
                  tag: 'profile_picture',
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Implement image picker
                    },
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowColor,
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: controller.user.value.profileImageUrl != null
                          ? ClipOval(
                              child: Image.network(
                                controller.user.value.profileImageUrl!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 60,
                              color: AppColors.backgroundColor,
                            ),
                    ),
                  ),
                ),
              ),
              // Profile Content
               Container(
                  margin: const EdgeInsets.only(top: 80),
                  padding: const EdgeInsets.all(24),
                  child: ProfileViewMode(controller: controller),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Profile view mode widget
class ProfileViewMode extends StatelessWidget {
  final ProfileController controller;

  const ProfileViewMode({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Welcome Text
        Text(
          controller.user.value.name,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 8),
        Text(
          controller.user.value.email,
          style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          textDirection: TextDirection.ltr,
        ),
        const SizedBox(height: 40),
        // User Info Cards
        ProfileInfoCard(
          icon: Icons.person_outline,
          label: 'نام کامل',
          value: controller.user.value.name,
        ),
        const SizedBox(height: 16),
        ProfileInfoCard(
          icon: Icons.email_outlined,
          label: 'ایمیل',
          value: controller.user.value.email,
        ),
        const SizedBox(height: 16),
        ProfileInfoCard(
          icon: Icons.phone_outlined,
          label: 'شماره موبایل',
          value: controller.user.value.mobileNumber,
          isReadOnly: true,
        ),
        const SizedBox(height: 30),
        // Edit Button
        ElevatedButton(
          onPressed: () {
            Get.to(() => const EditProfileScreen());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.lightPurple,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            'ویرایش پروفایل',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
