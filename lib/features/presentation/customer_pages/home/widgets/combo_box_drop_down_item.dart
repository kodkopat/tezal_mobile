// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class HomeComboBoxDropDownItem extends StatelessWidget {
  HomeComboBoxDropDownItem({
    required this.text,
    required this.iconPath,
    required this.onTap,
    this.showChevron,
    this.chevronPath,
  });

  final String text;
  final String iconPath;
  // final VoidCallback onTap;
  final VoidCallback onTap;
  final bool? showChevron;
  final String? chevronPath;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..height(40)
        ..padding(horizontal: 8)
        ..ripple(true),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  iconPath,
                  fit: BoxFit.contain,
                  color: Colors.black,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Txt(
                    text,
                    style: AppTxtStyles().body
                      ..textAlign.start()
                      ..padding(top: 4)
                      ..textColor(Colors.black)
                      ..textOverflow(TextOverflow.fade)
                      ..maxLines(3),
                  ),
                ),
              ],
            ),
          ),
          if (showChevron ?? false)
            Image.asset(
              chevronPath!,
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
