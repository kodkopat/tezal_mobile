import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';

class MarketCommentListShowMoreBtn extends StatelessWidget {
  const MarketCommentListShowMoreBtn({
    Key key,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()..onTap(onTap),
      style: ParentStyle()
        ..margin(vertical: 8)
        ..padding(horizontal: 8, vertical: 16)
        ..background.color(Colors.white)
        ..borderRadius(all: 8)
        ..boxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 4.0),
          blur: 8,
          spread: 0,
        )
        ..ripple(true),
      child: Txt(
        text,
        style: AppTxtStyles().body..bold(),
      ),
    );
  }
}
