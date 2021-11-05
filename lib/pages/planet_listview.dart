import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/services/planet_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class PlanetListView extends StatefulWidget {
  String url = "";
  PlanetListView({@required this.url, Key key}) : super(key: key);

  @override
  _PlanetListView createState() => _PlanetListView();
}

class _PlanetListView extends State<PlanetListView> {
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
    return (isLoading)
        ? CustomSpinKit()
        : Container(
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
                contentBuilder('Climate: ', detailedData['climate']),
                contentBuilder('Diameter: ', detailedData['diameter']),
                contentBuilder('Gravity: ', detailedData['gravity']),
                contentBuilder(
                    'Orbital Period: ', detailedData['orbital_period']),
                contentBuilder(
                    'Rotation Period: ', detailedData['rotation_period']),
                contentBuilder('Population: ', detailedData['population']),
                contentBuilder(
                    'Surface Water: ', detailedData['surface_water']),
                contentBuilder('Terrain: ', detailedData['terrain']),
              ],
            ),
          );
  }

  initialFunction() async {
    isLoading = true;
    var response = await PlanetServices.getDetailedPlanet(widget.url);

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
