// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../data/models/customer/nearby_markets_result_model.dart';
import '../../../customer_providers/market_notifier.dart';
import '../../market_detail/market_detail_page.dart';
import 'markets_list.dart';

class CategoryTabBarView extends StatelessWidget {
  CategoryTabBarView({
    Key? key,
    required this.marketCategory,
  }) : super(key: key);

  final MarketCategory marketCategory;

  @override
  Widget build(BuildContext context) {
    return MarketsList(
      markets: marketCategory.markets!,
      onItemTap: (index) {
        Routes.sailor.navigate(
          MarketDetailPage.route,
          params: {"marketId": marketCategory.markets![index].id},
        );
      },
      onItemLikeStatusChanged: (index) {
        var marketNotifier = Get.find<MarketNotifier>();
        var marketId = marketCategory.markets![index].id;

        marketNotifier.like(marketId: marketId);
      },
    );
  }
}
