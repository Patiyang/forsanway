import 'package:forsanway/services/apiUrls.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

Client client = Client();

class CityServices {
  Future<Map> getCityList() async {
    List cities = [];
    
    String url = ApiUrls.getCities;
    final response = await client.get(Uri.parse(url));
    final Map result = json.decode(response.body);
    if (response.statusCode == 200) {
      cities.clear();
      for (int i = 0; i < result['cities'].length; i++) {
        cities.add(result['cities'][i]['images'][0]['url']);
      }
      // print(result['cities'][0]['images'][0]['url']);
    }
    return result;
  }
}
