import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forsanway/models/featuresModel.dart';
import 'package:forsanway/models/searchModel.dart';
import 'package:forsanway/models/travelBookingModel.dart';
import 'package:forsanway/services/apiUrls.dart';
import 'package:forsanway/views/homePage/homeNavigation.dart';
import 'package:forsanway/widgets/changeScreen.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

Client client = Client();
ApiUrls apiUrls = new ApiUrls();

class TravelService {
  static const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  Future<List<TravelSearchResult>> getTravelSearch(
      String date, String type, int origin, int destination, String capacity, int mainFeatureId, String features) async {
    String url = apiUrls.getTravelSearch(date, type, origin, destination, capacity, mainFeatureId, features);
    print(url);
    final response = await client.get(Uri.parse(url));
    final Map result = json.decode(response.body);
    List<TravelSearchResult> travelSearch = [];
    if (response.statusCode == 200) {
      travelSearch.clear();
      for (Map json_ in result['data']) {
        travelSearch.add(TravelSearchResult.fromJson(json_));
      }
      // print(result['data'][0]['id']);
      return travelSearch;
    } else {
      print(response.statusCode.toString() + ' Error encountered');
      return null;
    }
  }

  Future<List<CarFeaturesModel>> carFeatures() async {
    String url = ApiUrls.carFeatures;
    final response = await client.get(Uri.parse(url));
    final Map result = json.decode(response.body);

    List<CarFeaturesModel> carFeatures = [];

    if (response.statusCode == 201) {
      for (Map json_ in result['car_features']) {
        carFeatures.add(CarFeaturesModel.fromJson(json_));
      }
      return carFeatures;
    } else {
      print('error');
      return null;
    }
  }

  Future<Map> createTravelBooking(int travelId, int passengerCount, List<String> names, List<String> titles, List<String> identityType, List<String> idNumber,
      List<String> mobileNumbers, List<String> passengerEmails, BuildContext context) async {
    Map result = {};
    List jsonList = names.map((e) => e.toString()).toList();
    final response = await client.post(Uri.parse(ApiUrls.tripBooking),
        headers: {'Content-type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode(
          {
            TravelBooking.TRIPID: travelId.toString(),
            TravelBooking.PASSENGERCOUNT: passengerCount.toString(),
            TravelBooking.PASSENGERNAMES: names,
            TravelBooking.PASSENGERTITLES: titles,
            TravelBooking.PASSENGERIDENTITIES: identityType,
            TravelBooking.IDENTITYNUMBERS: idNumber,
            TravelBooking.PASSENGERMOBILE: mobileNumbers,
            TravelBooking.PASSENGEREMAIL: passengerEmails
          },
        ));

    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: 'Booking created Successfully');
      changeScreen(context, HomeNavigation(currentIndex: 4));
      result = jsonDecode(response.body);
      print(encoder.convert(result));
    } else if (response.statusCode == 422) {
      Fluttertoast.showToast(msg: 'Booking failed, incomplete data');
      result = json.decode(response.body);
      print(encoder.convert(result));
    }

    return result;
  }
}
