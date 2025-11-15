import 'package:cafe_app/core/constants/constantw.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        // leading: IconButton(color: AppColors.textPrimary, onPressed: () {}, icon: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          "حساب کاربری",
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // profile
            Column(
              children: [
                CircleAvatar(radius: 55, backgroundImage: NetworkImage(AppConstants.img)),
                SizedBox(height: 10),
                Text(
                  "Mahdi Daneshfar",
                  style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text("09121114455", style: TextStyle(color: AppColors.textSecondary)),
                SizedBox(height: 25),

                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.cardBackground),
                    child: Text('ویرایش پروفایل'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            AccountTile(
              title: "اطلاعات کاربر",
              subtitle: "توضیحاتی در مورد کاربر",
              icon: Icons.person,
              trailing: "جزئیات",
            ),

            AccountTile(title: "نقش", subtitle: "باریستا", icon: Icons.badge),

            AccountTile(title: "Theme", subtitle: "", icon: Icons.dark_mode, switchButton: true),
            SizedBox(height: 25),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.cardBackground),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_outlined, color: Colors.red,),
                    SizedBox(width: 10),
                    Text('خروج از حساب', ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? trailing;
  final bool switchButton;
  final bool isDestructive;

  const AccountTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
    this.switchButton = false,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(icon, color: isDestructive ? AppColors.secondaryColor : AppColors.secondaryColor, size: 26),
          const SizedBox(width: 14),

          // Title + Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDestructive ? AppColors.secondaryColor : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: TextStyle(color: AppColors.secondaryColor, fontSize: 13)),
              ],
            ),
          ),

          // trailing button
          if (trailing != null)
            Text(
              trailing!,
              style: TextStyle(color: AppColors.secondaryColor, fontWeight: FontWeight.w600),
            ),

          // switch
          if (switchButton) Switch(value: true, onChanged: (_) {}, activeColor: AppColors.secondaryColor),
        ],
      ),
    );
  }
}
