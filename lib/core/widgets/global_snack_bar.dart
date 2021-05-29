// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/presentation/app_notifier.dart';
import '../styles/txt_styles.dart';

class GlobalSnackBar extends SnackBar {
  final String text;

  GlobalSnackBar({required this.text})
      : super(
          content: Txt(
            text,
            style: AppTxtStyles().body
              ..padding(top: 4)
              ..fontFamily(Get.find<AppNotifier>().fontFamily)
              ..textColor(Colors.white),
          ),
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.red,
          duration: Duration(days: 1),
          elevation: 1.0,
        );
}
