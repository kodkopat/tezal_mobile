// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../core/styles/txt_styles.dart';

class ActionBtn extends StatelessWidget {
  ActionBtn({
    required this.text,
    required this.onTap,
    this.background,
    this.textColor,
    this.height,
  });

  final String text;
  final void Function() onTap;
  final Color? background;
  final Color? textColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Txt(
      text,
      gesture: Gestures()..onTap(onTap),
      style: AppTxtStyles().body
        ..bold()
        ..height(height ?? 48)
        ..textColor(textColor ?? Colors.white)
        ..alignmentContent.center(true)
        ..background.color(background ?? Colors.green)
        ..borderRadius(all: 12)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        )
        ..ripple(true),
    );
  }
}
