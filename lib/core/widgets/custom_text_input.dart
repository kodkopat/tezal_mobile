// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  CustomTextInput({
    this.label,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.textDirection,
    this.maxLength,
    this.maxLine,
    this.obscureText,
  });

  final String? label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;
  final int? maxLength;
  final int? maxLine;
  final bool? obscureText;

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Txt(
            label!,
            style: TxtStyle()
              ..textAlign.right()
              ..margin(right: 6)
              ..textColor(Colors.black)
              ..fontWeight(FontWeight.normal)
              ..fontSize(14)
              ..bold(),
          ),
        if (label != null) SizedBox(height: 4),
        TextFormField(
          maxLines: maxLine ?? 1,
          obscureText: obscureText ?? false,
          controller: controller,
          validator: validator,
          textDirection: textDirection ?? TextDirection.ltr,
          style: TextStyle(
            height: 2.5,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          keyboardType: keyboardType ?? TextInputType.text,
          inputFormatters: [
            if (maxLength != null) LengthLimitingTextInputFormatter(maxLength),
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffEFEFEF),
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
