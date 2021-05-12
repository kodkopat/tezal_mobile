// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class BankCardInformationsListItem extends StatelessWidget {
  BankCardInformationsListItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 8),
      child: Txt(
        "شماره شبا: " + text,
        style: AppTxtStyles().body..textAlign.start(),
      ),
    );
  }
}
