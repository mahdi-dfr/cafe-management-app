import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:cafe_app/core/widgets/card_list.dart';
import 'package:flutter/material.dart';

import '../../../../../muck_models/models.dart';

class BackwashScreen extends StatelessWidget {
  const BackwashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بک واش'),
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            ChoiceDay(),

            const SizedBox(height: 12),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    ///todo : filter based on day
                    // backwashList[index].day == weekDays[selectedDayIndex]
                    final item = backwashList[index];

                    return CustomInfoCard(
                      icon: Icons.water_rounded,
                      iconColor:
                      item.status! ? AppColors.secondaryColor : Colors.red,
                      title: item.title!,
                      subtitle: item.user!,
                      statusColor:
                      item.status! ? AppColors.secondaryColor : Colors.red,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemCount: backwashList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceDay extends StatefulWidget {
  const ChoiceDay({super.key});

  @override
  State<ChoiceDay> createState() => _ChoiceDayState();
}

class _ChoiceDayState extends State<ChoiceDay> {
  int selectedDayIndex = 0;

  final List<String> weekDays = [
    "شنبه",
    "یکشنبه",
    "دوشنبه",
    "سه‌شنبه",
    "چهارشنبه",
    "پنجشنبه",
    "جمعه",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: weekDays.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final bool isActive = index == selectedDayIndex;
          return ChoiceChip(
            label: Text(
              weekDays[index],
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            selected: isActive,
            onSelected: (_) {
              setState(() => selectedDayIndex = index);
            },
            selectedColor: AppColors.secondaryColor,
            backgroundColor: AppColors.tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }
}

