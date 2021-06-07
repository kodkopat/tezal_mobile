// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class OrderDetailField extends StatelessWidget {
  OrderDetailField({
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()..padding(vertical: 8),
      child: Row(
        children: [
          Txt(
            "$title: ",
            style: AppTxtStyles().footNote,
          ),
          Expanded(
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
