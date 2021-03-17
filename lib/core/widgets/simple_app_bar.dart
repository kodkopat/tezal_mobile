import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../core/styles/txt_styles.dart';
import '../themes/app_theme.dart';

class SimpleAppBar {
  static AppBar intance({@required String text}) => AppBar(
        automaticallyImplyLeading: false,
        title: Txt(
          text,
          style: AppTxtStyles().subHeading
            ..textColor(AppTheme.white)
            ..textOverflow(TextOverflow.ellipsis)
            ..maxLines(1)
            ..bold(),
        ),
      );
}
