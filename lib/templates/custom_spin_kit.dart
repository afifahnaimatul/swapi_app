import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swapi_app/templates/app_color.dart';

class CustomSpinKit extends StatelessWidget {
  const CustomSpinKit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRotatingCircle(
        color: AppColor.whiteColor,
      ),
    );
  }
}
