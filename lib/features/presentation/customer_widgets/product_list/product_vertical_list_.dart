import 'package:flutter/material.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../data/models/product_result_model.dart';
import '../../customer_pages/product_detail/product_detail_page.dart';
import 'product_vertical_list_item.dart';

class ProductVerticalList extends StatelessWidget {
  const ProductVerticalList({required this.products});

  final List<ProductResultModel> products;

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
          onTap: () {
            Routes.sailor.navigate(
              ProductDetailPage.route,
              params: {"productId": products[index].id},
            );
          },
        );
      },
    );
  }
}
