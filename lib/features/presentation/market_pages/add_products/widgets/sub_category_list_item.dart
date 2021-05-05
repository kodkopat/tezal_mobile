// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class SubCategoryListItem extends StatelessWidget {
  SubCategoryListItem({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Txt(
      text,
      gesture: Gestures()..onTap(onTap),
      style: AppTxtStyles().footNote
        ..alignmentContent.center()
        ..margin(horizontal: 4)
        ..padding(horizontal: 16)
        ..textColor(selected ? Colors.white : Theme.of(context).primaryColor)
        ..background.color(
            selected ? Theme.of(context).primaryColor : Colors.transparent)
        ..borderRadius(all: 8)
        ..border(
          all: 1.5,
          style: BorderStyle.solid,
          color: selected
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withOpacity(0.2),
        )
        ..ripple(true)
        ..bold(),
    );
  }
}
