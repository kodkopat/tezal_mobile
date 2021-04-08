import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'loading.dart';

class AppProgressDialog {
  final BuildContext context;

  AppProgressDialog(this.context);

  ProgressDialog get instance {
    return ProgressDialog(context,
        isDismissible: true,
        type: ProgressDialogType.Normal,
        customBody: AppLoading())
      ..style(
        backgroundColor: Colors.black,
        progressWidgetAlignment: Alignment.center,
      );
  }
}
