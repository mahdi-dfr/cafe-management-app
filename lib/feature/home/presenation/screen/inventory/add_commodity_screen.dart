import 'package:cafe_app/feature/home/presenation/screen/inventory/warehouse_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/drop_box.dart';
import '../../controller/inventory_controller.dart';

class AddCommodityScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCategory;

  final List<String> _categories = ['ابزار فیزیکی', 'مواد خوراکی', 'بسته بندی'];
  final _controller = Get.find<InventoryController>();

  AddCommodityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('افزودن کالای جدید'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              CustomTextField(
                controller: _controller.nameController,
                label: 'نام کالا',
                icon: Icons.inventory_rounded,
                iconColor: AppColors.primaryColor,
                fillColor: AppColors.cardBackground,
                borderColor: AppColors.primaryColor,
                validator: (value) => value == null || value.isEmpty
                    ? 'نام کالا را وارد کنید'
                    : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _controller.priceController,
                label: 'قیمت واحد',
                iconColor: AppColors.primaryColor,
                fillColor: AppColors.cardBackground,
                borderColor: AppColors.primaryColor,
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: (value) =>
                value == null || value.isEmpty ? 'قیمت را وارد کنید' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _controller.priceController,
                label: 'تعداد',
                iconColor: AppColors.primaryColor,
                fillColor: AppColors.cardBackground,
                borderColor: AppColors.primaryColor,
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
                validator: (value) =>
                value == null || value.isEmpty ? 'قیمت را وارد کنید' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _controller.descriptionController,
                label: 'توضیحات',
                iconColor: AppColors.primaryColor,
                fillColor: AppColors.cardBackground,
                borderColor: AppColors.primaryColor,
                icon: Icons.description_outlined,
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              CustomDropDown(items: _categories, title: 'دسته‌بندی', onPressed: (String p1) {
                _selectedCategory = p1;
              }, color: AppColors.cardBackground,),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomConfirmButton(
        title: 'اضافه کردن کالا ',
        textColor: AppColors.backgroundColor,
        buttonColor: AppColors.primaryColor,
        onPressed: () {
        if (!(_formKey.currentState?.validate() ?? false)) return;

        if (_selectedCategory == null) {
          Get.snackbar(
            'هشدار',
            'دسته‌بندی را انتخاب کنید',
            backgroundColor: AppColors.error,
            colorText: Colors.white,
          );
          return;
        }

        Get.back();
      },
      ),
    );
  }
}