import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:tezal/core/styles/txt_styles.dart';

class LogOutModal extends StatelessWidget {
  LogOutModal({
    @required this.onAccept,
    @required this.onDiscard,
  });

  final void Function() onAccept;
  final void Function() onDiscard;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        elevation: 0,
        actionsPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        contentPadding: EdgeInsets.fromLTRB(16, 4, 16, 16),
        buttonPadding: EdgeInsets.symmetric(horizontal: 12),
        title: Txt(
          "خروج از حساب کاربری",
          style: AppTxtStyles().subHeading
            ..textAlign.right()
            ..bold(),
        ),
        content: Txt(
          "آیا مطمئن هستید که می‌خواهید از حساب کاربری خود خارج شوید؟",
          style: AppTxtStyles().body..textAlign.right(),
        ),
        actions: [
          Txt(
            "بله",
            style: AppTxtStyles().body
              ..padding(horizontal: 12, vertical: 4)
              ..borderRadius(all: 4)
              ..ripple(true),
            gesture: Gestures()..onTap(onAccept),
          ),
          Txt(
            "خیر",
            style: AppTxtStyles().body
              ..padding(horizontal: 12, vertical: 4)
              ..borderRadius(all: 4)
              ..ripple(true),
            gesture: Gestures()..onTap(onDiscard),
          ),
        ],
      ),
    );
  }
}
