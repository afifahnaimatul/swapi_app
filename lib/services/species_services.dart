import 'dart:convert' as convert;
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:swapi_app/services/services.dart';

class SpeciesServices {
  static Future getAllSpecies() async {
    var url = Services.baseUrl + 'species/';
    log("url: " + url.toString());

    var response = await http.get(url);
    log('response: ' + response.toString());

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      log('jsonResponse: ' + jsonResponse.toString());
      log('jsonResponse[results]: ' + jsonResponse['results'].toString());

      return jsonResponse['results'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  static Future getDetailedSpecies(url) async {
    var response = await http.get(url);
    log('response: ' + response.toString());

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      log('jsonResponse: ' + jsonResponse.toString());

      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
