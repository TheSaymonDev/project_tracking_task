import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_project_app/core/app_data.dart';
import 'package:tracking_project_app/views/widgets/styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.keyBoardType,
    this.maxLines,
  });

  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyBoardType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.normal),
      controller: controller,
      cursorColor: blackClr,
      readOnly: readOnly,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyBoardType,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: myTextStyle(fSize: 16.sp, fWeight: FontWeight.normal, clr: greyColor),
        fillColor: const Color(0xFFFFFFE4),
        filled: true,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: greyColor.withOpacity(0.3), width: 1.w)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide(color: greenClr, width: 1.w)),
      ),
    );
  }
}