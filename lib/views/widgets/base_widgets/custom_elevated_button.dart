import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_project_app/core/app_data.dart';
import 'package:tracking_project_app/views/widgets/styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.onPressed, required this.buttonName});

  final String buttonName;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      width: double.infinity.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: greenClr, foregroundColor: whiteClr),
        onPressed: onPressed,
        child: Text(
          buttonName,
          style: myTextStyle(fSize: 16.sp, fWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
