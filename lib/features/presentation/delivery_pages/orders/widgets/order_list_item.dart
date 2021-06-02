// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/delivery/orders_result_model.dart';
import 'order_list_item_field.dart';

class OrderListItem extends StatefulWidget {
  OrderListItem({
    required this.orderItem,
    required this.onTap,
    required this.showIcons,
  });

  final OrderItem orderItem;
  final VoidCallback onTap;
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
          if (_showCustomerInfo) _fieldCustomerLocation,
          if (_showCustomerInfo) _fieldCustomerAddress,
          _divider,
          _fieldMarketInfo,
          if (_showOrderInfo) _fieldMarketName,
          if (_showOrderInfo) _fieldMarketLocation,
          if (_showOrderInfo) _fieldMarketAddress,
          _divider,
          /* Row(
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
          ), */
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
      text: "${widget.orderItem.customerName}",
      iconPath: "assets/images/ic_user.png",
      showIcon: widget.showIcons,
    );
  }

  Widget get _fieldCustomerLocation {
    return OrderListItemField(
      title: "مختصات مشتری",
      text: "${widget.orderItem.customerLocation}",
      iconPath: "assets/images/ic_location.png",
      showIcon: widget.showIcons,
    );
  }

  Widget get _fieldCustomerAddress {
    return OrderListItemField(
      title: "آدرس مشتری",
      text: "${widget.orderItem.customerAdress}",
      iconPath: "assets/images/ic_location.png",
      showIcon: widget.showIcons,
    );
  }

  Widget get _fieldMarketInfo {
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

  Widget get _fieldMarketName {
    return OrderListItemField(
      title: "نام فروشگاه",
      text: "${widget.orderItem.marketName}",
      iconPath: "assets/images/ic_user.png",
      showIcon: widget.showIcons,
    );
  }

  Widget get _fieldMarketLocation {
    return OrderListItemField(
      title: "مختصات فروشگاه",
      text: "${widget.orderItem.marketLocation}",
      iconPath: "assets/images/ic_location.png",
      showIcon: widget.showIcons,
    );
  }

  Widget get _fieldMarketAddress {
    return OrderListItemField(
      title: "آدرس فروشگاه",
      text: "${widget.orderItem.marketAdress}",
      iconPath: "assets/images/ic_location.png",
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

  Widget get _fieldStatus => Txt(
        "${widget.orderItem.status}",
        style: TxtStyle()
          ..alignmentContent.center()
          ..padding(vertical: 4)
          ..borderRadius(all: 4)
          ..background.color(Color(0xffEFEFEF))
          ..textColor(Colors.black)
          ..fontSize(12)
          ..bold(),
      );
}
