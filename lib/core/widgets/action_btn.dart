import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../core/styles/txt_styles.dart';
import '../../core/themes/app_theme.dart';

class ActionBtn extends StatelessWidget {
  ActionBtn({
    @required this.text,
    @required this.onTap,
    this.background,
    this.textColor,
  });

  final String text;
  final Color background;
  final Color textColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Txt(
      text,
      gesture: Gestures()..onTap(onTap),
      style: AppTxtStyles().body
        ..bold()
        ..height(48)
        ..textColor(textColor ?? AppTheme.white)
        ..alignmentContent.center(true)
        ..background.color(background ?? AppTheme.red)
        ..borderRadius(all: 12)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        )
        ..ripple(true),
    );
  }
}
