// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class SearchBox extends StatefulWidget {
  SearchBox({
    required this.controller,
    required this.onSearchTap,
    required this.terms,
    this.textDirection,
  });

  final TextEditingController controller;
  final void Function() onSearchTap;
  final List<String> terms;
  final TextDirection? textDirection;

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _divider = Divider(
    color: Colors.black12,
    thickness: 0.5,
    height: 0,
  );

  final _textStyle = TextStyle(
    height: 2.5,
    color: Colors.black,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  final _hintStyle = TextStyle(
    height: 2.5,
    color: Colors.black54,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  bool searchBoxIsEmpty = true;
  FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        searchBoxIsEmpty = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLines: 1,
          enabled: true,
          focusNode: focus,
          controller: widget.controller,
          textDirection: widget.textDirection ?? TextDirection.rtl,
          style: _textStyle,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) {
            widget.onSearchTap();
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            hintText: "جستجوی محصولات ...",
            hintStyle: _hintStyle,
            suffixIcon: Parent(
              gesture: Gestures()
                ..onTap(() {
                  widget.controller.clear();
                }),
              style: ParentStyle()
                ..width(48)
                ..height(48)
                ..margin(horizontal: 2)
                ..borderRadius(all: 24)
                ..ripple(true),
              child: Icon(
                Feather.x,
                color: searchBoxIsEmpty ? Colors.transparent : Colors.black,
                size: 18,
              ),
            ),
          ),
        ),
        _divider,
        if (focus.hasFocus)
          _SearchSuggestionList(
            terms: widget.terms,
            onTermSelected: (value) {
              setState(() {
                widget.controller.text = value;
              });
            },
          ),
      ],
    );
  }
}

class _SearchSuggestionList extends StatelessWidget {
  _SearchSuggestionList({
    required this.terms,
    required this.onTermSelected,
  });

  final List<String> terms;
  final void Function(String) onTermSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: terms.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Txt(
          terms[index],
          gesture: Gestures()
            ..onTap(() {
              onTermSelected(terms[index]);
            }),
          style: TxtStyle()
            ..padding(horizontal: 16, vertical: 12)
            ..textAlign.right()
            ..background.color(Colors.white)
            ..textColor(Colors.black87)
            ..fontSize(12)
            ..ripple(true),
        );
      },
    );
  }
}
