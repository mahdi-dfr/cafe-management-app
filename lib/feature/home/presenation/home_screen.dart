
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_colors.dart';
import 'home_controller.dart';
import 'widgets/welcome_section.dart';
import 'widgets/quick_stats_section.dart';
import 'widgets/quick_actions_section.dart';
import 'widgets/recent_activity_section.dart';

/// Home screen displaying the main dashboard
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
              PromoSlider()
              // const RecentActivitySection(),
            ],
          ),
        ),
      ),
    );
  }
}


