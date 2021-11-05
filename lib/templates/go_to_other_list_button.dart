import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/custom_text_style.dart';
import 'package:swapi_app/templates/listview_templates.dart';

goToOtherList(context, text, page, url) => (url.length == 0)
    ? SizedBox()
    : InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListViewTemplates(url: url, page: page))),
        child: Container(
          height: 60,
          width: double.infinity,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColor.yellowColor,
              width: 2,
            ),
          ),
          child: Text(
            text,
            style: CustomTextStyle.titleStyle,
          ),
        ),
      );
