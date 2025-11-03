import 'package:cafe_app/screens/splash_screen.dart';
import 'package:get/get.dart';

import '../../feature/history/presenation/transaction_detail_screen.dart'
    show TransactionDetailScreen;
import '../../screens/main_navigation.dart';

class RouteManagement {
  RouteManagement._();

  static final List<GetPage> routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/main', page: () => MainNavigation()),
    GetPage(
      name: '/transaction-detail',
      page: () {
        final args = Get.arguments;
        return TransactionDetailScreen(transaction: args);
      },
    ),
  ];
}
