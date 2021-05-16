// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../core/languages/language.dart';
import '../../../core/styles/txt_styles.dart';

class LogOutModal extends StatelessWidget {
  LogOutModal({
    required this.onAccept,
    required this.onDiscard,
  });

  final void Function() onAccept;
  final void Function() onDiscard;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      actionsPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.fromLTRB(16, 16, 16, 4),
      contentPadding: EdgeInsets.fromLTRB(16, 4, 16, 16),
      buttonPadding: EdgeInsets.symmetric(horizontal: 12),
      title: Txt(
        Lang.of(context).logOutTitle,
        style: AppTxtStyles().subHeading..bold(),
      ),
      content: Txt(
        Lang.of(context).logOutDescription,
        style: AppTxtStyles().body,
      ),
      actions: [
        Txt(
          Lang.of(context).logOutAgree,
          style: AppTxtStyles().body
            ..padding(horizontal: 12, vertical: 4)
            ..borderRadius(all: 4)
            ..ripple(true),
          gesture: Gestures()..onTap(onAccept),
        ),
        Txt(
          Lang.of(context).logOutDisagree,
          style: AppTxtStyles().body
            ..padding(horizontal: 12, vertical: 4)
            ..borderRadius(all: 4)
            ..ripple(true),
          gesture: Gestures()..onTap(onDiscard),
        ),
      ],
    );
  }
}
