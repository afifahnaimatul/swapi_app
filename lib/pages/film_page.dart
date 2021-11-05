import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/pages/film_detailed_page.dart';
import 'package:swapi_app/services/film_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class FilmPage extends StatefulWidget {
  const FilmPage({Key key}) : super(key: key);

  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
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
                    child: movieBuilder(),
                  )
                  // contentTemplate(),
                ],
              ),
            ),
    );
  }

  initialFunction() async {
    isLoading = true;
    var allFilmList = await FilmServices.getAllFilm();

    setState(() {
      allData = allFilmList;
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
            hintText: 'type a title',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      );

  movieBuilder() => ListView.separated(
        itemCount: allData.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => contentTemplate(
          allData[index]['title'],
          allData[index]['director'],
          allData[index]['release_date'],
          allData[index]['url'],
        ),
      );

  contentTemplate(title, director, releaseDate, url) => InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FilmDetailedPage(url: url))),
        child: Container(
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
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
                    title,
                    style: CustomTextStyle.subTitleStyle,
                  ),
                  SizedBox(height: 4),
                  contentBuilder('Director: ', director),
                  SizedBox(height: 4),
                  contentBuilder('Release Date: ', releaseDate),
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
