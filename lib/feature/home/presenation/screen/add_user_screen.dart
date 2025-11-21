import 'package:cafe_app/core/app_colors.dart';
import 'package:cafe_app/core/widgets/custom_button.dart';
import 'package:cafe_app/core/widgets/custom_text_field.dart';
import 'package:cafe_app/feature/home/presenation/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserScreen extends StatelessWidget {
  AddUserScreen({super.key});

  final _controller = Get.find<UserModificationController>();

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
                ),
                SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.userLastNameController,
                  label: 'نام خانوادگی',
                  icon: Icons.person,
                ),
                SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.userPhoneNumberController,
                  label: 'شماره موبایل',
                  icon: Icons.phone_android,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16),

                CustomTextField(
                  controller: _controller.userDescriptionsController,
                  label: 'توضیحات',
                  maxLines: 4,
                  icon: Icons.description,
                ),
                SizedBox(height: 120), // فاصله اضافی تا آخر اسکرول
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: FormConfirmButton(title: 'اضافه کردن کاربر', onPressed: () {  },)
    );
  }
}
