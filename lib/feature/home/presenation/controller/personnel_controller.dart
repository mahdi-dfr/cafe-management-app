
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonnelModificationController extends GetxController{

  late TextEditingController userFirstNameController;
  late TextEditingController userLastNameController;
  late TextEditingController userPhoneNumberController;
  late TextEditingController userDescriptionsController;


  @override
  void onInit() {
    userFirstNameController = TextEditingController();
    userPhoneNumberController = TextEditingController();
    userLastNameController = TextEditingController();
    userDescriptionsController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    userFirstNameController.dispose();
    userPhoneNumberController.dispose();
    userLastNameController.dispose();
    userDescriptionsController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    userFirstNameController.dispose();
    userPhoneNumberController.dispose();
    userLastNameController.dispose();
    userDescriptionsController.dispose();
    super.onClose();
  }

}