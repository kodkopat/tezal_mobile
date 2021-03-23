import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../data/models/nearby_markets_result_model.dart';
import '../../../../data/models/photo_result_model.dart';
import '../../../../data/repositories/customer_market_repository.dart';

class NearByMarketsListItem extends StatelessWidget {
  const NearByMarketsListItem({
    Key key,
    @required this.market,
    @required this.onTap,
    @required this.repository,
  }) : super(key: key);

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
      child: Column(
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
                  _fieldPhone,
                  SizedBox(height: 4),
                  _fieldAddress,
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 0,
          ),
          SizedBox(height: 12),
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
    );
  }

  Widget get _futureImgFile {
    return CustomFutureBuilder<Either<Failure, PhotoResultModel>>(
      future: repository.photo(marketId: market.id),
      successBuilder: (context, data) {
        return data.fold(
          (l) => SizedBox(),
          (r) => Image.memory(
            base64Decode(r.data.photo),
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

  Widget get _fieldPhone {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var phoneText;
    if (market.phone == null) {
      phoneText = " ناموجود ";
    } else {
      phoneText = " ${market.phone} ";
    }

    return RichText(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        children: [
          TextSpan(
            text: " شماره تماس:",
            style: textStyle,
          ),
          TextSpan(
            text: phoneText,
            style: textStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _fieldAddress {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    return RichText(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        children: [
          TextSpan(
            text: " آدرس:",
            style: textStyle,
          ),
          TextSpan(
            text: " ${market.address} ",
            style: textStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _fieldMarketScore {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var marketScoreText;
    if (market.score == null) {
      marketScoreText = " ذکر نشده ";
    } else {
      marketScoreText = " ${market.score} ";
    }

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "امتیاز فروشگاه" + "\n",
            style: textStyle,
          ),
          TextSpan(
            text: marketScoreText,
            style: textStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _fieldDeliveryCost {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

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

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "هزینه ارسال" + "\n",
            style: textStyle,
          ),
          TextSpan(
            text: constText,
            style: textStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _fieldDistance {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var distanceText;
    if (market.distance == null) {
      distanceText = "ذکر نشده";
    } else {
      distanceText = (market.distance as num).toStringAsFixed(0);
    }

    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: "فاصله تا شما" + "\n",
            style: textStyle,
          ),
          TextSpan(
            text: " $distanceText " + "کیلومتر",
            style: textStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
