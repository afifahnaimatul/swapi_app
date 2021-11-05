import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/templates/app_color.dart';

class CustomTextStyle {
  static TextStyle logoStyle = TextStyle(
    color: AppColor.yellowColor,
    fontSize: 50,
    fontWeight: FontWeight.bold,
    fontFamily: 'StarJedi',
  );

  static TextStyle titleStyle = TextStyle(
    color: AppColor.whiteColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );

  static TextStyle subTitleStyle = TextStyle(
    color: AppColor.whiteColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static TextStyle labelContentStyle = TextStyle(
    color: AppColor.grayColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static TextStyle contentStyle = TextStyle(
    color: AppColor.whiteColor,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}
