import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    @required this.controller,
    @required this.onSearchTap,
    this.textDirection,
  }) : super(key: key);

  final TextEditingController controller;
  final void Function() onSearchTap;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      height: 2.5,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );

    var hintStyle = TextStyle(
      height: 2.5,
      color: Colors.black54,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );

    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLines: 1,
          controller: controller,
          textDirection: textDirection ?? TextDirection.rtl,
          style: textStyle,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            hintText: "جستجوی محصولات ...",
            hintStyle: hintStyle,
            suffixIcon: Parent(
              gesture: Gestures()..onTap(onSearchTap),
              style: ParentStyle()
                ..width(48)
                ..height(48)
                ..margin(horizontal: 2)
                ..borderRadius(all: 24)
                ..ripple(true),
              child: Icon(
                Feather.search,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
