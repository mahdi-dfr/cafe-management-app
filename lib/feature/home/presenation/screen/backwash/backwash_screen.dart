import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:cafe_app/core/widgets/card_list.dart';
import 'package:cafe_app/core/widgets/choiceCips.dart';
import 'package:flutter/material.dart';

import '../../../../../muck_models/models.dart';

class BackwashScreen extends StatelessWidget {
  BackwashScreen({super.key});


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

            ChoiceChips(choiceList: weekDays, onSelected: (data){},),

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

