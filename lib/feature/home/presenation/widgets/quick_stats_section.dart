import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_colors.dart';
import '../controller/home_controller.dart';
import '../screen/emploee_management.dart';
import '../screen/warehouse_management.dart';
import 'stat_card.dart';

/// Quick stats section widget
class QuickStatsSection extends StatelessWidget {
  const QuickStatsSection({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            child: StatCard(
              title: 'مدیریت پرسنل',
              value: Icons.group,
              color: AppColors.backgroundColor, onTap: () { Get.to(OurTeamList()); },
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: StatCard(
              title: 'انبار داری',
              value: Icons.warehouse,
              color: AppColors.backgroundColor, onTap: () { Get.to(WarehouseManagementScreen()); },
            ),
          ),
        ],
      );


  }
}
