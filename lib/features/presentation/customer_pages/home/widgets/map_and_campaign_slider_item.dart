import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../data/models/customer/campaign_result_model.dart';
import '../../../../data/models/customer/photos_result_model.dart';
import '../../../customer_providers/campaign_notifier.dart';

// ignore: must_be_immutable
class MapAndCampaignSliderItem extends StatelessWidget {
  MapAndCampaignSliderItem({
    required this.campaign,
    required this.onTap,
    required this.height,
  });

  final Campaign campaign;
  final VoidCallback onTap;
  final double height;

  late CampaignNotifier? _campaignNotifier;

  @override
  Widget build(BuildContext context) {
    _campaignNotifier = Provider.of<CampaignNotifier>(
      context,
      listen: false,
    );

    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width)
        ..height(height)
        ..background.image(
          alignment: Alignment.center,
          path: "assets/images/img_placeholder.jpg",
          fit: BoxFit.fill,
        ),
      child: _futurePhoto,
    );
  }

  Widget get _futurePhoto =>
      CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
        future: _campaignNotifier!.customerCampaignRepo.getPhoto(
          campaignId: campaign.id,
        ),
        successBuilder: (context, data) {
          return data!.fold(
            (left) => SizedBox(),
            (right) => Image.memory(
              base64Decode(right.data!.photos.first),
              fit: BoxFit.fill,
            ),
          );
        },
        errorBuilder: (context, data) => SizedBox(),
      );
}
