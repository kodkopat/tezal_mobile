import 'package:flutter/material.dart';
import 'package:tezal/lang/Lang.dart';
import 'package:tezal/services/FlatColors.dart';

class AlertService {
  static void showError(BuildContext context, String title, String content,
      [VoidCallback confirm]) {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: FlatColors.red_dark,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(title),
              )
            ],
          ),
          content: SingleChildScrollView(
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Lang(context).ok),
              onPressed: () {
                if (confirm != null)
                  confirm.call();
                else
                  Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  static void showConfirm(BuildContext context, String title, String content,
      VoidCallback confirm) {
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.info,
                color: FlatColors.green_dark,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(title),
              )
            ],
          ),
          content: SingleChildScrollView(
            child: Text(content),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Lang(context).ok),
              onPressed: () {
                confirm.call();
              },
            ),
            TextButton(
              child: Text(Lang(context).cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
