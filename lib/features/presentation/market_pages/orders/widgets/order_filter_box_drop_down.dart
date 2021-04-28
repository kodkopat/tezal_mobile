// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import 'order_filter_box_drop_down_item.dart';

class OrderFilterBoxDropDown extends StatefulWidget {
  OrderFilterBoxDropDown({required this.textList});

  final List<String> textList;

  @override
  _OrderFilterBoxDropDownState createState() => _OrderFilterBoxDropDownState();
}

class _OrderFilterBoxDropDownState extends State<OrderFilterBoxDropDown> {
  bool showAllItems = false;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                "مرتب‌سازی لیست سفارشات",
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
                width: 24,
                height: 24,
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
                  return OrderFilterBoxDropDownItem(
                    text: "${widget.textList[index]}",
                    value: index == selectedIndex,
                    onValueChanged: (value) {
                      if (value) {
                        setState(() {
                          selectedIndex = index;
                        });
                      }
                    },
                  );
                },
              )
            : SizedBox(),
      ],
    );
  }
}
