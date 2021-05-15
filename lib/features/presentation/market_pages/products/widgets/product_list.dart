import 'package:flutter/material.dart';

import '../../../../data/models/market/product_result_model.dart';
import 'product_list_item.dart';

class ProductList extends StatelessWidget {
  ProductList({
    required this.products,
    required this.onItemTap,
    required this.onItemRemoveBtnTap,
  });

  final List<ProductResultModel> products;
  final void Function(int) onItemTap;
  final void Function(int) onItemRemoveBtnTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ProductListItem(
          product: products[index],
          onTap: () => onItemTap(index),
          onRemoveBtnTap: () => onItemRemoveBtnTap(index),
        );
      },
    );
  }
}
