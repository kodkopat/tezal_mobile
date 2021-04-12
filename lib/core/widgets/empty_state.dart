// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../styles/txt_styles.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Txt(
        "موردی برای نمایش وجود ندارد!",
        style: AppTxtStyles().body..alignment.center(),
      ),
    );
  }
}
