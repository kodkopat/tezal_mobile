import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../core/styles/txt_styles.dart';
import '../../data/models/nearby_markets_result_model.dart';

class NearByMarketsListItem extends StatelessWidget {
  const NearByMarketsListItem({
    Key key,
    @required this.market,
    @required this.onTap,
  }) : super(key: key);

  final Market market;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
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
                  child: CachedNetworkImage(
                    imageUrl: "",
                    fit: BoxFit.fill,
                  ),
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
              _fieldMarketRate,
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

  Widget get _verticalDivider {
    return SizedBox(
      height: 40,
      child: VerticalDivider(
        color: Colors.black12,
        thickness: 0.5,
        width: 0,
      ),
    );
  }

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

  Widget get _fieldMarketRate {
    var textStyle = TextStyle(
      color: Colors.black,
      letterSpacing: 0.5,
      fontFamily: 'Yekan',
      fontWeight: FontWeight.w600,
      fontSize: 13,
    );

    var marketRateText;
    if (market.phone == null) {
      marketRateText = " ذکر نشده ";
    } else {
      marketRateText = " ${market.score} ";
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
            text: marketRateText,
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
      var temp = intl.NumberFormat("#,000").format(market.deliveryCost);
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
