import 'package:cafe_app/core/constants/app_colors.dart';
import 'package:cafe_app/core/widgets/custom_button.dart';
import 'package:cafe_app/core/widgets/custom_text_field.dart';
import 'package:cafe_app/core/widgets/drop_box.dart';
import 'package:cafe_app/feature/home/presenation/controller/personnel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserScreen extends StatelessWidget {
  AddUserScreen({super.key});

  final _controller = Get.find<PersonnelModificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اضافه کردن کاربر'), centerTitle: true),
      backgroundColor: AppColors.backgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Column(
              children: [
                CustomTextField(
                  controller: _controller.userFirstNameController,
                  label: 'نام',
                  icon: Icons.person,
                  iconColor: AppColors.primaryColor,
                  fillColor: AppColors.cardBackground,
                  borderColor: AppColors.primaryColor,
                ),
                SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.userLastNameController,
                  label: 'نام خانوادگی',
                  iconColor: AppColors.primaryColor,
                  fillColor: AppColors.cardBackground,
                  borderColor: AppColors.primaryColor,
                  icon: Icons.person,
                ),
                SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.userPhoneNumberController,
                  label: 'شماره موبایل',
                  iconColor: AppColors.primaryColor,
                  fillColor: AppColors.cardBackground,
                  borderColor: AppColors.primaryColor,
                  icon: Icons.phone_android,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),

                CustomDropDown(
                  items: ['باریستا', 'سرپرست', 'سالن دار'],
                  title: 'مسئولیت',
                  onPressed: (value) {},
                ),

                SizedBox(height: 16),

                CustomDropDown(
                  items: ['شنبه', 'یکشنبه', 'دوشنبه', 'سه شنبه', 'چهارشنبه', 'پنجشنبه', 'جمعه'],
                  title: 'روز آف',
                  onPressed: (value) {},
                ),

                SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.userDescriptionsController,
                  label: 'توضیحات',
                  iconColor: AppColors.primaryColor,
                  fillColor: AppColors.cardBackground,
                  borderColor: AppColors.primaryColor,
                  maxLines: 4,
                  icon: Icons.description,
                ),
                SizedBox(height: 120), // فاصله اضافی تا آخر اسکرول
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: CustomConfirmButton(
        textColor: AppColors.backgroundColor,
        buttonColor: AppColors.primaryColor,
        title: 'اضافه کردن کاربر',
        onPressed: () {},
      ),
    );
  }
}
