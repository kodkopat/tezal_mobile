// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../styles/txt_styles.dart';

class ImagePickerListItem extends StatelessWidget {
  ImagePickerListItem({
    required this.text,
    required this.iconPath,
    required this.onTap,
  });

  final String text;
  final String iconPath;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..height(48)
        ..padding(horizontal: 16)
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
                style: AppTxtStyles().body..textColor(Colors.black),
              ),
            ],
          ),
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
