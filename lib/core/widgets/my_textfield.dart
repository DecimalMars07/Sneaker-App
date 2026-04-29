import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixIcon,
    this.maxLines = 1,
    this.obscure = false,
    this.fillColor,
    this.filled = false,
    this.hintColor,
    this.textColor,
  });

  final TextEditingController controller;
  final String hint;
  final Icon? prefixIcon;
  final int? maxLines;
  final bool obscure;
  final Color? fillColor;
  final bool filled;
  final Color? hintColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return TextField(
      style: TextStyle(
        color: textColor,
        fontSize: screenWidth * 0.045,
      ),
      controller: controller,
      maxLines: maxLines,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.04,
          color: hintColor,
          fontWeight: FontWeight.normal,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.04,
        ),
        prefixIcon: prefixIcon,
        fillColor: fillColor,
        filled: filled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.08),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.08),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.08),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}