// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import 'search_drop_down_sort_item.dart';

class SearchDropdownSort extends StatefulWidget {
  SearchDropdownSort({
    required this.labelText,
    required this.onIndexChanged,
    required this.textList,
    this.defaultListIndex,
  });

  final String labelText;
  final void Function(int) onIndexChanged;
  final List<String> textList;
  final int? defaultListIndex;

  @override
  _SearchDropdownSortState createState() => _SearchDropdownSortState();
}

class _SearchDropdownSortState extends State<SearchDropdownSort> {
  bool showAllItems = false;
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.defaultListIndex ?? -1;
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..background.color(Colors.white)
        ..boxShadow(
          color: Colors.black12,
          offset: showAllItems ? Offset(0, 3.0) : Offset(0, 0.0),
          blur: showAllItems ? 6 : 0,
          spread: 0,
        )
        ..ripple(true),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Parent(
            gesture: Gestures()
              ..onTap(() {
                setState(() {
                  showAllItems = !showAllItems;
                });
              }),
            style: ParentStyle()
              ..height(48)
              ..padding(horizontal: 16)
              ..ripple(true),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  selectedIndex == -1
                      ? widget.labelText
                      : widget.textList[selectedIndex],
                  style: AppTxtStyles().body
                    ..textAlign.start()
                    ..padding(top: 4)
                    ..textColor(Colors.black)
                    ..textOverflow(TextOverflow.fade)
                    ..maxLines(3),
                ),
                Image.asset(
                  "assets/images/ic_filter_2.png",
                  fit: BoxFit.contain,
                  color: Colors.black,
                  width: 18,
                  height: 18,
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black12,
            thickness: 0.5,
            height: 0,
          ),
          showAllItems
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.textList.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SearchDropdownSortItem(
                      text: "${widget.textList[index]}",
                      value: index == selectedIndex,
                      onValueChanged: (value) {
                        if (value) {
                          setState(() {
                            selectedIndex = index;
                            widget.onIndexChanged(selectedIndex);
                            showAllItems = false;
                          });
                        }
                      },
                    );
                  },
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
