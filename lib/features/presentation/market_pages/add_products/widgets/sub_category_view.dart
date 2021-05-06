// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/loading.dart';
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
        if (provider.notListedProductsResult == null) {
          provider.fetchNotListedProducts(
            mainCategoryId: mainCategoryId,
            subCategoryId: subCategoryId,
          );
        }

        return provider.notListedProductsLoading
            ? Center(child: AppLoading())
            : provider.notListedProductsResult == null
                ? provider.notListedProductsErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt("${provider.notListedProductsErrorMsg}",
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    child: ProductList(
                      products: provider.notListedProductsResult!.data!,
                      onItemTap: (index) {},
                      showItemsAction: true,
                    ),
                  );
      },
    );
  }
}
