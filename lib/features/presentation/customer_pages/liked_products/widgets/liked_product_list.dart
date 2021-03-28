import 'package:flutter/material.dart';

import '../../../../data/models/liked_products_result_model.dart';
import 'liked_product_list_item.dart';

class LikedProductList extends StatelessWidget {
  const LikedProductList({
    Key key,
    @required this.likedProducts,
  }) : super(key: key);

  final List<LikedProduct> likedProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: likedProducts.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return LikedProductListItem(
          likedProduct: likedProducts[index],
        );
      },
    );
  }
}
