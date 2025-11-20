import 'package:flutter/material.dart';

import '../app_colors.dart';

class FormConfirmButton extends StatelessWidget {
  const FormConfirmButton({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(title, style: TextStyle(color: AppColors.backgroundColor, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
