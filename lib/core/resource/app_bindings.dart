import 'package:cafe_app/feature/home/presenation/controller/inventory_controller.dart';
import 'package:cafe_app/feature/home/presenation/controller/user_controller.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> UserModificationController(), fenix: true);
    Get.lazyPut(()=> InventoryController(), fenix: true);
  }

}