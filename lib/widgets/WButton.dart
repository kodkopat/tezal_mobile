import 'package:flutter/material.dart';

class WButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final double bgColorOpacity;
  final Color textColor;
  final double height;
  final VoidCallback onPressed;

  const WButton(
      {Key key,
      this.text,
      this.bgColor: Colors.white,
      this.bgColorOpacity: 0.2,
      this.textColor,
      this.height: 50,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: height,
      child: FlatButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
          color: bgColor.withOpacity(bgColorOpacity)),
    );
  }
}