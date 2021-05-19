// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../providers/market_providers/sub_category_notifier.dart';
import '../../add_product/add_product_page.dart';
import '../../product_detail/product_detail_page.dart';
import 'product_list.dart';
import 'search_box.dart';

class SubCategoryView extends StatelessWidget {
  SubCategoryView({
    required this.mainCategoryId,
    required this.subCategoryId,
  });

  final String mainCategoryId;
  final String subCategoryId;

  final searchCtrl = TextEditingController();

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
                    child: Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: SearchBox(
                            controller: searchCtrl,
                            onSearchTap: () {
                              provider.fetchNotListedProducts(
                                mainCategoryId: mainCategoryId,
                                subCategoryId: subCategoryId,
                                term: searchCtrl.text.trim(),
                              );
                            },
                          ),
                        ),
                        AddProductList(
                          products: provider.notListedProductsResult!.data!,
                          onItemTap: (index) {
                            Routes.sailor.navigate(
                              ProductDetailPage.route,
                              params: {
                                "product": provider
                                    .notListedProductsResult!.data![index]
                              },
                            );
                          },
                          onItemEditTap: (index) {
                            Get.put<SubCategoryNotifier>(provider);

                            Routes.sailor.navigate(
                              AddProductPage.route,
                              params: {
                                "product": provider
                                    .notListedProductsResult!.data![index],
                                "isProductExist": false,
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
      },
    );
  }
}
