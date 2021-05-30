// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/customer/market_detail_result_model.dart';
import '../../customer_providers/basket_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/market_main_category_tab_bar.dart';
import 'widgets/market_main_category_tab_bar_view.dart';

class MarketCategoryPage extends StatefulWidget {
  static const route = "/customer_market_category";

  MarketCategoryPage({
    required this.marketId,
    required this.categories,
  });

  final String marketId;
  final List<Category> categories;

  @override
  _MarketCategoryPageState createState() => _MarketCategoryPageState();
}

class _MarketCategoryPageState extends State<MarketCategoryPage>
    with TickerProviderStateMixin {
  BasketNotifier? basketNotifier;
  late TabController tabController;

  bool loading = true;

  var mainCategoryNameList = <String>[];
  var mainCategoryIdList = <String>[];

  void initializeState() async {
    widget.categories.forEach((category) {
      mainCategoryIdList.add(category.id);
      mainCategoryNameList.add(category.name);
    });

    tabController = TabController(
      length: mainCategoryIdList.length,
      vsync: this,
    );

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "دسته‌بندی",
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: loading
          ? Txt("انتظار", style: AppTxtStyles().footNote)
          : Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MarketMainCategoryTabBar(
                  controller: tabController,
                  textList: mainCategoryNameList,
                  onItemTap: (index) {
                    print(
                      "selected main category id: "
                      "${mainCategoryIdList[index]}\n",
                    );
                  },
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: widget.categories.map((category) {
                      return MarketMainCategoryTabBarView(
                        marketId: widget.marketId,
                        mainCategoryId: category.id,
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
    );
  }
}
