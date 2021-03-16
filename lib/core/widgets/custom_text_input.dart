import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  CustomTextInput({
    this.label,
    @required this.controller,
    @required this.validator,
    this.keyboardType,
    this.textDirection,
    this.maxLength,
  });

  final String label;
  final TextEditingController controller;
  final String Function(String) validator;
  final TextInputType keyboardType;
  final TextDirection textDirection;
  final maxLength;

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      gapPadding: 0.0,
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Color(0xffF0F0F0),
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    );

    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Txt(
            label,
            style: TxtStyle()
              ..textAlign.right()
              ..margin(right: 6)
              ..textColor(Color(0xff4C5264))
              ..fontWeight(FontWeight.normal)
              ..fontSize(14)
              ..bold(),
          ),
        if (label != null) SizedBox(height: 2),
        TextFormField(
          maxLines: 1,
          controller: controller,
          validator: validator,
          textDirection: textDirection ?? TextDirection.rtl,
          style: TextStyle(
            height: 2.5,
            color: Color(0xff4C5264),
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          keyboardType: keyboardType ?? TextInputType.text,
          inputFormatters: [
            if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffF0F0F0),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
        ),
      ],
    );
  }
}
