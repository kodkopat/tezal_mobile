import 'package:flutter/material.dart';

import '../../../data/models/product_result_model.dart';
import 'product_horizontal_list_item.dart';

class ProductHorizontalList extends StatelessWidget {
  const ProductHorizontalList({
    required this.products,
    required this.onItemTap,
  });

  final List<ProductResultModel> products;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 236,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(8, 4, 8, 16),
        itemBuilder: (context, index) {
          return ProductHorizontalListItem(
            product: products[index],
            onTap: () => onItemTap(index),
          );
        },
      ),
    );
  }
}
