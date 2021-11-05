import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/services/species_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_text_style.dart';

class SpeciesListView extends StatefulWidget {
  String url = "";
  SpeciesListView({@required this.url, Key key}) : super(key: key);

  @override
  _SpecieListViewState createState() => _SpecieListViewState();
}

class _SpecieListViewState extends State<SpeciesListView> {
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
    return Container(
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
          contentBuilder('Average Height: ', detailedData['average_height']),
          contentBuilder(
              'Average Lifespan: ', detailedData['average_lifespan']),
          contentBuilder('Classification: ', detailedData['classification']),
          contentBuilder('Designation: ', detailedData['designation']),
          contentBuilder('Eye Colors: ', detailedData['eye_colors']),
          contentBuilder('Hair Colors: ', detailedData['hair_colors']),
          contentBuilder('Homeworld: ', detailedData['homeworld']),
          contentBuilder('Language: ', detailedData['language']),
          contentBuilder('Skin Colors: ', detailedData['skin_colors']),
        ],
      ),
    );
  }

  initialFunction() async {
    isLoading = true;
    var response = await SpeciesServices.getDetailedSpecies(widget.url);

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
