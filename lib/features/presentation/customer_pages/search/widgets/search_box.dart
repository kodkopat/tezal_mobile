// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

import '../../../../../core/styles/txt_styles.dart';

class SearchBox extends StatefulWidget {
  SearchBox({
    required this.controller,
    required this.onSearchTap,
    required this.onClearSearchTermsTap,
    required this.terms,
    this.textDirection,
  });

  final TextEditingController controller;
  final void Function() onSearchTap;
  final void Function() onClearSearchTermsTap;
  final List<String> terms;
  final TextDirection? textDirection;

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final focusNode = FocusNode();

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLines: 1,
          enabled: true,
          focusNode: focusNode,
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
            fillColor: Colors.white,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            hintText: "جستجو در بین محصولات ...",
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
        if (focusNode.hasFocus)
          if (widget.terms.isNotEmpty)
            _SearchSuggestionList(
              terms: widget.terms,
              onTermSelected: (value) {
                setState(() {
                  widget.controller.text = value;
                });
              },
              onClearSearchTerms: widget.onClearSearchTermsTap,
            ),
      ],
    );
  }
}

class _SearchSuggestionList extends StatelessWidget {
  _SearchSuggestionList({
    required this.terms,
    required this.onTermSelected,
    required this.onClearSearchTerms,
  });

  final List<String> terms;
  final void Function(String) onTermSelected;
  final void Function() onClearSearchTerms;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: terms.length + 1,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Parent(
            gesture: Gestures()
              ..onTap(() {
                if (index != terms.length) {
                  onTermSelected(terms[index]);
                } else {
                  onClearSearchTerms();
                }
              }),
            style: ParentStyle()
              ..height(36)
              ..ripple(true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 12),
                Image.asset(
                  index != terms.length
                      ? "assets/images/ic_clock_circle.png"
                      : "assets/images/ic_delete.png",
                  fit: BoxFit.contain,
                  color: index != terms.length
                      ? Colors.black.withOpacity(0.75)
                      : Colors.red.withOpacity(0.75),
                  width: 18,
                  height: 18,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Txt(
                    index != terms.length
                        ? terms[index]
                        : "پاک کردن سوابق جستجو",
                    style: AppTxtStyles().body
                      ..alignmentContent.centerRight()
                      ..textAlign.start()
                      ..padding(top: 2)
                      ..textColor(index != terms.length
                          ? Colors.black.withOpacity(0.75)
                          : Colors.red.withOpacity(0.75)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
