import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swapi_app/services/starships_services.dart';
import 'package:swapi_app/templates/app_color.dart';
import 'package:swapi_app/templates/app_size.dart';
import 'package:swapi_app/templates/custom_spin_kit.dart';
import 'package:swapi_app/templates/custom_text_style.dart';
import 'package:swapi_app/templates/go_to_other_list_button.dart';

class StarshipDetailedPage extends StatefulWidget {
  String url = "";
  StarshipDetailedPage({@required this.url, Key key}) : super(key: key);

  @override
  _StarshipDetailedPageState createState() => _StarshipDetailedPageState();
}

class _StarshipDetailedPageState extends State<StarshipDetailedPage> {
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
                    contentBuilder('MGLT: ', detailedData['MGLT']),
                    contentBuilder(
                        'Cargo Capacity: ', detailedData['cargo_capacity']),
                    contentBuilder(
                        'Consumables: ', detailedData['consumables']),
                    contentBuilder(
                        'Cost in credits: ', detailedData['cost_in_credits']),
                    contentBuilder('Crew: ', detailedData['crew']),
                    contentBuilder('Hyperdrive Rating: ',
                        detailedData['hyperdrive_rating']),
                    contentBuilder(
                        'Manufacturer: ', detailedData['manufacturer']),
                    contentBuilder('Max Atmosphering Speed: ',
                        detailedData['max_atmosphering_speed']),
                    contentBuilder('Model: ', detailedData['model']),
                    contentBuilder('Passengers: ', detailedData['passengers']),
                    contentBuilder(
                        'Starship Class: ', detailedData['starship_class']),
                    SizedBox(height: 20),
                    goToOtherList(context, 'See Pilots', 'people',
                        detailedData['pilots']),
                    goToOtherList(
                        context, 'See Films', 'film', detailedData['films']),
                  ],
                ),
              ),
            ),
    );
  }

  initialFunction() async {
    isLoading = true;
    var response = await StarshipServices.getDetailedStarship(widget.url);

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
              TextSpan(text: content, style: CustomTextStyle.contentStyle)
            ],
          ),
        ),
      );
}
