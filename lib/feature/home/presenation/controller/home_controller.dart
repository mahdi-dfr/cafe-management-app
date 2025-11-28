import 'package:get/get.dart';

class HomeController extends GetxController {

  var isLoading = false.obs;
  var canExit = false.obs;
  var isFirstClick = false.obs;
  var totalOrders = 42.obs;
  var monthlyOrders = 8.obs;
  DateTime? lastBackPressed;


}

