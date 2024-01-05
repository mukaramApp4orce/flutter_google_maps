import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../flutter_google_maps.dart';

class MapsApi {
  static const String kApiKey = 'AIzaSyDnlzMppfKKkJ4Y_JsI6dpP7kfAH61rRig';

  //* Get search places
  static Future<List<String>> getSearchLocation({required String input}) async {
    List<String> searchPlaces = [];
    String baseUrl =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String requestUrl =
        '$baseUrl?input=$input&key=$kApiKey&sessiontoken=$_getsessionToken';

    try {
      final response = await http.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        searchPlaces = json['predictions'];
      } else {
        throw Exception("Error. Try again later!");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return searchPlaces;
  }

  //*
  static String _getsessionToken() {
    return const Uuid().v4();
  }
}
