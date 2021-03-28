import 'package:flutter/material.dart';

class AddressDetailMenuItem extends StatelessWidget {
  AddressDetailMenuItem({
    Key key,
    @required this.title,
    @required this.text,
  }) : super(key: key);

  final String title;
  final String text;

  final _textStyle = TextStyle(
    color: Colors.black,
    letterSpacing: 0.5,
    fontFamily: 'Yekan',
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RichText(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        text: TextSpan(
          children: [
            TextSpan(
              text: title + " ",
              style: _textStyle,
            ),
            TextSpan(
              text: text,
              style: _textStyle.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
