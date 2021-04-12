import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../data/models/nearby_markets_result_model.dart';
import '../../../data/models/photos_result_model.dart';
import '../../../data/repositories/customer_market_repository.dart';
import '../custom_rich_text.dart';

class MarketsListItem extends StatelessWidget {
  const MarketsListItem({
    required this.market,
    required this.onTap,
    required this.repository,
  });

  final Market market;
  final void Function() onTap;
  final CustomerMarketRepository repository;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, top: 8, bottom: 16)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        )
        ..ripple(true),
      child: Stack(
        children: [
          Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Parent(
                    style: ParentStyle()
                      ..width(96)
                      ..height(96)
                      ..borderRadius(all: 8)
                      ..background.image(
                        alignment: Alignment.center,
                        path: "assets/images/placeholder.jpg",
                        fit: BoxFit.fill,
                      ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: _futureImgFile,
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Txt(
                        "${market.name}",
                        style: AppTxtStyles().heading..bold(),
                      ),
                      SizedBox(height: 4),
                      if (market.openAt != null) _fieldWorkingTime,
                      _fieldPhone,
                      _fieldAddress,
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.black12,
                thickness: 0.5,
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _fieldMarketScore,
                  _verticalDivider,
                  _fieldDeliveryCost,
                  _verticalDivider,
                  _fieldDistance,
                ],
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Txt(
              "${market.situation}",
              style: TxtStyle()
                ..width(48)
                ..alignmentContent.center()
                ..padding(vertical: 2)
                ..borderRadius(all: 4)
                ..background.color(Color(0xffEFEFEF))
                ..textColor(Colors.black)
                ..fontSize(12)
                ..bold(),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _futureImgFile {
    return CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
      future: repository.photo(marketId: market.id),
      successBuilder: (context, data) {
        return data!.fold(
          (l) => SizedBox(),
          (r) => Image.memory(
            base64Decode(r.data.photos.first),
          ),
        );
      },
      errorBuilder: (context, data) => SizedBox(),
    );
  }

  Widget get _verticalDivider => SizedBox(
        height: 40,
        child: VerticalDivider(
          color: Colors.black12,
          thickness: 0.5,
          width: 0,
        ),
      );

  Widget get _fieldWorkingTime => CustomRichText(
        title: "ساعت کار" + ": ",
        text: _generateWorkingTimeText(),
      );

  String _generateWorkingTimeText() {
    return "${market.clouseAt} - ${market.openAt}";
  }

  Widget get _fieldPhone => CustomRichText(
        title: "شماره تماس" + ": ",
        text: _generatePhoneText(),
      );

  String _generatePhoneText() {
    return (market.phone == null) ? " ناموجود " : " ${market.phone} ";
  }

  Widget get _fieldAddress => CustomRichText(
        title: "آدرس" + ": ",
        text: " ${market.address} ",
      );

  Widget get _fieldMarketScore => CustomRichText(
        title: "امتیاز فروشگاه" + "\n",
        text: _generateMarketScoreText(),
        textAlign: TextAlign.center,
      );

  String _generateMarketScoreText() {
    return (market.score == null) ? " ذکر نشده " : " ${market.score} ";
  }

  Widget get _fieldDeliveryCost => CustomRichText(
        title: "هزینه ارسال" + "\n",
        text: _generateDeliveryCostText(),
        textAlign: TextAlign.center,
      );

  String _generateDeliveryCostText() {
    var constText;
    if (market.deliveryCost == null) {
      constText = " ذکر نشده ";
    } else if (market.deliveryCost == 0) {
      constText = " رایگان ";
    } else {
      var temp;
      if ("${market.deliveryCost}".length >= 3) {
        temp = intl.NumberFormat("#,000").format(market.deliveryCost);
      } else {
        temp = "${market.deliveryCost}";
      }

      constText = " $temp " + "تومان";
    }

    return constText;
  }

  Widget get _fieldDistance => CustomRichText(
        title: "فاصله تا شما" + "\n",
        text: _generateDistanceText(),
        textAlign: TextAlign.center,
      );

  String _generateDistanceText() {
    var distanceText;
    if (market.distance == null) {
      distanceText = "ذکر نشده";
    } else {
      distanceText = (market.distance).toStringAsFixed(0);
    }

    return " $distanceText " + "کیلومتر";
  }
}
