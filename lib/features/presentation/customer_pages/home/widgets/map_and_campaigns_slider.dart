// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/services/location.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/map_box.dart';
import '../../../customer_providers/addresses_notifier.dart';
import '../../../customer_providers/campaign_notifier.dart';
import 'map_and_campaign_slider_item.dart';

class MapAndCampaignSlider extends StatefulWidget {
  @override
  _MapAndCampaignSliderState createState() => _MapAndCampaignSliderState();
}

class _MapAndCampaignSliderState extends State<MapAndCampaignSlider> {
  final double boxHeight = 200;

  int selectedImage = 0;

  List<Widget> pageViewWidgets = <Widget>[];

  bool loading = true;

  void initialization() async {
    var defaultAddress = Get.find<AddressesNotifier>().defaultAddress;

    if (defaultAddress == null) {
      var position = await LocationService.getSavedLocation();

      pageViewWidgets.add(MapBox(
        height: boxHeight,
        latitude: double.parse("${position.latitude}"),
        longitude: double.parse("${position.longitude}"),
      ));
    } else {
      pageViewWidgets.add(MapBox(
        height: boxHeight,
        latitude: double.parse("${defaultAddress.latitude}"),
        longitude: double.parse("${defaultAddress.longitude}"),
      ));
    }

    var campaignNotifier = Get.find<CampaignNotifier>();
    await campaignNotifier.fetchCampaigns();
    if (campaignNotifier.campaigns != null) {
      for (var campaign in campaignNotifier.campaigns!) {
        pageViewWidgets.add(MapAndCampaignSliderItem(
          campaign: campaign,
          height: boxHeight,
          onTap: () {},
        ));
      }
    }

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Parent(
          style: ParentStyle()
            ..background.color(Colors.white)
            ..boxShadow(
              color: Colors.black12,
              offset: Offset(0, 3.0),
              blur: 6,
              spread: 0,
            ),
          child: SizedBox(
            height: boxHeight,
            child: loading
                ? Center(child: AppLoading())
                : PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: pageViewWidgets.length,
                    onPageChanged: (value) {
                      setState(() => selectedImage = value);
                    },
                    itemBuilder: (context, index) => pageViewWidgets[index],
                  ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 8,
          child: Container(
            height: 16,
            alignment: Alignment.center,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: pageViewWidgets.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Txt(
                  "\u2B24",
                  style: AppTxtStyles().footNote
                    ..clone()
                    ..padding(horizontal: 2)
                    ..textColor(
                      selectedImage == index ? Colors.yellow : Colors.grey,
                    ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
