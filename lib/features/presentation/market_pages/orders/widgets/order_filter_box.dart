// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import 'order_filter_box_drop_down.dart';

class OrderFilterBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
      child: OrderFilterBoxDropDown(
        textList: [
          "بر اساس تاریخ",
          "بر اساس وضعیت",
          "بر اساس کم‌ترین قیمت",
          "بر اساس بیش‌ترین قیمت",
        ],
      ),
    );
  }
}
