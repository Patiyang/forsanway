class ApiUrls {
  static const String url = 'https://forsanway.com/api/';
   static const String imageBaseUrl = 'https://www.forsanway.com/storage/';
  static const String registration = '$url' + 'user-register';
  static const String login = '$url' + 'login';
  static const String getCities = '$url' + 'cities';
  static const String mainFeatures = '$url' + 'front-main-features';
  static const String carFeatures = '$url' + 'front-features';
  static const String imageUrl = '$imageBaseUrl';

  String getTravelSearch(String date, String type, int origin, int destination, String capacity, int mainFeatureId, String features) {
    return 'https://forsanway.com/api/search-trip?date=${date}&type=$type&city_from_id=$origin&city_to_id=$destination&number_of_person=$capacity&main_feature_id=$mainFeatureId&feature_id=$features';
  }

  String getShipmentSearch(String date, String type, int origin, int destination, String quantity) {
    return 'https://forsanway.com/api/search-ship?date=$date&type=$type&city_from=$origin&city_to=$destination&number_of_bag=$quantity';
  }
}
