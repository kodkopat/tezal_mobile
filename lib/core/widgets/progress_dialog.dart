import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_dialog/progress_dialog.dart';

class AppProgressDialog {
  AppProgressDialog(this.context);

  final BuildContext context;

  ProgressDialog get instance {
    return ProgressDialog(
      context,
      isDismissible: true,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
    )..style(
        message: "لطفا کمی صبر کنید",
        textAlign: TextAlign.start,
      );
  }
}
