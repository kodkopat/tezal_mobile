import 'package:flutter/material.dart';

import '../../data/models/nearby_markets_result_model.dart';
import '../../data/repositories/customer_market_repository.dart';
import 'modal_market_detail.dart';
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
      itemCount: markets.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return NearByMarketsListItem(
          market: markets[index],
          repository: repository,
          onTap: () {
            showDialog(
              context: context,
              useSafeArea: true,
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.2),
              builder: (context) {
                return MarketDetailModal(
                  marketId: markets[index].id,
                );
              },
            );
          },
        );
      },
    );
  }
}
