import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CharterController extends GetxController{
  late TextEditingController charterTitle;
  late TextEditingController charterDescription;

  @override
  void onInit() {
    charterTitle = TextEditingController();
    charterDescription = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    charterTitle.dispose();
    charterDescription.dispose();
    super.onClose();
  }
}