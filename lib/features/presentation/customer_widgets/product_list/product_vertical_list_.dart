import 'package:flutter/material.dart';

import '../../../data/models/product_result_model.dart';
import 'product_vertical_list_item.dart';

class ProductVerticalList extends StatelessWidget {
  const ProductVerticalList({
    required this.products,
    required this.onItemTap,
  });

  final List<ProductResultModel> products;
  final void Function(int) onItemTap;

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
        );
      },
    );
  }
}
