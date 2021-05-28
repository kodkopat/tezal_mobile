// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../core/styles/txt_styles.dart';
import '../languages/language.dart';

class LoadMoreBtn extends StatelessWidget {
  LoadMoreBtn({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Txt(
      Lang.of(context).loadMore,
      gesture: Gestures()..onTap(onTap),
      style: AppTxtStyles().body
        ..width(160)
        ..height(48)
        ..margin(vertical: 16)
        ..textColor(Colors.black87)
        ..alignmentContent.center(true)
        ..background.color(Color(0xffEFEFEF))
        ..borderRadius(all: 12)
        ..ripple(true),
    );
  }
}
