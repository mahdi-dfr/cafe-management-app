import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/user_model.dart';

/// Controller for Profile Screen managing user data
class ProfileController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var isEditing = false.obs;
  var user = UserModel.getMockUser().obs;

  // Form fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.onClose();
  }

  /// Initialize text controllers with current user data
  void _initializeControllers() {
    nameController.text = user.value.name;
    emailController.text = user.value.email;
    mobileController.text = user.value.mobileNumber;
  }

  /// Toggle edit mode
  void toggleEditMode() {
    isEditing.value = !isEditing.value;
    if (isEditing.value) {
      _initializeControllers();
    }
  }

  /// Save profile changes
  void saveProfile() {
    isLoading.value = true;

    // Validate inputs
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Name cannot be empty',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      return;
    }

    if (emailController.text.trim().isEmpty ||
        !GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
      return;
    }

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      user.value = UserModel(
        id: user.value.id,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        mobileNumber: user.value.mobileNumber, // Mobile cannot be changed
        profileImageUrl: user.value.profileImageUrl,
      );

      isLoading.value = false;
      isEditing.value = false;

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    });
  }

  /// Cancel editing
  void cancelEdit() {
    _initializeControllers();
    isEditing.value = false;
  }
}
