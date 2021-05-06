// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../data/models/market/product_result_model.dart';
import '../../../market_widgets/product_list/product_list.dart';
import '../../../providers/market_providers/sub_category_notifier.dart';

class SubCategoryView extends StatelessWidget {
  SubCategoryView({
    required this.mainCategoryId,
    required this.subCategoryId,
  });

  final String mainCategoryId;
  final String subCategoryId;

  @override
  Widget build(BuildContext context) {
    return Consumer<SubCategoryNotifier>(
      builder: (context, provider, child) {
        if (provider.marketProductsResult == null) {
          provider.fetchMarketProducts(
            mainCategoryId: mainCategoryId,
            subCategoryId: subCategoryId,
          );
        }

        return provider.marketProductsLoading
            ? Center(child: AppLoading())
            : provider.marketProductsResult == null
                ? provider.marketProductsErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt("${provider.marketProductsErrorMsg}",
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    child: ProductList(
                      products: provider.marketProductsResult!.data!
                          .map(
                            (e) => ProductResultModel(
                              id: e.productId,
                              name: e.productName,
                              createDate: e.productCreateDate,
                              description: e.productDescription,
                              discountedPrice: e.productDiscountedPrice,
                              onSale: e.productOnSale,
                              originalPrice: e.productOriginalPrice,
                              productUnit: e.productUnit,
                              step: e.productStep,
                            ),
                          )
                          .toList(),
                      onItemTap: (index) {},
                    ),
                  );
      },
    );
  }
}
