import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import 'activity_card.dart';
import '../../../../models/transaction_model.dart';

/// Recent activity section widget
class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'فعالیت‌های اخیر',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 15),
        const ActivityCard(
          title: 'خرید قهوه',
          subtitle: '۲ کاپوچینو',
          amount: '12500 تومان',
          date: 'دیروز',
          status: TransactionStatus.completed,
        ),
        const SizedBox(height: 12),
        const ActivityCard(
          title: 'سفارش شیرینی',
          subtitle: 'کروسان و مافین',
          amount: '8990 تومان',
          date: '۳ روز پیش',
          status: TransactionStatus.completed,
        ),
      ],
    );
  }
}
