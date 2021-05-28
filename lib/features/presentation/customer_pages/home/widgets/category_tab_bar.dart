// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import 'category_tab_bar_item.dart';

class CategoryTabBar extends StatelessWidget {
  CategoryTabBar({
    required this.controller,
    required this.textList,
  });

  final TabController controller;
  final List<String> textList;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width)
        ..height(48)
        ..background.color(Theme.of(context).primaryColor),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: Colors.white,
        indicatorWeight: 2,
        indicatorColor: Theme.of(context).accentColor,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: Colors.white,
        tabs: textList.map((title) => CategoryTabBarItem(text: title)).toList(),
      ),
    );
  }
}
