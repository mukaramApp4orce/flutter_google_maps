import '../../flutter_google_maps.dart';

class GoogleMapApi {
  /// Generate Unique ID
  static String get _getsessionToken => const Uuid().v4();

  /// Docs: https://developers.google.com/maps/documentation/places/web-service/autocomplete
  static Future<List<AutoCompleteModel>> getAutoCompleteLocations({
    required String input,
  }) async {
    List<AutoCompleteModel> searchPlaces = [];

    try {
      final response = await HttpMethods.get(
        uri: EndPoints.autoComplete,
        queryParams:
            "?input=$input&key=${AppConstants.googleMapApiKey}&sessiontoken=$_getsessionToken&components=country:sa",
      );

      Map<String, dynamic> result = jsonDecode(response.body.toString());

      for (var singlePrediction in result['predictions']) {
        final place = singlePrediction['description'];
        final placeId = singlePrediction['place_id'];

        searchPlaces
            .add(AutoCompleteModel(placeAddress: place, placeId: placeId));
      }

      return searchPlaces;
    } catch (_) {
      throw const GoogleMapError();
    }
  }

  /// Docs: https://developers.google.com/maps/documentation/places/web-service/details#PlaceDetailsRequests
  static Future<LatLng> getLatLngFromAutocompleteSelection({
    required String placeId,
  }) async {
    LatLng selectedLatLng;

    try {
      final response = await HttpMethods.get(
        uri: EndPoints.placeDetail,
        queryParams: "?place_id=$placeId&key=${AppConstants.googleMapApiKey}",
      );

      Map<String, dynamic> result = jsonDecode(response.body.toString());
      final lat = result['result']['geometry']['location']['lat'];
      final lng = result['result']['geometry']['location']['lng'];

      selectedLatLng = LatLng(lat, lng);

      return selectedLatLng;
    } catch (_) {
      throw const GoogleMapError();
    }
  }
}
