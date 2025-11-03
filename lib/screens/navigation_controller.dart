import 'package:get/get.dart';

/// Navigation Controller for managing bottom navigation state
class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}


