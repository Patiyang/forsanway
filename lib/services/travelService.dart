import 'package:forsanway/models/featuresModel.dart';
import 'package:forsanway/models/searchModel.dart';
import 'package:forsanway/services/apiUrls.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

Client client = Client();
ApiUrls apiUrls = new ApiUrls();

class TravelService {
  Future<List<TravelSearchResult>> getTravelSearch(String date, String type, int origin, int destination, String capacity, int mainFeatureId, String features) async {
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
      // print(result['data']);
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
      // print(result.toString());
      return carFeatures;
    } else {
      print('error');
      return null;
    }
  }
}
