// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({
    required this.label,
    required this.defaultValue,
    required this.values,
    required this.onChange,
  });

  final String label;
  final dynamic defaultValue;
  final List<dynamic> values;
  final void Function(dynamic) onChange;

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    // print("widget value: ${widget.defaultValue}\n");
    // print("widget values: ${widget.values}\n");

    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*  Txt(
          widget.label,
          style: TxtStyle()
            ..textAlign.right()
            ..margin(right: 6)
            ..textColor(Colors.black)
            ..fontWeight(FontWeight.normal)
            ..fontSize(14)
            ..bold(),
        ),
        SizedBox(height: 2),
         */

        Parent(
          style: ParentStyle()
            ..width(MediaQuery.of(context).size.width)
            ..padding(horizontal: 16)
            ..borderRadius(all: 8)
            ..border(
              all: 0.5,
              color: Colors.black.withOpacity(0.5),
              style: BorderStyle.solid,
            )
          /* ..background.color(Color(0xffF0F0F0)) */,
          child: DropdownButtonHideUnderline(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DropdownButton(
                value: widget.defaultValue,
                items: widget.values.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Container(
                      height: 48,
                      alignment: Alignment.centerRight,
                      child: Txt(
                        e,
                        style: TxtStyle()
                          ..textAlign.right()
                          ..textColor(Colors.black)
                          ..fontWeight(FontWeight.normal)
                          ..fontSize(14),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  widget.onChange(value);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
