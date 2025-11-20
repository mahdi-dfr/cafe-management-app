import 'package:get/get.dart';

/// Controller for Home Screen managing state and business logic
class HomeController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var totalOrders = 42.obs;
  var monthlyOrders = 8.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  /// Load initial data
  void _loadData() {
    isLoading.value = true;
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
    });
  }

  /// Refresh data
  void refreshData() {
    _loadData();
  }
}

