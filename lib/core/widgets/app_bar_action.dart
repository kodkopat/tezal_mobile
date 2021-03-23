import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../core/page_routes/routes.dart';
import '../../core/styles/txt_styles.dart';
import '../themes/app_theme.dart';

class AppBarAction extends StatelessWidget {
  AppBarAction({
    @required this.text,
    this.showBackBtn,
  });

  final String text;
  final bool showBackBtn;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        (showBackBtn ?? false)
            ? Parent(
                gesture: Gestures()..onTap(() => Routes.sailor.pop()),
                style: ParentStyle()
                  ..width(48)
                  ..height(48)
                  ..margin(all: 4)
                  ..borderRadius(all: 24)
                  ..ripple(true),
                child: Icon(
                  Feather.arrow_right,
                ),
              )
            : SizedBox(width: 16),
        Txt(
          text,
          style: AppTxtStyles().subHeading
            ..textColor(AppTheme.icons)
            ..textOverflow(TextOverflow.ellipsis)
            ..maxLines(1)
            ..bold(),
        ),
      ],
    );
  }
}
