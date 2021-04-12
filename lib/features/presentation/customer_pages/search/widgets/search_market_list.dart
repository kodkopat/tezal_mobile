import 'package:flutter/material.dart';

import '../../../../data/models/search_result_model.dart';
import 'search_market_list_item.dart';

class SearchMarketList extends StatelessWidget {
  const SearchMarketList({required this.markets});

  final List<Market> markets;

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
        );
      },
    );
  }
}
