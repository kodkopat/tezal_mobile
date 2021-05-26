// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../core/page_routes/base_routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../market_providers/sub_category_notifier.dart';
import '../../add_product/add_product_page.dart';
import '../../add_product_draft/add_product_draft_page.dart';
import '../../product_detail/product_detail_page.dart';
import 'product_list.dart';

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
                          onAddBtnTap: (index) {
                            var mainCategoryName =
                                Get.find<String>(tag: "$mainCategoryId");
                            var subCategoryName =
                                Get.find<String>(tag: "$subCategoryId");

                            print("mainCategoryName: $mainCategoryName\n");
                            print("subCategoryName: $subCategoryName\n");

                            Routes.sailor.navigate(
                              AddProductDraftPage.route,
                              params: {
                                "mainCategoryId": mainCategoryId,
                                "mainCategoryName": mainCategoryName,
                                "subCategoryId": subCategoryId,
                                "subCategoryName": subCategoryName,
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
