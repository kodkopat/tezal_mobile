import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../core/styles/txt_styles.dart';
import '../page_routes/routes.dart';
import '../themes/app_theme.dart';

class SimpleAppBar {
  static AppBar intance({@required String text, bool showBackBtn}) => AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 1,
        title: Row(
          children: [
            if (showBackBtn ?? false)
              Parent(
                gesture: Gestures()..onTap(() => Routes.sailor.pop()),
                style: ParentStyle()
                  ..width(48)
                  ..height(48)
                  ..margin(right: 4)
                  ..borderRadius(all: 24)
                  ..ripple(true),
                child: Icon(
                  Feather.arrow_right,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            Txt(
              text,
              style: AppTxtStyles().subHeading
                ..margin(right: showBackBtn ?? false ? 4 : 16)
                ..textColor(AppTheme.white)
                ..textOverflow(TextOverflow.ellipsis)
                ..maxLines(1)
                ..bold(),
            ),
          ],
        ),
      );
}
