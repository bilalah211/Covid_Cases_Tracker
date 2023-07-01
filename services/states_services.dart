import 'dart:convert';

import 'package:covid_tracker_app/model/CovidModel.dart';
import 'package:covid_tracker_app/services/utilities/api_url.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  Future<CovidModel> covidList() async {
    var response =
        await http.get(Uri.parse(AppUrl.worldStatesApi));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {

      return CovidModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }
  Future<List<dynamic>> countriesList() async {
    var data;
    var response =
    await http.get(Uri.parse(AppUrl.countriesList));
    data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Error');
    }
  }
}

