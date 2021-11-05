import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/pages/film_detailed_page.dart';
import 'package:swapi_app/pages/film_listview.dart';
import 'package:swapi_app/pages/people_listview.dart';
import 'package:swapi_app/pages/planet_listview.dart';
import 'package:swapi_app/pages/species_listview.dart';
import 'package:swapi_app/pages/starship_listview.dart';
import 'package:swapi_app/pages/vehicle_listview.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class ListViewTemplates extends StatefulWidget {
  var url = [];
  String page = "";

  ListViewTemplates({@required this.url, @required this.page, Key key})
      : super(key: key);

  @override
  _ListViewTemplatesState createState() => _ListViewTemplatesState();
}

class _ListViewTemplatesState extends State<ListViewTemplates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var goTo;

          if (widget.page == 'film') {
            goTo = FilmListView(
              url: widget.url[index],
            );
          } else if (widget.page == 'people') {
            goTo = PeopleListView(
              url: widget.url[index],
            );
          } else if (widget.page == 'planet') {
            goTo = PlanetListView(
              url: widget.url[index],
            );
          } else if (widget.page == 'species') {
            goTo = SpeciesListView(
              url: widget.url[index],
            );
          } else if (widget.page == 'starship') {
            goTo = StarshipListView(
              url: widget.url[index],
            );
          } else {
            goTo = VehicleListView(
              url: widget.url[index],
            );
          }

          return SizedBox(
              width: MediaQuery.of(context).size.width, child: goTo);
        },
        itemCount: widget.url.length,
      ),
    );
  }
}
