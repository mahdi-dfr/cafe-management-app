
import 'package:cafe_app/feature/menu/presentation/menu_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/resource/route_management.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/assets_route.dart';
import '../controller/home_controller.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/quick_stats_section.dart';
import '../widgets/recent_activity_section.dart';
import '../widgets/welcome_section.dart';

/// Home screen displaying the main dashboard
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return PopScope(
      canPop: false,
     onPopInvokedWithResult: (bool didPop, Object? result){
       SystemNavigator.pop();

     },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: SvgPicture.asset(
            AssetsRoute.shookaLogo,
            colorFilter: ColorFilter.mode(AppColors.secondaryColor, BlendMode.srcIn),
            width: 100,
          ).animate(
              onPlay: (controller) =>
                  controller.repeat(reverse: false))
              .shimmer(
            delay: const Duration(milliseconds: 1000),
            duration: const Duration(milliseconds: 2000),
            color: AppColors.textPrimary,
          ),
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Get.toNamed(RouteManagement.menu);
          }, icon: Icon(Icons.menu, color: AppColors.textPrimary,)),
        ),
        body: SafeArea(
          top: true,
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeSection(),
                const SizedBox(height: 30),
                QuickStatsSection(controller: controller),
                const SizedBox(height: 30),
                const QuickActionsSection(),
                const SizedBox(height: 90),
                const PromoSlider(),
                // const RecentActivitySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
