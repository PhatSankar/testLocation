

import 'package:dio/dio.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import '../models/address.dart';
import '../models/locationInfo.dart';

Future<LocationInfo?>getInfo(GBLatLng currentPosition) async
{
  const String PATH = "https://nominatim.openstreetmap.org";
  try {
    var options = BaseOptions(
      baseUrl: '$PATH/reverse?lat=${currentPosition.lat}&lon=${currentPosition.lng}&format=jsonv2'
    );
    Dio dioOSM =Dio(options);
    var response = await dioOSM.get('');
    if (response.statusCode == 200)
    {
      return LocationInfo(
          placeId: response.data["place_id"],
          osmType: response.data["osm_type"]?? "",
          id: response.data["osm_id"]?? "",
          lat: response.data["lat"],
          lon: response.data["lon"],
          placeRank: response.data["place_rank"]?? "",
          importance: response.data["importance"]?? "",
          displayName: response.data["display_name"]?? "",
          address: AddressLocation(
              road: response.data["address"]["road"] ?? "",
              suburb: response.data["address"]["suburb"]?? "",
              cityDistrict: response.data["address"]["city_district"]?? "",
              city: response.data["address"]["city"]?? "",
              iso31662Lvl4: response.data["address"]['ISO3166-2-lvl4']?? "",
              postcode: response.data["address"]["postcode"]?? "",
              country: response.data["address"]["country"]?? "",
              countryCode: response.data["address"]["country_code"]?? "")
      );
    }
    else
    {
      return null;
    }
  }
  catch (exeption)
  {
    print(exeption.toString());
    rethrow;
  }
}