import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:cafe_app/core/widgets/custom_button.dart';
import 'package:cafe_app/core/widgets/custom_text_field.dart';
import 'package:cafe_app/feature/profile/presenation/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/assets_route.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: CustomConfirmButton(
          title: 'ورود به برنامه', onPressed: () {},
        textColor: AppColors.backgroundColor,
        buttonColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          children: [
            Lottie.asset(AssetsRoute.cafe2),
            SizedBox(height: 50),
            Text('ورود به برنامه', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            SizedBox(height: 20,),
            CustomTextField(
              controller: _controller.username,
              label: 'نام کاربری',
              icon: Icons.person,
              iconColor: AppColors.primaryColor,
              fillColor: AppColors.cardBackground,
              borderColor: AppColors.primaryColor,
            ),
            SizedBox(height: 25),
            CustomTextField(
              controller: _controller.username,
              label: 'رمز عبور',
              isPassword: true,
              icon: Icons.security,
              iconColor: AppColors.primaryColor,
              fillColor: AppColors.cardBackground,
              borderColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
