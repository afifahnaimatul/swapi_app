import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/services/film_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';
import 'package:swapi_app/templates/go_to_other_list_button.dart';
import 'package:swapi_app/templates/listview_templates.dart';

class FilmDetailedPage extends StatefulWidget {
  var url = "";
  bool isList = false;

  FilmDetailedPage({@required this.url, this.isList, Key key})
      : super(key: key);

  @override
  _FilmDetailedPageState createState() => _FilmDetailedPageState();
}

class _FilmDetailedPageState extends State<FilmDetailedPage> {
  var detailedData = {};
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFunction();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                    imageBuilder(),
                    SizedBox(height: 20),
                    Text(
                      detailedData['title'],
                      style: CustomTextStyle.titleStyle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    contentBuilder('Director: ', detailedData['director']),
                    contentBuilder('Producer: ', detailedData['producer']),
                    contentBuilder(
                        'Release Date: ', detailedData['release_date']),
                    contentBuilder(
                        'Episode: ', detailedData['episode_id'].toString()),
                    Text('Opening Crawl',
                        style: CustomTextStyle.labelContentStyle),
                    Text(
                      detailedData['opening_crawl'],
                      style: CustomTextStyle.contentStyle,
                    ),
                    SizedBox(height: 20),
                    goToOtherList(context, 'See Movie Cast', 'people',
                        detailedData['characters']),
                    goToOtherList(context, 'See Planets', 'planet',
                        detailedData['planets']),
                    goToOtherList(context, 'See Starships', 'starship',
                        detailedData['starships']),
                    goToOtherList(context, 'See Vehicles', 'vehicle',
                        detailedData['vehicles']),
                    goToOtherList(context, 'See Species', 'species',
                        detailedData['species']),
                  ],
                ),
              ),
            ),
    );
  }

  initialFunction() async {
    isLoading = true;
    var response = await FilmServices.getDetailedFilm(widget.url);

    setState(() {
      detailedData = response;
      isLoading = false;
    });
  }

  imageBuilder() => Center(
        child: Container(
          height: 300,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/star-wars-background.jpg'),
              fit: BoxFit.cover,
            ),
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
              TextSpan(text: content, style: CustomTextStyle.contentStyle)
            ],
          ),
        ),
      );
}
