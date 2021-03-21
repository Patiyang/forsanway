

import 'package:forsanway/models/featuresModel.dart';

import 'apiUrls.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

Client client = new Client();

class CarFeaturesService {
  Future<List<CarFeaturesModel>> carFeatures() async {
    String url = ApiUrls.carFeatures;
    final response = await client.get(Uri.parse(url));
    final Map result = json.decode(response.body);

    List<CarFeaturesModel> carFeatures = [];

    if (response.statusCode == 201) {
      for (Map json_ in result['car_features']) {
        carFeatures.add(CarFeaturesModel.fromJson(json_));
      }
      print(result['car_features'].toString());
      return carFeatures;
    } else {
      print('error');
      return null;
    }
  }
  
}
