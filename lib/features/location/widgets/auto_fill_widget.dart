import 'package:flutter_google_maps/flutter_google_maps.dart';

class AutoFillWidget extends GetWidget<LocationController> {
  const AutoFillWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (_) {
        return Column(
          children: [
            _searchInputFieldView,
            _autoFillView,
          ],
        );
      },
    );
  }

  Widget get _searchInputFieldView => AppTextField.simple(
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
