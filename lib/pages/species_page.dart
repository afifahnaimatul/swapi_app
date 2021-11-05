import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/pages/species_detailed_page.dart';
import 'package:swapi_app/services/species_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class SpeciesPage extends StatefulWidget {
  const SpeciesPage({Key key}) : super(key: key);

  @override
  _SpeciesPageState createState() => _SpeciesPageState();
}

class _SpeciesPageState extends State<SpeciesPage> {
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
                    child: speciesBuilder(),
                  )
                  // contentTemplate(),
                ],
              ),
            ),
    );
  }

  initialFunction() async {
    isLoading = true;
    var response = await SpeciesServices.getAllSpecies();

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

  speciesBuilder() => ListView.separated(
        itemCount: allData.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => contentTemplate(
            allData[index]['name'],
            allData[index]['classification'],
            allData[index]['language'],
            allData[index]['url']),
      );

  contentTemplate(name, classification, language, url) => InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SpeciesDetailedPage(url: url))),
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
                  contentBuilder('Classification: ', classification),
                  SizedBox(height: 4),
                  contentBuilder('Language: ', language),
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
