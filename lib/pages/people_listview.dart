import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/pages/film_detailed_page.dart';
import 'package:swapi_app/pages/film_listview.dart';
import 'package:swapi_app/services/people_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';
import 'package:swapi_app/templates/listview_templates.dart';

class PeopleListView extends StatefulWidget {
  String url = "";
  PeopleListView({@required this.url, Key key}) : super(key: key);

  @override
  _PeopleListViewState createState() => _PeopleListViewState();
}

class _PeopleListViewState extends State<PeopleListView> {
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
        : SingleChildScrollView(
            child: Container(
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
                  contentBuilder('Gender: ', detailedData['gender']),
                  contentBuilder('Height: ', detailedData['height']),
                  contentBuilder('Weight: ', detailedData['mass']),
                  contentBuilder('Eye Color: ', detailedData['eye_color']),
                  contentBuilder('Hair Color: ', detailedData['hair_color']),
                  contentBuilder('Skin Color: ', detailedData['skin_color']),
                  contentBuilder('Birth Year: ', detailedData['birth_year']),
                  contentBuilder('Homeworld: ', detailedData['homeworld']),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
  }

  initialFunction() async {
    isLoading = true;
    var response = await PeopleServices.getDetailedPeople(widget.url);

    setState(() {
      detailedData = response;
      isLoading = false;
    });
  }

  imageBuilder() => Container(
        height: 300,
        width: double.infinity,
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
