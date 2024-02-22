import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tracking_project_app/core/app_data.dart';

Future<bool?> customToast({required String msg, required Color color}){
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: blackClr,
      fontSize: 16.0.sp
  );
}

SpinKitFadingCircle customCircularProgressIndicator = SpinKitFadingCircle(
  color: greenClr,
  size: 50.0.r,
);

TextStyle myTextStyle({required double fSize, required FontWeight fWeight, Color? clr}){
  return TextStyle(
    color: clr ?? blackClr,
    fontSize: fSize,
    fontWeight: fWeight,
    height: 1
  );
}