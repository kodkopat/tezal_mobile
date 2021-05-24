import 'package:flutter/material.dart';

import '../../../../data/models/market/product_result_model.dart';
import 'product_list_add.dart';
import 'product_list_item.dart';

class AddProductList extends StatelessWidget {
  AddProductList({
    required this.products,
    required this.onItemTap,
    required this.onItemEditTap,
    required this.onAddBtnTap,
  });

  final List<ProductResultModel> products;
  final void Function(int) onItemTap;
  final void Function(int) onItemEditTap;
  final void Function(int) onAddBtnTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: products.length + 1,
      padding: EdgeInsets.symmetric(horizontal: 8),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return (index != products.length)
            ? AddProductListItem(
                product: products[index],
                onTap: () => onItemTap(index),
                onEditTap: () => onItemEditTap(index),
              )
            : AddProductListItemAdd(
                onTap: () => onAddBtnTap(index),
              );
      },
    );
  }
}
