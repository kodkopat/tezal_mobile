// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/widgets/load_more_btn.dart';
import '../../../../data/models/customer/nearby_markets_result_model.dart';
import '../../../customer_providers/market_notifier.dart';
import '../../market_detail/market_detail_page.dart';
import 'markets_list.dart';

class CategoryTabBarView extends StatelessWidget {
  CategoryTabBarView({required this.markets});

  final List<Market> markets;

  @override
  Widget build(BuildContext context) {
    var marketNotifier = Get.find<MarketNotifier>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MarketsList(
              markets: markets,
              onItemTap: (index) {
                Routes.sailor.navigate(
                  MarketDetailPage.route,
                  params: {"marketId": markets[index].id},
                );
              }),
          if (marketNotifier.enableLoadMoreData!)
            LoadMoreBtn(onTap: () {
              marketNotifier.fetchNearbyMarkets(context);
            })
        ],
      ),
    );
  }
}
