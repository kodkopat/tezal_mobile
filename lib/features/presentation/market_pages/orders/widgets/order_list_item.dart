// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/utils/is_numeric.dart';
import '../../../../../core/utils/to_color.dart';
import '../../../../data/models/market/orders_result_model.dart';
import '../../../customer_widgets/custom_rich_text.dart';
import 'order_list_item_field.dart';

class OrderListItem extends StatefulWidget {
  OrderListItem({
    required this.marketOrder,
    required this.onTap,
    required this.showIcons,
  });

  final MarketOrder marketOrder;
  final void Function() onTap;
  final bool showIcons;

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool _showCustomerInfo = false;
  bool _showOrderInfo = false;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(widget.onTap),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _fieldCustomerInfo,
          if (_showCustomerInfo) _fieldCustomerName,
          if (_showCustomerInfo) _fieldCustomerPhone,
          if (_showCustomerInfo) _fieldCustomerAddress,
          _divider,
          _fieldOrderInfo,
          if (_showOrderInfo) _fieldDeliveryTime,
          if (_showOrderInfo) _fieldPaymentType,
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
          _divider,
          _fieldStatus,
        ],
      ),
    );
  }

  Widget get _divider {
    return Divider(
      color: Colors.black12,
      thickness: 0.5,
      height: 16,
    );
  }

  Widget get _fieldCustomerInfo {
    var _gesture = Gestures()
      ..onTap(() {
        setState(() {
          _showCustomerInfo = !_showCustomerInfo;
        });
      });

    return Parent(
      gesture: _gesture,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(
            "اطلاعات مشتری",
            style: AppTxtStyles().body,
          ),
          Parent(
            gesture: _gesture,
            style: ParentStyle()
              ..width(36)
              ..height(36)
              ..borderRadius(all: 18)
              ..alignmentContent.center()
              ..ripple(true),
            child: Image.asset(
              _showCustomerInfo
                  ? "assets/images/ic_chevron_up.png"
                  : "assets/images/ic_chevron_down.png",
              fit: BoxFit.contain,
              color: Colors.black,
              width: 18,
              height: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _fieldCustomerName {
    return OrderListItemField(
      title: "نام مشتری",
      text: "${widget.marketOrder.customerName}",
      iconPath: "assets/images/ic_user.png",
      showIcon: widget.showIcons,
    );
  }

  Widget get _fieldCustomerPhone {
    if (!"${widget.marketOrder.customerPhone}".isNumeric()) {}

    return OrderListItemField(
      title: "شماره تماس",
      text: "${widget.marketOrder.customerPhone}".isNumeric()
          ? "${widget.marketOrder.customerPhone}"
          : "-",
      iconPath: "assets/images/ic_call.png",
      showIcon: widget.showIcons,
    );
  }

  Widget get _fieldCustomerAddress {
    return OrderListItemField(
      title: "آدرس",
      text: "${widget.marketOrder.address}",
      iconPath: "assets/images/ic_location.png",
      showIcon: widget.showIcons,
    );
  }

  Widget get _fieldOrderInfo {
    var _gesture = Gestures()
      ..onTap(() {
        setState(() {
          _showOrderInfo = !_showOrderInfo;
        });
      });

    return Parent(
      gesture: _gesture,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(
            "اطلاعات سفارش",
            style: AppTxtStyles().body,
          ),
          Parent(
            gesture: _gesture,
            style: ParentStyle()
              ..width(36)
              ..height(36)
              ..borderRadius(all: 18)
              ..alignmentContent.center()
              ..ripple(true),
            child: Image.asset(
              _showCustomerInfo
                  ? "assets/images/ic_chevron_up.png"
                  : "assets/images/ic_chevron_down.png",
              fit: BoxFit.contain,
              color: Colors.black,
              width: 18,
              height: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _fieldDeliveryTime {
    String date = "روز: " +
        "${widget.marketOrder.deliveryTime}".split(" ")[0].replaceAll("-", "/");

    String time = "ساعت: " +
        "${widget.marketOrder.deliveryTime}".split(" ")[1].split(".")[0];

    return OrderListItemField(
      title: "زمان تحویل",
      text: date + "\n" + time,
      iconPath: "assets/images/ic_calendar.png",
      showIcon: widget.showIcons,
    );
  }

  Widget get _fieldPaymentType {
    return OrderListItemField(
      title: "شیوه پرداخت",
      text: "${widget.marketOrder.paymentType}",
      iconPath: "assets/images/ic_wallet.png",
      showIcon: widget.showIcons,
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
        widget.marketOrder.totalPrice,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget get _fieldTotalDiscount {
    return CustomRichText(
      title: "تخفیف محصولات" + "\n",
      text: _generatePriceText(
        widget.marketOrder.totalDiscount,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget get _fieldDeliveryCost {
    return CustomRichText(
      title: "هزینه ارسال" + "\n",
      text: _generatePriceText(
        widget.marketOrder.deliveryCost,
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

  Widget get _fieldStatus => Txt(
        "${widget.marketOrder.orderStatus}",
        style: TxtStyle()
          ..alignmentContent.center()
          ..padding(vertical: 4)
          ..borderRadius(all: 4)
          ..background.color(
            "${widget.marketOrder.color}".toColor().withOpacity(0.1),
          )
          ..textColor(
            "${widget.marketOrder.color}".toColor(),
          )
          ..fontSize(12)
          ..bold(),
      );
}
