import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserModificationController extends GetxController{

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

}