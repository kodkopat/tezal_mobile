// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../data/models/customer/market_detail_result_model.dart';
import '../../customer_pages/product_detail/product_detail_page.dart';
import '../../customer_providers/basket_notifier.dart';
import '../../customer_providers/market_detail_notifier.dart';
import '../product_list/product_horizontal_list.dart';

class CategoryListItem extends StatelessWidget {
  CategoryListItem({
    required this.category,
    required this.onCategoryTap,
    required this.marketDetailNotifier,
  });

  final Category category;
  final VoidCallback onCategoryTap;
  final MarketDetailNotifier marketDetailNotifier;

  @override
  Widget build(BuildContext context) {
    var basketNotifier = Get.find<BasketNotifier>();
    var products = category.products!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header,
        ProductHorizontalList(
          products: products,
          onItemTap: (index) {
            var productId = products[index].id;
            Routes.sailor.navigate(
              ProductDetailPage.route,
              params: {
                "productId": productId,
                "marketDetailNotifier": marketDetailNotifier,
              },
            );
          },
          onItemAddToBasket: (index) {
            var productId = products[index].id;
            basketNotifier.addToBasket(productId: productId);
          },
          onItemRemoveFromBasket: (index) {
            var productId = products[index].id;
            basketNotifier.removeFromBasket(productId: productId);
          },
        ),
      ],
    );
  }

  Widget get _header => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(
            "${category.name}",
            gesture: Gestures()..onTap(onCategoryTap),
            style: AppTxtStyles().body
              ..margin(right: 20, top: 16, bottom: 8)
              ..padding(all: 4)
              ..borderRadius(all: 4)
              ..ripple(true)
              ..bold(),
          ),
          Txt(
            "جزئیات دسته‌بندی \u00BB",
            gesture: Gestures()..onTap(onCategoryTap),
            style: AppTxtStyles().footNote
              ..margin(left: 16, top: 18, bottom: 8)
              ..padding(all: 4)
              ..borderRadius(all: 4)
              ..ripple(true),
          ),
        ],
      );
}
