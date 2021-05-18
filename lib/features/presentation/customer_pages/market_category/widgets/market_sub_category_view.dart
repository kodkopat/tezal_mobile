// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../data/models/customer/products_result_model.dart';
import '../../../../data/repositories/customer_product_repository.dart';
import '../../../customer_widgets/product_list/product_vertical_list_.dart';
import '../../../providers/customer_providers/basket_notifier.dart';
import '../../../providers/customer_providers/market_detail_provider.dart';
import '../../product_detail/product_detail_page.dart';

class MarketSubCategoryView extends StatelessWidget {
  MarketSubCategoryView({
    required this.marketId,
    required this.subCategoryId,
    required this.basketNotifier,
  });

  final String marketId;
  final String subCategoryId;
  final BasketNotifier basketNotifier;

  @override
  Widget build(BuildContext context) {
    var customerProductRep = CustomerProductRepository();

    return CustomFutureBuilder(
      future: customerProductRep.getProductsInSubCategory(
        marketId: marketId,
        categoryId: subCategoryId,
      ),
      successBuilder: (context, data) {
        var result = data as Either<Failure, ProductsResultModel>;

        return result.fold(
          (left) => Txt(
            left.message,
            style: AppTxtStyles().body..alignment.center(),
          ),
          (right) => SingleChildScrollView(
            child: ProductVerticalList(
              products: right.data!,
              onItemTap: (index) {
                var productId = right.data![index].id;
                var marketDetailNotifier = Get.find<MarketDetailNotifier>();

                Routes.sailor.navigate(
                  ProductDetailPage.route,
                  params: {
                    "productId": productId,
                    "onAddToBasket": () {
                      basketNotifier.addToBasket(productId: productId);
                      marketDetailNotifier.refresh();
                    },
                    "onRemoveFromBasket": () {
                      basketNotifier.removeFromBasket(productId: productId);
                      marketDetailNotifier.refresh();
                    },
                  },
                );
              },
              onItemAddToBasket: (index) {
                basketNotifier.addToBasket(
                  productId: right.data![index].id,
                );
                var marketDetailNotifier = Get.find<MarketDetailNotifier>();
                marketDetailNotifier.refresh();
              },
              onItemRemoveFromBasket: (index) {
                basketNotifier.removeFromBasket(
                  productId: right.data![index].id,
                );
                var marketDetailNotifier = Get.find<MarketDetailNotifier>();
                marketDetailNotifier.refresh();
              },
            ),
          ),
        );
      },
      errorBuilder: (context, error) {
        return AppLoading();
      },
    );
  }
}
