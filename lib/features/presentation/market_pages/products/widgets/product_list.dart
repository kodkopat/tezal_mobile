import 'package:flutter/material.dart';

import '../../../../data/models/market/product_result_model.dart';
import 'product_list_item.dart';

class ProductList extends StatelessWidget {
  ProductList({
    required this.products,
    required this.onItemTap,
    required this.onItemEditTap,
  });

  final List<ProductResultModel> products;
  final void Function(int) onItemTap;
  final void Function(int) onItemEditTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      padding: EdgeInsets.symmetric(horizontal: 8),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return ProductListItem(
          product: products[index],
          onTap: () => onItemTap(index),
          onEditTap: () => onItemEditTap(index),
        );
      },
    );
  }
}
