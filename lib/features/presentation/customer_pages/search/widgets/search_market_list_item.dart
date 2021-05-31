// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/customer/search_result_model.dart';
import '../../../customer_providers/basket_notifier.dart';
import '../../../customer_providers/search_notifier.dart';
import '../../../customer_widgets/product_list/product_horizontal_list.dart';
import '../../market_detail/market_detail_page.dart';
import '../../product_detail/product_detail_page.dart';

class SearchMarketListItem extends StatelessWidget {
  SearchMarketListItem({required this.market});

  final Market market;

  @override
  Widget build(BuildContext context) {
    var customerSearchNotifier = Get.find<CustomerSearchNotifier>();
    var basketNotifier = Get.find<BasketNotifier>();
    var products = market.products;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header,
        ProductHorizontalList(
          products: products,
          onItemTap: (index) {
            var product = products[index];
            Routes.sailor.navigate(
              ProductDetailPage.route,
              params: {"productId": product.id},
            );
          },
          onItemAddToBasket: (index) {
            var product = products[index];
            basketNotifier.addToBasket(productId: product.id);
            customerSearchNotifier.refresh(context);
          },
          onItemRemoveFromBasket: (index) {
            var product = products[index];
            basketNotifier.removeFromBasket(productId: product.id);
            customerSearchNotifier.refresh(context);
          },
        ),
      ],
    );
  }

  Widget get _header => Padding(
        padding: EdgeInsets.fromLTRB(8, 16, 20, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Txt(
              "${market.name}",
              style: AppTxtStyles().body..bold(),
            ),
            Txt(
              "جزئیات فروشگاه \u00BB",
              gesture: Gestures()
                ..onTap(() {
                  Routes.sailor.navigate(
                    MarketDetailPage.route,
                    params: {"marketId": market.id},
                  );
                }),
              style: AppTxtStyles().footNote
                ..borderRadius(all: 4)
                ..margin(top: 2)
                ..padding(horizontal: 4, vertical: 2)
                ..ripple(true),
            ),
          ],
        ),
      );
}
