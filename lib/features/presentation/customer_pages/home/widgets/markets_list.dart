import 'package:flutter/material.dart';

import '../../../../data/models/customer/nearby_markets_result_model.dart';
import 'markets_list_item.dart';

class MarketsList extends StatelessWidget {
  MarketsList({
    required this.markets,
    required this.onItemTap,
    required this.onItemLikeStatusChanged,
  });

  final List<Market> markets;
  final void Function(int) onItemTap;
  final void Function(int) onItemLikeStatusChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: markets.length,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return MarketsListItem(
          market: markets[index],
          onTap: () => onItemTap(index),
          onLikeStatusChanged: () => onItemLikeStatusChanged(index),
        );
      },
    );
  }
}
