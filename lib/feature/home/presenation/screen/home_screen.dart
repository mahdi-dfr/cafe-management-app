import 'package:cafe_app/core/assets_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/app_colors.dart';
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
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
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
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.settings, color: AppColors.textPrimary,)),
      ),
      body: SafeArea(
        top: true,
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
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
    );
  }
}
