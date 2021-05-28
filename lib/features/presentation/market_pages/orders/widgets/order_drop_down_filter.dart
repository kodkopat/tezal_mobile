// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import 'order_drop_down_filter_item.dart';

class OrderDropDownFilter extends StatefulWidget {
  OrderDropDownFilter({
    required this.labelText,
    required this.onIndexChanged,
    required this.textList,
    required this.clearFilterOnTap,
    this.defaultListIndex,
  });

  final String labelText;
  final void Function(int) onIndexChanged;
  final List<String> textList;
  final VoidCallback clearFilterOnTap;
  final int? defaultListIndex;

  @override
  _OrderDropDownFilterState createState() => _OrderDropDownFilterState();
}

class _OrderDropDownFilterState extends State<OrderDropDownFilter> {
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
                selectedIndex != -1
                    ? Txt(
                        "پاک کردن فیلترها",
                        gesture: Gestures()..onTap(widget.clearFilterOnTap),
                        style: AppTxtStyles().body
                          ..padding(horizontal: 8, vertical: 4)
                          ..textColor(Theme.of(context).accentColor)
                          ..background.color(Color(0xffEFEFEF))
                          ..borderRadius(all: 4)
                          ..ripple(true),
                      )
                    : Image.asset(
                        showAllItems
                            ? "assets/images/ic_chevron_up.png"
                            : "assets/images/ic_chevron_down.png",
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
                    return OrderDropDownFilterItem(
                      text: "${widget.textList[index]}",
                      value: index == selectedIndex,
                      onValueChanged: (value) {
                        if (value) {
                          setState(() {
                            selectedIndex = index;
                            widget.onIndexChanged(selectedIndex);
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
