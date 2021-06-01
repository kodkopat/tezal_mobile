// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class OrderListItemField extends StatelessWidget {
  OrderListItemField({
    required this.title,
    required this.text,
    required this.iconPath,
    this.showIcon,
  });

  final String title;
  final String text;
  final String iconPath;
  final bool? showIcon;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()..minHeight(24),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (showIcon ?? false)
                  Parent(
                    style: ParentStyle()
                      ..width(16)
                      ..height(16)
                      ..alignmentContent.center(),
                    child: Image.asset(
                      iconPath,
                      fit: BoxFit.contain,
                      color: Colors.black,
                    ),
                  ),
                SizedBox(width: 4),
                Txt(
                  title,
                  style: AppTxtStyles().footNote,
                ),
              ],
            ),
          ),
          Parent(
            style: ParentStyle()
              ..width(0.5)
              ..minHeight(24)
              ..background.color(Colors.black12),
          ),
          Expanded(
            flex: 2,
            child: Txt(
              text,
              style: AppTxtStyles().footNote
                ..padding(horizontal: 4)
                ..textAlign.start()
                ..textOverflow(TextOverflow.ellipsis)
                ..maxLines(3),
            ),
          ),
        ],
      ),
    );
  }
}
