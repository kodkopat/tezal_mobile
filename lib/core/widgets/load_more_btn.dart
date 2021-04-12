// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../core/styles/txt_styles.dart';

class LoadMoreBtn extends StatelessWidget {
  LoadMoreBtn({required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Txt(
      "بارگذاری موارد بیشتر",
      gesture: Gestures()..onTap(onTap),
      style: AppTxtStyles().body
        ..bold()
        ..width(160)
        ..height(48)
        ..textColor(Colors.black87)
        ..alignmentContent.center(true)
        ..background.color(Color(0xffEFEFEF))
        ..borderRadius(all: 12)
        ..ripple(true),
    );
  }
}
