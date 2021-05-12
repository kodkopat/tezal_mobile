// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../data/models/market/orders_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';
import 'order_list_item_field.dart';

class OrderListItem extends StatelessWidget {
  OrderListItem({
    required this.marketOrder,
    required this.onTap,
    required this.showIcons,
  });

  final MarketOrder marketOrder;
  final void Function() onTap;
  final bool showIcons;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width)
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fieldCustomerName,
              _fieldCustomerPhone,
              _fieldCustomerAddress,
              _divider,
              _fieldDeliveryTime,
              _fieldPaymentType,
              _divider,
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(flex: 1, child: _fieldTotalPrice),
                  _verticalDivider,
                  Expanded(flex: 1, child: _fieldTotalDiscount),
                  _verticalDivider,
                  Expanded(flex: 1, child: _fieldDeliveryCost),
                ],
              ),
            ],
          ),
          Align(
            alignment: Directionality.of(context) == TextDirection.ltr
                ? Alignment.topRight
                : Alignment.topLeft,
            child: Txt(
              "${marketOrder.orderStatus}",
              style: TxtStyle()
                ..maxWidth(80)
                ..alignmentContent.center()
                ..padding(vertical: 2)
                ..borderRadius(all: 4)
                ..background.color(Color(0xffEFEFEF))
                ..textColor(Colors.black)
                ..fontSize(12)
                ..bold(),
            ),
          )
        ],
      ),
    );
  }

  Widget get _divider {
    return Divider(
      color: Colors.black12,
      thickness: 0.5,
      height: 0,
    );
  }

  Widget get _fieldCustomerName {
    return OrderListItemField(
      title: "نام مشتری",
      text: "${marketOrder.customerName}",
      iconPath: "assets/images/ic_user.png",
      showIcon: showIcons,
    );
  }

  Widget get _fieldCustomerPhone {
    return OrderListItemField(
      title: "شماره تماس",
      text: "${marketOrder.customerPhone}".isNotEmpty
          ? "${marketOrder.customerPhone}".substring(0, 11)
          : "${marketOrder.customerPhone}",
      iconPath: "assets/images/ic_call.png",
      showIcon: showIcons,
    );
  }

  Widget get _fieldCustomerAddress {
    return OrderListItemField(
      title: "آدرس",
      text: "${marketOrder.address}",
      iconPath: "assets/images/ic_location.png",
      showIcon: showIcons,
    );
  }

  Widget get _fieldDeliveryTime {
    String text = "روز: " +
        "${marketOrder.deliveryTime}".split(" ")[0].replaceAll(".", "/") +
        "  ساعت: " +
        "${marketOrder.deliveryTime}".split(" ")[1];

    return OrderListItemField(
      title: "زمان تحویل",
      text: text,
      iconPath: "assets/images/ic_calendar.png",
      showIcon: showIcons,
    );
  }

  Widget get _fieldPaymentType {
    return OrderListItemField(
      title: "شیوه پرداخت",
      text: "${marketOrder.paymentType}",
      iconPath: "assets/images/ic_wallet.png",
      showIcon: showIcons,
    );
  }

  Widget get _verticalDivider => SizedBox(
        height: 40,
        child: VerticalDivider(
          color: Colors.black12,
          thickness: 0.5,
          width: 0.5,
        ),
      );

  Widget get _fieldTotalPrice {
    return CustomRichText(
      title: "قیمت محصولات" + "\n",
      text: _generatePriceText(
        marketOrder.totalPrice,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget get _fieldTotalDiscount {
    return CustomRichText(
      title: "تخفیف محصولات" + "\n",
      text: _generatePriceText(
        marketOrder.totalDiscount,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget get _fieldDeliveryCost {
    return CustomRichText(
      title: "هزینه ارسال" + "\n",
      text: _generatePriceText(
        marketOrder.deliveryCost,
      ),
      textAlign: TextAlign.center,
    );
  }

  String _generatePriceText(int price) {
    var text;
    if (price == null) {
      text = " ذکر نشده ";
    } else if (price == 0) {
      text = " رایگان ";
    } else {
      var temp;
      if ("$price".length >= 3) {
        temp = intl.NumberFormat("#,000").format(price);
      } else {
        temp = "$price";
      }

      text = " $temp " + "تومان";
    }

    return text;
  }
}
