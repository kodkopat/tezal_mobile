import 'package:flutter/material.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../data/models/nearby_markets_result_model.dart';
import '../../../../data/repositories/customer_market_repository.dart';
import '../../market_detail/market_detail_page.dart';
import 'nearby_markets_list_item.dart';

class NearByMarketsList extends StatelessWidget {
  NearByMarketsList({
    Key key,
    @required this.markets,
    @required this.repository,
  }) : super(key: key);

  final List<Market> markets;
  final CustomerMarketRepository repository;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: markets.length,
      padding: EdgeInsets.symmetric(vertical: 8),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return NearByMarketsListItem(
          market: markets[index],
          repository: repository,
          onTap: () {
            Routes.sailor.navigate(
              MarketDetailPage.route,
              params: {
                "marketId": markets[index].id,
              },
            );
          },
        );
      },
    );
  }
}
