import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:cafe_app/core/widgets/card_list.dart';
import 'package:flutter/material.dart';

import '../../../../../muck_models/models.dart';

class BackwashScreen extends StatelessWidget {
  const BackwashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بک واش'), centerTitle: true),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return CustomInfoCard(

                icon: Icons.water_rounded,
                iconColor: backwashList[index].status! ?  AppColors.secondaryColor : Colors.red,
                title: backwashList[index].title!,
                subtitle: backwashList[index].user!,
                statusColor: backwashList[index].status! ?  AppColors.secondaryColor : Colors.red,
                caption: backwashList[index].day!,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
            itemCount: backwashList.length,
          ),
        ),
      ),
    );
  }
}
