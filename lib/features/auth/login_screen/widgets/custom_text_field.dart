import 'package:flutter/material.dart';
import 'package:smart_learning/core/const/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      this.isObscureText = false,
      required this.validator,
      required this.controller});

  final String hintText;
  final Widget? suffixIcon;
  final bool isObscureText;
  final String? Function(String? value) validator;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isObscureText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.4),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red.shade900, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade900, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xff6A707C)),
          suffixIcon: suffixIcon,
          suffixIconColor: Color(0xff6A707C),
        ),
      ),
    );
  }
}
