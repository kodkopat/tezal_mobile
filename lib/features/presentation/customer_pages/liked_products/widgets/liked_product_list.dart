import 'package:flutter/material.dart';

import '../../../../../core/page_routes/routes.dart';
import '../../../../data/models/liked_products_result_model.dart';
import '../../../providers/customer_providers/product_notifier.dart';
import '../../product_detail/product_detail_page.dart';
import 'liked_product_list_item.dart';

class LikedProductList extends StatelessWidget {
  const LikedProductList({
    @required this.likedProducts,
    @required this.productNotifier,
  });

  final List<LikedProduct> likedProducts;
  final ProductNotifier productNotifier;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: likedProducts.length,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return LikedProductListItem(
          likedProduct: likedProducts[index],
          onTap: () {
            Routes.sailor.navigate(
              ProductDetailPage.route,
              params: {"productId": likedProducts[index].id},
            );
          },
          productNotifier: productNotifier,
        );
      },
    );
  }
}
