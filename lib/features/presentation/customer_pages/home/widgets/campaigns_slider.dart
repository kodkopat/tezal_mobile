// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/services/location.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/map_box.dart';
import '../../../../data/models/customer/campaign_result_model.dart';
import '../../../customer_providers/addresses_notifier.dart';
import 'campaign_slider_item.dart';

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

    mapBox = MapBox(
      height: boxHeight,
      latitude: "${position.latitude}",
      longitude: "${position.longitude}",
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
    var consumer = Consumer<AddressesNotifier>(
      builder: (context, provider, child) {
        if (provider.addressList == null) {
          provider.fetchAddresses();
        }

        return provider.listLoading
            ? AppLoading()
            : provider.addressList == null
                ? provider.listErrorMsg == null
                    ? SizedBox()
                    : SizedBox()
                : provider.defaultAddress == null
                    ? mapBox
                    : MapBox(
                        height: boxHeight,
                        latitude: "${provider.defaultAddress!.latitude}",
                        longitude: "${provider.defaultAddress!.longitude}",
                      );
      },
    );

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
                    ? consumer
                    : CampaignSliderItem(
                        campaign: widget.campaigns[index],
                        height: boxHeight,
                      );
              },
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
