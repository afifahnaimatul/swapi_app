import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/services/vehicle_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class VehicleListView extends StatefulWidget {
  String url = "";
  VehicleListView({@required this.url, Key key}) : super(key: key);

  @override
  _VehicleListViewState createState() => _VehicleListViewState();
}

class _VehicleListViewState extends State<VehicleListView> {
  var detailedData = {};
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSize.globalMargin),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: imageBuilder(),
          ),
          SizedBox(height: 20),
          Text(
            detailedData['name'],
            style: CustomTextStyle.titleStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          contentBuilder('Cargo Capacity: ', detailedData['cargo_capacity']),
          contentBuilder('Consumables: ', detailedData['consumables']),
          contentBuilder('Cost in credits: ', detailedData['cost_in_credits']),
          contentBuilder('Crew: ', detailedData['crew']),
          contentBuilder('Length: ', detailedData['length']),
          contentBuilder('Manufacturer: ', detailedData['manufacturer']),
          contentBuilder('Max Atmosphering Speed: ',
              detailedData['max_atmosphering_speed']),
          contentBuilder('Model: ', detailedData['model']),
          contentBuilder('Passengers: ', detailedData['passengers']),
          contentBuilder('Vehicle Class: ', detailedData['vehicle_class']),
        ],
      ),
    );
  }

  initialFunction() async {
    isLoading = true;
    var response = await VehicleServices.getDetailedVehicle(widget.url);

    setState(() {
      detailedData = response;
      isLoading = false;
    });
  }

  imageBuilder() => Container(
        height: 300,
        width: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/star-wars-background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      );

  contentBuilder(label, content) => Container(
        padding: EdgeInsets.only(bottom: 4),
        child: RichText(
          text: TextSpan(
            text: label,
            style: CustomTextStyle.labelContentStyle,
            children: [
              TextSpan(text: content, style: CustomTextStyle.contentStyle)
            ],
          ),
        ),
      );
}
