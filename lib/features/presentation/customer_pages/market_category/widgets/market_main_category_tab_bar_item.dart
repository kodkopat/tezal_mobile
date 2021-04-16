// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:tezal/core/styles/txt_styles.dart';

class MarketMainCategoryTabBarItem extends StatelessWidget {
  const MarketMainCategoryTabBarItem({
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Txt(
      text,
      style: AppTxtStyles().body..textColor(Colors.white),
      // gesture: Gestures()..onTap(onTap),
    );
  }
}
