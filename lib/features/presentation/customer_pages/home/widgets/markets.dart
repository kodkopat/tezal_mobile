import 'package:flutter/material.dart';

import '../../../../data/models/customer/nearby_markets_result_model.dart';
import 'category_tab_bar.dart';
import 'category_tab_bar_view.dart';

class HomeMarketsWidget extends StatefulWidget {
  HomeMarketsWidget({required this.marketCategories});

  // final List<MarketCategory> marketCategories;
  final List<Data> marketCategories;

  @override
  _HomeMarketsWidgetState createState() => _HomeMarketsWidgetState();
}

class _HomeMarketsWidgetState extends State<HomeMarketsWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTabBar(
          textList:
              widget.marketCategories.map((e) => "${e.category}").toList(),
          selectedIndex: selectedIndex,
          onItemTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        CategoryTabBarView(
          key: GlobalKey(),
          market: widget.marketCategories[selectedIndex],
        ),
      ],
    );
  }
}
