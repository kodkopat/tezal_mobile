import 'package:flutter/material.dart';

import '../../data/models/nearby_markets_result_model.dart';
import 'nearby_markets_list_item.dart';

class NearByMarketsList extends StatelessWidget {
  const NearByMarketsList({
    Key key,
    @required this.model,
  }) : super(key: key);

  final NearByMarketsResultModel model;

  @override
  Widget build(BuildContext context) {
    var markets = model.data.markets;

    return ListView.builder(
      itemCount: markets.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return NearByMarketsListItem(
          market: markets[index],
          onTap: () {},
        );
      },
    );
  }
}
