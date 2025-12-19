import 'package:cafe_app/feature/menu/presentation/screens/menu_screen.dart';
import 'package:cafe_app/feature/profile/presenation/login_screen.dart';
import 'package:cafe_app/screens/splash_screen.dart';
import 'package:get/get.dart';

import '../../feature/history/presenation/transaction_detail_screen.dart'
    show TransactionDetailScreen;
import '../../feature/menu/presentation/screens/notification_screen.dart';
import '../../screens/main_navigation.dart';

class RouteManagement {
  RouteManagement._();

  static String splashScreen = '/';
  static String mainNavigation = '/main';
  static String transactionDetail = '/transaction-detail';
  static String menu = '/menu';
  static String login = '/login';
  static String notification = '/notification';

  static final List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: mainNavigation, page: () => MainNavigation()),
    GetPage(name: menu, page: () => MenuScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: notification, page: () => NotificationScreen()),
    GetPage(
      name: '/transaction-detail',
      page: () {
        final args = Get.arguments;
        return TransactionDetailScreen(transaction: args);
      },
    ),
  ];
}
