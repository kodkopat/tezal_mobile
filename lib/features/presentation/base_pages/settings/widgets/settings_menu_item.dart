// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class SettingsMenuItem extends StatelessWidget {
  SettingsMenuItem({
    required this.text,
    required this.iconPath,
    required this.onTap,
    this.showChevron,
  });

  final String text;
  final String iconPath;
  final VoidCallback onTap;
  final bool? showChevron;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..height(48)
        ..padding(horizontal: 20)
        ..ripple(true),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                iconPath,
                fit: BoxFit.contain,
                color: Colors.black,
                width: 24,
                height: 24,
              ),
              SizedBox(width: 16),
              Txt(
                text,
                style: AppTxtStyles().body
                  ..padding(top: 4)
                  ..textColor(Colors.black),
              ),
            ],
          ),
          if (showChevron ?? true)
            Image.asset(
              Directionality.of(context) == TextDirection.ltr
                  ? "assets/images/ic_chevron_right.png"
                  : "assets/images/ic_chevron_left.png",
              fit: BoxFit.contain,
              color: Colors.black,
              width: 16,
              height: 16,
            ),
        ],
      ),
    );
  }
}
