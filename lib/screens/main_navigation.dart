import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../core/app_colors.dart';
import '../feature/history/presenation/history_screen.dart';
import '../feature/home/presenation/screen/home_screen.dart';
import '../feature/profile/presenation/profile_screen.dart';

/// Main navigation screen with bottom navigation bar
class MainNavigation extends StatelessWidget {
  MainNavigation({super.key});

  final PersistentTabController _controller = PersistentTabController(
    initialIndex: 0,
  );

  List<Widget> _buildScreens() {
    return [const HomeScreen(), const HistoryScreen(), const ProfileScreen()];
  }

  @override
  Widget build(BuildContext context) {
    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home_rounded),
          title: 'خانه',
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.surfaceColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.history_rounded),
          title: 'تاریخچه',
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.surfaceColor,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person_rounded),
          title: 'حساب کاربری',
          activeColorPrimary: AppColors.primaryColor,
          inactiveColorPrimary: AppColors.surfaceColor,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: navBarsItems(),
      onItemSelected: (index) {},
      navBarHeight: 65,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.backgroundColor,
      navBarStyle: NavBarStyle.style12,
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: AppColors.backgroundColor,
      ),
    );
  }
}
