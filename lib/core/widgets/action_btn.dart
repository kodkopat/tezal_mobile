import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../core/styles/txt_styles.dart';
import '../../core/themes/app_theme.dart';

class ActionBtn extends StatelessWidget {
  ActionBtn({
    @required this.text,
    @required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Txt(
      text,
      gesture: Gestures()..onTap(onTap),
      style: AppTxtStyles().body
        ..bold()
        ..height(48)
        ..textColor(AppTheme.white)
        ..alignmentContent.center(true)
        ..background.color(AppTheme.red)
        ..borderRadius(all: 12)
        ..ripple(true),
    );
  }
}
