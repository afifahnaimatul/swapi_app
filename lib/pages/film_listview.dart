import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/services/film_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class FilmListView extends StatefulWidget {
  var url = "";

  FilmListView({@required this.url, Key key}) : super(key: key);

  @override
  _FilmListViewState createState() => _FilmListViewState();
}

class _FilmListViewState extends State<FilmListView> {
  var detailedData = {};
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialFunction();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

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
                ],
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
          width: 300,
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
