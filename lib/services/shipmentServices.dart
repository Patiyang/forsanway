import 'package:forsanway/models/searchModel.dart';
import 'dart:convert';
import 'package:http/http.dart' show Client;

import 'apiUrls.dart';

Client client = Client();
ApiUrls apiUrls = new ApiUrls();

class ShipmentService {
  Future<List<ShipmentSearchResult>> getShipmentSearch(String date, String type, int origin, int destination, String quantity) async {
    String url = apiUrls.getShipmentSearch(date, type, origin, destination, quantity);

    final response = await client.get(Uri.parse(url));
    final Map result = json.decode(response.body);

    List<ShipmentSearchResult> shipmentSearch = [];

    if (response.statusCode == 200) {
      shipmentSearch.clear();
      for (Map _json in result['data']) {
        shipmentSearch.add(ShipmentSearchResult.fromJson(_json));
      }

      // print(result['data']);
      return shipmentSearch;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
