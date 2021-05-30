import 'package:flutter/material.dart';

import '../../../../data/models/customer/market_categories_result_model.dart';
import 'category_tab_bar.dart';
import 'category_tab_bar_view.dart';

class HomeMarketsWidget extends StatefulWidget {
  HomeMarketsWidget({required this.marketCategories});

  final List<MarketCategory> marketCategories;

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
            length: widget.marketCategories.length,
            vsync: this,
          ),
          textList: widget.marketCategories.map((e) => "${e.name}").toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: widget.marketCategories
                .map((e) => CategoryTabBarView(marketCategoryId: e.id))
                .toList(),
          ),
        ),
      ],
    );
  }
}
