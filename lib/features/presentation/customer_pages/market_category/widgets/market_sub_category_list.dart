// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import 'market_sub_category_list_item.dart';

class MarketSubCategoryList extends StatelessWidget {
  MarketSubCategoryList({
    required this.textList,
    required this.selectedIndex,
    required this.onItemTap,
  });

  final List<String> textList;
  final int selectedIndex;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width)
        ..height(48)
        ..padding(horizontal: 8, vertical: 8)
        ..background.color(Colors.white)
        ..boxShadow(
          color: Colors.black12,
          offset: Offset(0, 3.0),
          blur: 6,
          spread: 0,
        ),
      child: ListView.builder(
        itemCount: textList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MarketSubCategoryListItem(
            text: textList[index],
            selected: selectedIndex == index,
            onTap: () => onItemTap(index),
          );
        },
      ),
    );
  }
}
