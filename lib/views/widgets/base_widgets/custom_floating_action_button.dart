import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_project_app/core/app_data.dart';

class CustomFloatingActionButton extends StatelessWidget {

  final void Function()? onPressed;
  const CustomFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      backgroundColor: greenClr,
      foregroundColor: whiteClr,
      child: Icon(
        Icons.add,
        size: 25.sp,
        color: blackClr,
      ),
    );
  }
}
