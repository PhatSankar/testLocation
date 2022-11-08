
import 'address.dart';

class LocationInfo {
  LocationInfo({
    required this.placeId,
    required this.osmType,
    required this.id,
    required this.lat,
    required this.lon,
    required this.placeRank,
    required this.importance,
    required this.displayName,
    required this.address,
  });

  int placeId;
  String osmType;
  int id;
  String lat;
  String lon;
  int placeRank;
  double importance;
  String displayName;
  AddressLocation address;

  @override
  String toString() {
    return
      '''
      placeID: ${this.placeId}
      osmType: ${this.osmType}
      id: ${this.id}
      lat: ${this.lat}
      lon: ${this.lon}
      placeRank: ${this.placeRank}
      importance: ${this.importance}
      displayName: ${this.displayName}
      address: ${this.address.road} ${this.address.suburb} ${this.address.cityDistrict} ${this.address.city}
      ''';
  }

}

