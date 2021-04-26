import 'package:flutter/material.dart';

import '../../../data/models/customer/product_result_model.dart';
import 'product_horizontal_list_item.dart';

class ProductHorizontalList extends StatelessWidget {
  const ProductHorizontalList({
    required this.products,
    required this.onItemTap,
    required this.onItemAddToBasket,
    required this.onItemRemoveFromBasket,
  });

  final List<ProductResultModel> products;
  final void Function(int) onItemTap;
  final void Function(int) onItemAddToBasket;
  final void Function(int) onItemRemoveFromBasket;

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
            onAddToBasket: () => onItemAddToBasket(index),
            onRemoveFromBasket: () => onItemRemoveFromBasket(index),
          );
        },
      ),
    );
  }
}
