import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:cafe_app/core/widgets/card_list.dart';
import 'package:flutter/material.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('اعلان ها', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: ListView.separated(
            itemBuilder: (context, index) {
              return CustomInfoCard(
                icon: Icons.notifications,
                iconColor: Colors.red,
                title: 'یادآوری لیست کارهای های امروز',
                subtitle: 'امروز باید خرید های جدید رو انجام بدی',
              );
            },
            itemCount: 6,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          ),
        ),
      ),
    );
  }
}
