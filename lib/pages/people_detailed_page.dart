import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/pages/film_detailed_page.dart';
import 'package:swapi_app/pages/film_listview.dart';
import 'package:swapi_app/services/people_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';
import 'package:swapi_app/templates/go_to_other_list_button.dart';
import 'package:swapi_app/templates/listview_templates.dart';

class PeopleDetailedPage extends StatefulWidget {
  String url = "";
  PeopleDetailedPage({@required this.url, Key key}) : super(key: key);

  @override
  _PeopleDetailedPageState createState() => _PeopleDetailedPageState();
}

class _PeopleDetailedPageState extends State<PeopleDetailedPage> {
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
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: (isLoading)
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
                    goToOtherList(
                      context,
                      'See Movies Casted',
                      'film',
                      detailedData['films'],
                    ),
                    goToOtherList(context, 'See Species', 'species',
                        detailedData['species']),
                    goToOtherList(context, 'See Vehicles', 'vehicle',
                        detailedData['vehicles']),
                    goToOtherList(context, 'See Starships', 'starship',
                        detailedData['starships']),
                  ],
                ),
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
        margin: EdgeInsets.only(bottom: 4),
        child: RichText(
          text: TextSpan(
            text: label,
            style: CustomTextStyle.labelContentStyle,
            children: [
              TextSpan(text: content, style: CustomTextStyle.contentStyle),
            ],
          ),
        ),
      );
}
