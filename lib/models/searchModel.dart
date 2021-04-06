class TravelSearchResult {



//travelSearch variables
  final int id;
  final int userId;
  final String owner;
  final String imageUrl;
  final List imageList;
  final String carName;
  final String description;
  final List car;
  final List carFeatures;
  final String pickUpLocation;


  TravelSearchResult(
      {this.id, this.userId, this.owner, this.car, this.imageUrl, this.imageList, this.carName, this.description, this.carFeatures, this.pickUpLocation});

  factory TravelSearchResult.fromJson(Map<String, dynamic> json) => new TravelSearchResult(
        id: json['id'],
        userId: json['user_id'],
        owner: json['owner'],
        car: json['car'],
        carName: json['car'][0]['name'],
        imageUrl: json['car'][0]['url'],
        description: json['description'],
        imageList: json['car'][0]['images'],
        carFeatures: json['car'][0]['car_features'],
        pickUpLocation: json['pickup_location'],
      );


   
}

class ShipmentSearchResult {
  final int id;
  final int userId;
  final String owner;
  final String imageUrl;
  final List imageList;
  final String carName;
  final String description;
  final List car;
  final List carFeatures;
  final String pickUpLocation;

  ShipmentSearchResult({
    this.id,
    this.userId,
    this.owner,
    this.imageUrl,
    this.imageList,
    this.carName,
    this.description,
    this.car,
    this.carFeatures,
    this.pickUpLocation,
  });

  factory ShipmentSearchResult.fromJson(Map<String, dynamic> json) => new ShipmentSearchResult(
        id: json['id'],
        userId: json['user_id'],
        owner: json['owner'],
        car: json['car'],
        carName: json['car'][0]['name'],
        imageUrl: json['car'][0]['url'],
        description: json['description'],
        imageList: json['car'][0]['images'],
        carFeatures: json['car'][0]['car_features'],
        pickUpLocation: json['pickup_location'],
      );
}
