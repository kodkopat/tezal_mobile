import 'package:flutter/material.dart';

class CustomRichText extends StatelessWidget {
  CustomRichText({
    required this.title,
    required this.text,
    this.textAlign,
    this.dashedLineText,
  });

  final String title;
  final String text;
  final TextAlign? textAlign;
  final bool? dashedLineText;

  final _textStyle = TextStyle(
    color: Colors.black,
    letterSpacing: 0.5,
    fontFamily: 'Yekan',
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return RichText(
      textDirection: Directionality.of(context),
      textAlign: textAlign ?? TextAlign.right,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: _textStyle,
          ),
          TextSpan(
            text: text,
            style: _textStyle.copyWith(
              decoration: dashedLineText ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
