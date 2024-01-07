import '../../flutter_google_maps.dart';

class LocationController extends GetxController {
  late TextEditingController searchResultCtrl;

  //**** Map Start ****//

  //* initial camera position at Saudi-Arab
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(
      23.8859,
      45.0792, // Saudi-Arab Latlng
    ),
    zoom: 1,
  );

  late GoogleMapController googleMapController;
  void setGoogleMapController(GoogleMapController controller) {
    googleMapController = controller;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(initialCameraPosition),
    );
    update();
  }

  late LocationPermission _permission;
  late Position _currentPosition;
  Future<bool> getPermissionAndCurrentLocation() async {
    _permission = await Geolocator.checkPermission();

    if (_permission == LocationPermission.deniedForever) {
      return false;
    }

    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
    }

    if (_permission == LocationPermission.always ||
        _permission == LocationPermission.whileInUse) {
      _currentPosition = await Geolocator.getCurrentPosition();
      return true;
    }

    return false;
  }

  late LatLng currentLatLng;
  Future<void> updateToCurrentLocation() async {
    //*
    currentLatLng = LatLng(
      _currentPosition.latitude,
      _currentPosition.longitude,
    );

    //*
    await changeMarker(currentLatLng);

    //*
    await animateCamera(currentLatLng);
  }

  Future<void> animateCamera(LatLng latlng) async {
    await googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            latlng.latitude,
            latlng.longitude,
          ),
          zoom: 15,
        ),
      ),
    );
    update();
  }

  List<Marker> markers = [];
  Future<void> changeMarker(LatLng latlng) async {
    markers.clear();
    await _getBytesFromAssets(
      "assets/images/location_pin.png",
      80.toInt(),
    ).then((markIcon) async {
      markers.add(
        Marker(
          markerId: MarkerId("${latlng.latitude}"),
          icon: BitmapDescriptor.fromBytes(markIcon),
          position: latlng,
        ),
      );
    });

    update();
  }

  Future<Uint8List> _getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  //**** Search Places ****//

  List<AutoCompleteModel> searchPlacesList = [];
  Future<void> placeAutoComplete(String query) async {
    try {
      searchPlacesList =
          await GoogleMapApi.getAutoCompleteLocations(input: query);
    } catch (e) {
      debugPrint("Auto Complete Error: $e");
    }
    if (query.isEmpty || query.length <= 2) {
      searchPlacesList = [];
    }
    update();
  }

  late LatLng selectedLatLng;
  Future<void> searchThroughPlaceId({required String placeId}) async {
    try {
      //*
      selectedLatLng = await GoogleMapApi.getLatLngFromAutocompleteSelection(
        placeId: placeId,
      );

      //*
      await changeMarker(selectedLatLng);
      await animateCamera(selectedLatLng);
      FocusManager.instance.primaryFocus?.unfocus();
      searchPlacesList.clear();
    } catch (e) {
      debugPrint("Response Error $e");
    }
  }

  int searchPlacesIndex = 0;
  Future<void> getAddressLine(LatLng latlng) async {
    try {
      var address = await Geocoder2.getDataFromCoordinates(
        latitude: latlng.latitude,
        longitude: latlng.longitude,
        googleMapApiKey: AppConstants.googleMapApiKey,
      );
      searchResultCtrl.text = address.address;
      update();
    } catch (e) {
      debugPrint("Get Address Error $e");
    }
  }

  //
  late AddressInfoModel addreesInfo;
  Future<void> getAddressInfo(LatLng latlng) async {
    try {
      //*
      var address = await Geocoder2.getDataFromCoordinates(
        latitude: latlng.latitude,
        longitude: latlng.longitude,
        googleMapApiKey: AppConstants.googleMapApiKey,
      );

      //*
      addreesInfo = AddressInfoModel(
        city: address.city,
        country: address.country,
        countryCode: address.countryCode,
        prov: address.state,
      );

      //
      update();
    } catch (e) {
      debugPrint("Get Address Error $e");
    }
  }

  //******** Search Places Ends ********/
  //**** Map End ****//
}
