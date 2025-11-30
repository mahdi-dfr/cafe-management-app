import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
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
        Row(
          children: [
            Expanded(
              child: ActionCard(
                icon: Icons.local_cafe,
                title: 'سفارش ها',
                color: AppColors.info,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ActionCard(
                icon: Icons.report,
                title: 'گزارش گیری',
                color: AppColors.info,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ActionCard(
                icon: Icons.attach_money_outlined,
                title: 'حسابداری',
                color: AppColors.info,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
