import 'package:flutter/material.dart';

import '../../../../data/models/search_result_model.dart';
import '../../../providers/customer_providers/basket_notifier.dart';
import 'search_market_list_item.dart';

class SearchMarketList extends StatelessWidget {
  SearchMarketList({
    required this.markets,
    required this.basketNotifier,
  });

  final List<Market> markets;
  final BasketNotifier basketNotifier;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: markets.length,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return SearchMarketListItem(
          market: markets[index],
          basketNotifier: basketNotifier,
        );
      },
    );
  }
}
