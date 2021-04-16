// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/styles/txt_styles.dart';
import '../../../../data/models/product_result_model.dart';
import '../../../customer_widgets/product_list/product_vertical_list_.dart';
import 'market_sub_category_list.dart';

class MarketMainCategoryTabBarView extends StatefulWidget {
  MarketMainCategoryTabBarView({required this.products});

  final List<ProductResultModel> products;

  @override
  _MarketMainCategoryTabBarViewState createState() =>
      _MarketMainCategoryTabBarViewState();
}

class _MarketMainCategoryTabBarViewState
    extends State<MarketMainCategoryTabBarView> {
  bool loading = true;

  List<String> subCategoryNameList = [];
  List<String> subCategoryIdList = [];
  int subCategoryListSelectedIndex = 0;
  List<ProductResultModel> subCategoryProducts = [];

  void initializeState() async {
    widget.products.forEach((product) {
      subCategoryIdList.add(product.subCategoryId);
      subCategoryNameList.add(product.subCategoryName);

      if (product.subCategoryId == widget.products[0].subCategoryId) {
        subCategoryProducts.add(product);
      }
    });

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Txt("انتظار", style: AppTxtStyles().footNote)
        : Column(
            children: [
              MarketSubCategoryList(
                textList: subCategoryNameList,
                selectedIndex: subCategoryListSelectedIndex,
                onItemTap: (index) {
                  setState(() {
                    subCategoryListSelectedIndex = index;
                  });
                  print(
                    "selected sub category id: "
                    "${subCategoryIdList[index]}\n",
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ProductVerticalList(
                    products: subCategoryProducts,
                  ),
                ),
              ),
            ],
          );
  }
}
