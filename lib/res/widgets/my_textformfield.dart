import 'package:attendancemanagementsystem/res/my_colors/my_colors.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final Color? hintTextColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? fillColor;
  final BorderSide border;
  final BorderSide enabledBorder;
  final BorderSide focusedBorderSide;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;

  const MyTextFormField(
      {super.key,
      required this.hintText,
      this.hintTextColor,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.fillColor,
      this.border = const BorderSide(color: Colors.grey, width: 2.0),
      this.enabledBorder = const BorderSide(color: Colors.grey, width: 2.0),
      this.focusedBorderSide = const BorderSide(color: Color(0xFF616161), width: 2.0),
      this.validator,
      required this.controller,
      this.keyboardType,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintTextColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          filled: true,
          fillColor: fillColor,
        border: OutlineInputBorder(
          borderSide: border
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: enabledBorder
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: focusedBorderSide
        ),
      ),
      validator: validator,
    );
  }
}
