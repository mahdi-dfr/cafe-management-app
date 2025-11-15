import 'package:cafe_app/core/constants/constantw.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_colors.dart';
import 'profile_controller.dart';
import 'widgets/profile_text_field.dart';

/// Edit profile screen
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'ویرایش پروفایل',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 22),
               Hero(
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
                      child:  ClipOval(
                              child: Image.network(
                                AppConstants.img,
                                fit: BoxFit.cover,
                              ),
                            )
                    ),
                  ),
                ),
              // Edit Content
               Container(
                  margin: const EdgeInsets.only(top: 80),
                  padding: const EdgeInsets.all(24),
                  child: EditProfileForm(controller: controller),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Edit profile form widget
class EditProfileForm extends StatelessWidget {
  final ProfileController controller;

  const EditProfileForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const SizedBox(height: 30),
        // Name Input
        ProfileTextField(
          controller: controller.nameController,
          label: 'نام کامل',
          icon: Icons.person_outline,
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 20),
        // Email Input
        ProfileTextField(
          controller: controller.emailController,
          label: 'ایمیل',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        // Mobile Input (Disabled)
        ProfileTextField(
          controller: controller.mobileController,
          label: 'شماره موبایل',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          enabled: false,
        ),
        const SizedBox(height: 30),
        // Action Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: controller.cancelEdit,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.backgroundColor),
                  ),
                ),
                child: Text(
                  'انصراف',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.white,
                            ),
                          ),
                        )
                      : Text(
                          'ذخیره',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.backgroundColor,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
