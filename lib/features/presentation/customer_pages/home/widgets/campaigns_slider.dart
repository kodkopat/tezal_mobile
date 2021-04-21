// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/services/location.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/map_box.dart';
import '../../../../data/models/campaign_result_model.dart';
import 'campaign_slider_item.dart';
import 'pick_location_combo_box.dart';

class CampaignSlider extends StatefulWidget {
  const CampaignSlider({required this.campaigns});

  final List<Campaign> campaigns;

  @override
  _CampaignSliderState createState() => _CampaignSliderState();
}

class _CampaignSliderState extends State<CampaignSlider> {
  int selectedImage = 0;
  double boxHeight = 200;
  late Widget mapBox;
  bool loading = true;

  void initializeState() async {
    var position = await LocationService.getSavedLocation();

    mapBox = Stack(
      children: [
        MapBox(
          height: boxHeight,
          latitude: "${position.latitude}",
          longitude: "${position.longitude}",
        ),
        Align(
          alignment: Alignment.topCenter,
          child: PickLocationComboBox(),
        ),
      ],
    );

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Parent(
          style: ParentStyle()
            ..background.color(Colors.white)
            ..borderRadius(all: 8)
            ..boxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 4.0),
              blur: 8,
              spread: 0,
            ),
          child: SizedBox(
            height: boxHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: loading ? 0 : widget.campaigns.length + 1,
                onPageChanged: (value) {
                  setState(() {
                    selectedImage = value;
                  });
                },
                itemBuilder: (context, index) {
                  return index == widget.campaigns.length
                      ? mapBox
                      : CampaignSliderItem(
                          campaign: widget.campaigns[index],
                          height: boxHeight,
                        );
                },
              ),
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
              itemCount: widget.campaigns.length + 1,
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
