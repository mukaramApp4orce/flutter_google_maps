import '../../flutter_google_maps.dart';

class LocationView extends GetView<LocationController> {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  PreferredSizeWidget get _appBar => AppBar(
        title: const Text("Location View"),
        centerTitle: true,
      );

  Widget get _body => GetBuilder<LocationController>(
        initState: (_) {
          controller.searchResultCtrl = TextEditingController();
        },
        builder: (_) {
          return const SafeArea(
            child: Stack(
              children: [
                GoogleMapWidget(),
                AutoFillWidget(),
              ],
            ),
          );
        },
      );
}
