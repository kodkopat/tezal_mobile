import 'package:flutter/material.dart';

import '../../../../data/models/customer/nearby_markets_result_model.dart';
import 'category_tab_bar.dart';
import 'category_tab_bar_view.dart';

class HomeMarketsWidget extends StatefulWidget {
  HomeMarketsWidget({required this.marketsList});

  final List<Markets> marketsList;

  @override
  _HomeMarketsWidgetState createState() => _HomeMarketsWidgetState();
}

class _HomeMarketsWidgetState extends State<HomeMarketsWidget>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTabBar(
          controller: tabController = TabController(
            length: widget.marketsList.length,
            vsync: this,
          ),
          textList: widget.marketsList.map((e) => "${e.categoryname}").toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: widget.marketsList
                .map((e) => CategoryTabBarView(markets: e.markets!))
                .toList(),
          ),
        ),
      ],
    );
  }
}
