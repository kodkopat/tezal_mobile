import 'package:flutter/material.dart';

import '../../../../data/models/market_detail_result_model.dart';
import 'market_detail_product_list_item.dart';

class MarketDetailProductList extends StatelessWidget {
  const MarketDetailProductList({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(8, 4, 8, 16),
        itemBuilder: (context, index) {
          return MarketDetailProductListItem(
            product: products[index],
            onTap: () {},
          );
        },
      ),
    );
  }
}
