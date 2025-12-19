import 'package:cafe_app/feature/home/presenation/controller/inventory_controller.dart';
import 'package:cafe_app/feature/home/presenation/controller/personnel_controller.dart';
import 'package:cafe_app/feature/menu/presentation/controller/charter_controller.dart';
import 'package:cafe_app/feature/profile/presenation/controller/login_controller.dart';
import 'package:get/get.dart';

import '../../feature/home/presenation/controller/cafe_menu_controller.dart';
import '../../feature/home/presenation/controller/home_controller.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(LoginController());
    Get.lazyPut(()=> PersonnelModificationController(), fenix: true);
    Get.lazyPut(()=> InventoryController(), fenix: true);
    Get.lazyPut(()=> CharterController(), fenix: true);
    Get.lazyPut(()=> CafeMenuController(), fenix: true);
  }

}