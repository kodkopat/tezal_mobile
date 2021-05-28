// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class AddressDetailActionsMenuItem extends StatelessWidget {
  const AddressDetailActionsMenuItem({
    required this.text,
    required this.iconData,
    required this.onTap,
    this.color,
  });

  final String text;
  final IconData iconData;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..padding(horizontal: 16, vertical: 8)
        ..ripple(true),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            iconData,
            color: color ?? Colors.black,
            size: 18,
          ),
          SizedBox(width: 8),
          Txt(
            text,
            style: AppTxtStyles().body..textColor(color ?? Colors.black),
          ),
        ],
      ),
    );
  }
}
