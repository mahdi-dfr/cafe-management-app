import 'package:flutter/material.dart';


class CustomConfirmButton extends StatelessWidget {
  const CustomConfirmButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
  });

  final String title;
  final Color buttonColor;
  final Color textColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
        bottom: 8 + MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
