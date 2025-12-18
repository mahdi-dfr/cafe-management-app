import 'package:cafe_app/feature/home/presenation/screen/backwash/backwash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../screen/orders/orders_screen.dart';
import 'action_card.dart';

/// Quick actions section widget
class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'عملیات سریع',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ActionCard(
                icon: Icons.local_cafe,
                title: 'سفارش ها',
                color: AppColors.info, onTap: () {
                  Get.to(CafeTablesScreen());
              },
              ),
              const SizedBox(width: 15),
              ActionCard(
                icon: Icons.water_sharp,
                title: 'بک واش کافه',
                color: AppColors.info, onTap: () {
                  Get.to(BackwashScreen());
              },
              ),
              const SizedBox(width: 15),
              ActionCard(
                icon: Icons.report,
                title: 'گزارش گیری',
                color: AppColors.info, onTap: () {  },
              ),
              const SizedBox(width: 15),
              ActionCard(
                icon: Icons.attach_money_outlined,
                title: 'حسابداری',
                color: AppColors.info, onTap: () {  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
