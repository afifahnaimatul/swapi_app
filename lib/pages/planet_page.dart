import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/pages/planet_detailed_page.dart';
import 'package:swapi_app/services/planet_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class PlanetPage extends StatefulWidget {
  const PlanetPage({Key key}) : super(key: key);

  @override
  _PlanetPageState createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
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
                    child: planetBuilder(),
                  )
                  // contentTemplate(),
                ],
              ),
            ),
    );
  }

  initialFunction() async {
    isLoading = true;
    var response = await PlanetServices.getAllPlanet();

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
            hintText: 'type a name',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      );

  planetBuilder() => ListView.separated(
        itemCount: allData.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => contentTemplate(
            allData[index]['name'],
            allData[index]['climate'],
            allData[index]['population'],
            allData[index]['url']),
      );

  contentTemplate(name, climate, population, url) => InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlanetDetailedPage(url: url))),
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
                    name,
                    style: CustomTextStyle.subTitleStyle,
                  ),
                  SizedBox(height: 4),
                  contentBuilder('Climate: ', climate),
                  SizedBox(height: 4),
                  contentBuilder('Population: ', population),
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
