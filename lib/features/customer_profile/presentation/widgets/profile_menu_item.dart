import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../core/styles/txt_styles.dart';

class ProfileMenuItem extends StatelessWidget {
  ProfileMenuItem({
    Key key,
    @required this.text,
    @required this.iconData,
    @required this.onTap,
    this.showChevron,
  }) : super(key: key);

  final String text;
  final IconData iconData;
  final void Function() onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..height(48)
        ..padding(right: 16, left: 20)
        ..ripple(true),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                iconData,
                color: Colors.black,
                size: 24,
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
            Icon(
              Feather.chevron_left,
              color: Colors.black,
              size: 16,
            ),
        ],
      ),
    );
  }
}
