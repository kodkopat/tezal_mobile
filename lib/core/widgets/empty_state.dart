import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../styles/txt_styles.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key key, this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Txt(
        text ?? "موردی برای نمایش وجود ندارد!",
        style: AppTxtStyles().body..alignment.center(),
      ),
    );
  }
}
