import 'package:flutter/material.dart';

import '../../../../data/models/search_result_model.dart';
import 'search_market_product_list_item.dart';

class SearchMarketProductList extends StatelessWidget {
  const SearchMarketProductList({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 248,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(8, 4, 8, 16),
        itemBuilder: (context, index) {
          return SearchMarketProductListItem(
            product: products[index],
            onTap: () {},
          );
        },
      ),
    );
  }
}
