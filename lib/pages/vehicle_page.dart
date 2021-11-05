import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/pages/vehicle_detailed_page.dart';
import 'package:swapi_app/services/vehicle_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class VehiclePage extends StatefulWidget {
  const VehiclePage({Key key}) : super(key: key);

  @override
  _VehiclesPagetate createState() => _VehiclesPagetate();
}

class _VehiclesPagetate extends State<VehiclePage> {
  var allData = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: (isLoading)
          ? CustomSpinKit()
          : Container(
              padding: EdgeInsets.all(AppSize.globalMargin),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/stars3.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  searchBar(),
                  SizedBox(height: 20),
                  Expanded(
                    child: vehicleBuilder(),
                  )
                  // contentTemplate(),
                ],
              ),
            ),
    );
  }

  initialFunction() async {
    isLoading = true;
    var response = await VehicleServices.getAllVehicle();

    setState(() {
      allData = response;
      isLoading = false;
    });
  }

  searchBar() => Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.grayColor,
        ),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'type a name/model',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      );

  vehicleBuilder() => ListView.separated(
      itemCount: allData.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => contentTemplate(
          allData[index]['name'],
          allData[index]['model'],
          allData[index]['passengers'],
          allData[index]['url']));

  contentTemplate(name, model, passenger, url) => InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VehicleDetailedPage(url: url))),
        child: Container(
          child: Row(
            children: [
              Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/star-wars-text.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: CustomTextStyle.subTitleStyle,
                  ),
                  SizedBox(height: 4),
                  contentBuilder('Model: ', model),
                  SizedBox(height: 4),
                  contentBuilder('Passengers: ', passenger),
                ],
              ),
            ],
          ),
        ),
      );

  contentBuilder(label, content) => RichText(
        text: TextSpan(
          text: label,
          style: CustomTextStyle.labelContentStyle,
          children: [
            TextSpan(text: content, style: CustomTextStyle.contentStyle)
          ],
        ),
      );
}
