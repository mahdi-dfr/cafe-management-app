import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final int maxLines;
  final bool isEnable;
  final bool isPassword;
  final Color iconColor;
  final Color fillColor;
  final Color borderColor;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
    this.isEnable = true,
    this.isPassword = false,
    required this.iconColor,
    required this.fillColor,
    required this.borderColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscurePass = true; // حالت اولیه: پسورد مخفی باشد

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          enabled: widget.isEnable,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          obscureText: widget.isPassword ? _obscurePass : false,
          textDirection: TextDirection.rtl,
          validator: widget.validator,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: widget.iconColor),
            filled: true,
            fillColor: widget.fillColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Colors.white12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(color: widget.borderColor),
            ),

            /// 👇 آیکون نمایش/عدم نمایش پسورد
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                _obscurePass ? Icons.visibility_off : Icons.visibility,
                color: Colors.white70,
              ),
              onPressed: () {
                setState(() => _obscurePass = !_obscurePass);
              },
            )
                : null,
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
