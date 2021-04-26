import 'package:flutter/material.dart';

import '../../../data/models/customer/product_result_model.dart';
import 'product_vertical_list_item.dart';

class ProductVerticalList extends StatelessWidget {
  const ProductVerticalList({
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
    return ListView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        return ProductVerticalListItem(
          product: products[index],
          onTap: () => onItemTap(index),
          onAddToBasket: () => onItemAddToBasket(index),
          onRemoveFromBasket: () => onItemRemoveFromBasket(index),
        );
      },
    );
  }
}
