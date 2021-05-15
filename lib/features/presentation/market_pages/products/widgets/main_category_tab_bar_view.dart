// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../data/repositories/market_product_repository.dart';
import '../../../providers/market_providers/products_notifier.dart';
import '../../../providers/market_providers/sub_category_notifier.dart';
import 'sub_category_list.dart';
import 'sub_category_view.dart';

class MainCategoryTabBarView extends StatelessWidget {
  MainCategoryTabBarView({required this.mainCategoryId});

  final String mainCategoryId;

  @override
  Widget build(BuildContext context) {
    return Consumer<SubCategoryNotifier>(
      builder: (context, provider, child) {
        if (provider.subCategories == null) {
          provider.fetchSubCategories(mainCategoryId: mainCategoryId);
        }

        return provider.subCategoriesLoading
            ? Center(child: AppLoading())
            : provider.subCategories == null
                ? provider.subCategoriesErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt("${provider.subCategoriesErrorMsg}",
                        style: AppTxtStyles().body..alignment.center())
                : Column(
                    children: [
                      SubCategoryList(
                        textList: provider.subCategoryNameList,
                        selectedIndex: provider.subCategoryListSelectedIndex,
                        onItemTap: (index) {
                          provider.refreshSubCategoryListSelectedIndex(index);
                          provider.refreshProducts();

                          print(
                            "selected sub category id: "
                            "${provider.subCategoryIdList[index]}\n",
                          );
                        },
                      ),
                      if (provider.subCategoryIdList.isNotEmpty)
                        Expanded(
                          child: MultiProvider(
                            providers: [
                              ChangeNotifierProvider(
                                create: (ctx) => provider,
                              ),
                              ChangeNotifierProvider(
                                create: (ctx) => ProductsNotifier(
                                  MarketProductRepository(),
                                ),
                              ),
                            ],
                            child: SubCategoryView(
                              mainCategoryId: mainCategoryId,
                              subCategoryId: provider.subCategoryIdList[
                                  provider.subCategoryListSelectedIndex],
                            ),
                          ),
                        ),
                    ],
                  );
      },
    );
  }
}
