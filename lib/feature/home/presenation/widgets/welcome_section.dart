import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

/// Welcome section widget
class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'روز بخیر مهدی 👋',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textDirection: TextDirection.rtl,
        ),
        const SizedBox(height: 8),
        Text(
          'اینجا تمام اطلاعاتی که لازم داری هست!',
          style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
