// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/themes/app_theme.dart';
import 'market_main_category_tab_bar_item.dart';

class MarketMainCategoryTabBar extends StatelessWidget {
  const MarketMainCategoryTabBar({
    required this.controller,
    required this.textList,
    required this.onItemTap,
  });

  final TabController controller;
  final List<String> textList;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width)
        ..height(48)
        ..background.color(AppTheme.customerPrimary),
      child: TabBar(
        controller: controller,
        isScrollable: true,
        labelColor: Colors.white,
        indicatorWeight: 2,
        indicatorColor: AppTheme.customerAccent,
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: Colors.white,
        tabs: textList.map((title) {
          return MarketMainCategoryTabBarItem(
            text: title,
            onTap: () {},
          );
        }).toList(),
      ),
    );
  }
}
