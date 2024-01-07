import '../../../flutter_google_maps.dart';

class GoogleMapWidget extends GetWidget<LocationController> {
  const GoogleMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      initState: (_) async {
        final hasAccess = await controller.getPermissionAndCurrentLocation();
        if (hasAccess) await controller.updateToCurrentLocation();
      },
      builder: (_) {
        return GoogleMap(
          trafficEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          markers: controller.markers.toSet(),
          onMapCreated: controller.setGoogleMapController,
          initialCameraPosition: controller.initialCameraPosition,
          onTap: (latLng) async {
            //* Change Marker Position
            await controller.changeMarker(latLng);
          },
        );
      },
    );
  }
}
