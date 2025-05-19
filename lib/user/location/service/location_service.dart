import 'dart:convert';

import 'package:travelx_driver/user/location/model/place_lat_lng.dart';

import '../../../shared/api_client/api_client.dart';
import '../model/location_model.dart';

class PlaceApiProvider {
  // static const String androidKey = "AIzaSyBtDSlrpYHSR41NjrwcYW5dp9_mia0ZFzo";
  // static const String iosKey = "AIzaSyBtDSlrpYHSR41NjrwcYW5dp9_mia0ZFzo";

  // ignore: prefer_typing_uninitialized_variables
  static var apiKey =
      "AIzaSyBtDSlrpYHSR41NjrwcYW5dp9_mia0ZFzo"; //Platform.isAndroid ? androidKey : iosKey;

  // static Future<void> initializeMapApi() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   apiKey = prefs.getString('google_maps_api_key');
  // }

  static Future<Suggestion?> fetchSuggestions(
    String input,
    String lang,
    String sessionToken,
  ) async {
    // await initializeMapApi();
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&sessiontoken=$sessionToken&components=country:in';
    final response = await ApiClient().get(request);
    if (response['status'] == 'OK') {
      if (response['status'] == 'OK') {
        final suggestion = Suggestion.fromJson(response);
        return suggestion;
      }
      if (response['status'] == 'ZERO_RESULTS') {
        return response['error_message'];
      }
      throw Exception(response['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  static Future<Suggestion?> fetchSuggestionsPickup(
    String input,
    String lang,
    String sessionToken,
  ) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&sessiontoken=$sessionToken&components=country:in';
    final response = await ApiClient().get(request);
    if (response['status'] == 'OK') {
      if (response['status'] == 'OK') {
        final suggestion = Suggestion.fromJson(response);
        return suggestion;
      }
      if (response['status'] == 'ZERO_RESULTS') {
        return response['error_message'];
      }
      throw Exception(response['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  static Future<PlaceDetails> getPlaceDetails(String placeId) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey';
    final response = await ApiClient().get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final result = jsonResponse['result'] as Map<String, dynamic>;

      final placeDetails = PlaceDetails.fromJson(result);

      return placeDetails;
    } else {
      throw Exception('Failed to fetch place details: ${response.statusCode}');
    }
  }

  static Future<PlaceWithLatLng?> fetchPlaceDetails({String? placeId}) async {
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey';

    final response = await await ApiClient().get(url);

    if (response["status"] == "OK") {
      final placeWithLatLng = PlaceWithLatLng.fromJson(response);

      if (placeWithLatLng.status == "OK") {
        return placeWithLatLng;
      } else {
        throw Exception(
          'Failed to fetch place details: ${placeWithLatLng.status}',
        );
      }
    } else {
      throw Exception('Failed to fetch place details: ${response.statusCode}');
    }
  }
}

class PlaceDetails {
  final String formattedAddress;
  final String name;

  PlaceDetails.fromJson(Map<String, dynamic> json)
    : formattedAddress = json['formatted_address'],
      name = json['name'];
}
