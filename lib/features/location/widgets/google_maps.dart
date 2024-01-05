import 'package:flutter_google_maps/flutter_google_maps.dart';

class GoogleMaps extends GetWidget<LocationController> {
  const GoogleMaps({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(controller.latitude, controller.longitude),
      ),
    );
  }
}
