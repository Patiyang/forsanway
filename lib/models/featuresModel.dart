class MainFeatures {
  final int id;
  final String name;
  final Map images;

  MainFeatures({this.id, this.name, this.images});

  factory MainFeatures.fromJson(Map<String, dynamic> json) => new MainFeatures(
        id: json['id'],
        name: json['name'],
        images: json['image'],
      );
}


class CarFeaturesModel {
  final int id;
  final String name;
  final Map images;

  CarFeaturesModel({this.id, this.name, this.images});

  factory CarFeaturesModel.fromJson(Map<String, dynamic> json) => new CarFeaturesModel(
        id: json['id'],
        name: json['name'],
        images: json['image'],
      );
}