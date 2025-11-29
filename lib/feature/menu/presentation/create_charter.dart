import 'package:cafe_app/core/resource/app_colors.dart';
import 'package:cafe_app/core/widgets/custom_button.dart';
import 'package:cafe_app/core/widgets/custom_text_field.dart';
import 'package:cafe_app/feature/menu/presentation/controller/charter_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateCharter extends StatelessWidget {
  CreateCharter({super.key});

  final _controller = Get.find<CharterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: CustomConfirmButton(
        title: 'ذخیره اطلاعات',
        onPressed: () {},
        textColor: AppColors.backgroundColor,
        buttonColor: AppColors.primaryColor,
      ),
      appBar: AppBar(
        title: const Text('اضافه کردن منشور جدید', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Text(
                'در این قسمت میتوانید قوانین رفتاری جدیدی برای نیروها وضع کنید.\n این قابلیت صرفا در اختیار مدیر مجموعه است.',
              ),
              SizedBox(height: 56),
              CustomTextField(
                controller: _controller.charterTitle,
                label: 'عنوان منشور',
                icon: Icons.warning_amber_sharp,
                iconColor: AppColors.primaryColor,
                fillColor: AppColors.cardBackground,
                borderColor: AppColors.primaryColor,
              ),
              SizedBox(height: 24),
              CustomTextField(
                controller: _controller.charterDescription,
                label: 'توضیحات منشور',
                icon: Icons.warning_amber_sharp,
                iconColor: AppColors.primaryColor,
                fillColor: AppColors.cardBackground,
                maxLines: 5,
                borderColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
