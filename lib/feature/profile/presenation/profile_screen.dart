import 'package:cafe_app/core/constants/constant.dart';
import 'package:cafe_app/feature/menu/presentation/screens/group_charter/group_charter.dart';
import 'package:cafe_app/feature/profile/presenation/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/item_tile.dart';

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
        child: SingleChildScrollView(
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
                      onPressed: () {
                        Get.to(() => EditProfileScreen());
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.cardBackground),
                      child: Text('ویرایش پروفایل'),
                    ),
                  ),

                  SizedBox(height: 14),

                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.cardBackground),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_outlined, color: Colors.red),
                          SizedBox(width: 10),
                          Text('خروج از حساب'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 100,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.primaryColor, width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '102',
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                            ),
                            SizedBox(height: 8),
                            Text('امتیاز این ماه'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.primaryColor, width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1200',
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                            ),
                            SizedBox(height: 8),
                            Text('مجموع امتیازات'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              ItemTile(
                title: "اطلاعات کاربر",
                subtitle: "توضیحاتی در مورد کاربر",
                icon: Icons.person,
                trailing: "جزئیات",
                onTap: () {},
              ),
              SizedBox(height: 14),

              ItemTile(title: "نقش", subtitle: "باریستا", icon: Icons.badge, onTap: () {}),
              SizedBox(height: 14),

              ItemTile(title: "منشور مجموعه", subtitle: "قوانین مجموعه", icon: Icons.badge, onTap: () {
                Get.to(GroupCharter());
              }),
              SizedBox(height: 14),

              ItemTile(title: "روز آف", subtitle: "چهارشنبه", icon: Icons.calendar_month, onTap: () {}),

              // ItemTile(title: "Theme", subtitle: "", icon: Icons.dark_mode, switchButton: true),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
