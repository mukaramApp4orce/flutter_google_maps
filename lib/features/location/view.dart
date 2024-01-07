import '../../flutter_google_maps.dart';

class LocationView extends GetView<LocationController> {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location View"),
        centerTitle: true,
      ),
      body: GetBuilder<LocationController>(
        initState: (_) {
          controller.searchResultCtrl = TextEditingController();
        },
        builder: (_) {
          return SafeArea(
            child: Stack(
              children: [
                const GoogleMapWidget(),
                Column(
                  children: [
                    _searchInputFieldView,
                    _autoFillView,
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget get _searchInputFieldView => AppTextField.withPrefixIcon(
        text: "Search",
        controller: controller.searchResultCtrl,
        onChange: (val) => controller.placeAutoComplete(val),
      );

  Widget get _autoFillView => Container(
        color: AppColors.white,
        child: Column(
          children: [
            ...List.generate(
              controller.searchPlacesList.length,
              (index) => InkWell(
                onTap: () {
                  controller.searchThroughPlaceId(
                    placeId: controller.searchPlacesList[index].placeId,
                  );
                },
                child: Column(
                  children: [
                    //*
                    Container(
                      height: 50,
                      width: 350,
                      margin: const EdgeInsets.only(
                        right: 10,
                        left: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        controller.searchPlacesList[index].placeAddress,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          height: 1,
                          color: AppColors.autoFillTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    //*
                    Visibility(
                      // remove at last
                      visible:
                          (controller.searchPlacesList.length - 1) != index,
                      child: const Divider(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
