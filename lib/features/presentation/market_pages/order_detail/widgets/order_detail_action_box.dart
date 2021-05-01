// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class OrderDetailActionBox extends StatelessWidget {
  OrderDetailActionBox({
    required this.onApproveOrder,
    required this.onRejectOrder,
  });

  final void Function() onApproveOrder;
  final void Function() onRejectOrder;

  final _approveTxtStyle = AppTxtStyles().body
    ..bold()
    ..height(48)
    ..borderRadius(all: 8)
    ..textColor(Colors.white)
    ..background.color(Colors.green)
    ..textAlign.center()
    ..alignmentContent.center()
    ..ripple(true);

  final _rejectTxtStyle = AppTxtStyles().body
    ..bold()
    ..height(48)
    ..borderRadius(all: 8)
    ..textColor(Colors.white)
    ..background.color(Colors.red)
    ..textAlign.center()
    ..alignmentContent.center()
    ..ripple(true);

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()..margin(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Txt(
              "تایید سفارش",
              gesture: Gestures()..onTap(onApproveOrder),
              style: _approveTxtStyle,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Txt(
              "لغو سفارش",
              gesture: Gestures()..onTap(onRejectOrder),
              style: _rejectTxtStyle,
            ),
          ),
        ],
      ),
    );
  }
}
