import 'package:flutter/material.dart';

import '../../../../data/models/market/product_result_model.dart';
import 'product_list_item.dart';

class AddProductList extends StatelessWidget {
  AddProductList({
    required this.products,
    required this.onItemTap,
    required this.onItemAddBtnTap,
  });

  final List<ProductResultModel> products;
  final void Function(int) onItemTap;
  final void Function(int) onItemAddBtnTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return AddProductListItem(
          product: products[index],
          onTap: () => onItemTap(index),
          onAddBtnTap: () => onItemAddBtnTap(index),
        );
      },
    );
  }
}
