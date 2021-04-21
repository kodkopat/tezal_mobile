// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class PickLocationComboBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(() {}),
      style: ParentStyle()
        ..margin(horizontal: 4, vertical: 4)
        ..padding(horizontal: 4, vertical: 4)
        ..borderRadius(all: 8)
        ..background.color(Colors.white)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        )
        ..ripple(true),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Parent(
            style: ParentStyle()
              ..width(40)
              ..height(40)
              ..borderRadius(all: 8)
              ..background.color(Color(0xffEFEFEF))
              ..alignmentContent.center(),
            child: Image.asset(
              "assets/images/ic_location.png",
              color: Colors.black,
              fit: BoxFit.contain,
              width: 24,
              height: 24,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Txt(
              "برای مشاهده نزدیک‌ترین فروشگاه‌های اطراف خود،"
              " موقعیت مکانی را فعال کنید.",
              style: AppTxtStyles().footNote
                ..textDirection(TextDirection.rtl)
                ..textAlign.right()
                ..textOverflow(TextOverflow.fade)
                ..maxLines(3),
            ),
          ),
        ],
      ),
    );
  }
}
