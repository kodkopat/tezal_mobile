import 'package:flutter/material.dart';

import '../../../../core/page_routes/routes.dart';
import '../../../data/models/product_result_model.dart';
import '../../customer_pages/product_detail/product_detail_page.dart';
import 'product_list_item.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<ProdutcResultModel> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(8, 4, 8, 16),
        itemBuilder: (context, index) {
          return ProductListItem(
            product: products[index],
            onTap: () {
              Routes.sailor.navigate(
                ProductDetailPage.route,
                params: {"productId": products[index].id},
              );
            },
          );
        },
      ),
    );
  }
}
