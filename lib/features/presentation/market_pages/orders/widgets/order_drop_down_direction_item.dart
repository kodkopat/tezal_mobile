// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class OrderDropDownDirectionItem extends StatelessWidget {
  OrderDropDownDirectionItem({
    required this.text,
    required this.value,
    required this.onValueChanged,
  });

  final String text;
  final bool value;
  final void Function(bool) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()
        ..onTap(() {
          onValueChanged(!value);
        }),
      style: ParentStyle()
        ..height(40)
        ..padding(horizontal: 16)
        ..ripple(true),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(
            text,
            style: AppTxtStyles().body
              ..textAlign.start()
              ..padding(top: 4)
              ..textColor(Colors.black)
              ..textOverflow(TextOverflow.fade)
              ..maxLines(3),
          ),
          Image.asset(
            value
                ? "assets/images/ic_check_mark_filled.png"
                : "assets/images/ic_check_mark_empty.png",
            fit: BoxFit.contain,
            color: value ? Theme.of(context).accentColor : Colors.black,
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }
}
