// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class MainCategoryTabBarItem extends StatelessWidget {
  MainCategoryTabBarItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Txt(
      text,
      style: AppTxtStyles().body
        ..textColor(Colors.white)
        ..bold(),
    );
  }
}
