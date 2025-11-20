import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InventoryController extends GetxController{

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  @override
  void onInit() {
    nameController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.onInit();
  }

}