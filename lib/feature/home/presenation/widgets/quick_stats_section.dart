import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/app_colors.dart';
import '../home_controller.dart';
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
              color: AppColors.backgroundColor,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: StatCard(
              title: 'انبار داری',
              value: Icons.warehouse,
              color: AppColors.backgroundColor,
            ),
          ),
        ],
      );


  }
}
