import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{

  late final TextEditingController guestName;
  late final TextEditingController guestNumber;

  @override
  void onInit() {
    guestName = TextEditingController();
    guestNumber = TextEditingController();
    super.onInit();
  }

}