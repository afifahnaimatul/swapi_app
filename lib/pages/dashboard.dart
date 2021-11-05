import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/pages/film_page.dart';
import 'package:swapi_app/pages/people_page.dart';
import 'package:swapi_app/pages/planet_page.dart';
import 'package:swapi_app/pages/species_page.dart';
import 'package:swapi_app/pages/starship_page.dart';
import 'package:swapi_app/pages/vehicle_page.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key key}) : super(key: key);
  var content = [
    {
      'name': "people",
      'page': PeoplePage(),
    },
    {
      'name': "planets",
      'page': PlanetPage(),
    },
    {
      'name': "films",
      'page': FilmPage(),
    },
    {
      'name': "species",
      'page': SpeciesPage(),
    },
    {
      'name': "starships",
      'page': StarshipPage(),
    },
    {
      'name': "vehicles",
      'page': VehiclePage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSize.globalMargin),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/stars.jpg'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Star Wars',
                style: CustomTextStyle.logoStyle,
              ),
              subMenuBuilder(context),
            ],
          ),
        ),
      ),
    );
  }

  subMenuBuilder(context) => ListView.builder(
        shrinkWrap: true,
        itemCount: content.length,
        itemBuilder: (context, index) =>
            subMenu(context, content[index]['name'], content[index]['page']),
      );

  subMenu(context, text, onTap) => InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => onTap)),
        child: Container(
          height: 100,
          width: double.infinity,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColor.yellowColor,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.yellowColor.withAlpha(30),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                  offset: Offset(
                    5.0,
                    3.0,
                  ),
                ),
              ]),
          child: Text(
            text.toUpperCase(),
            style: CustomTextStyle.titleStyle,
          ),
        ),
      );
}
