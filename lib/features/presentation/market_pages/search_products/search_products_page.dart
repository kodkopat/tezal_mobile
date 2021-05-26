// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../market_providers/search_notifier.dart';
import '../add_product/add_product_page.dart';
import '../product_detail/product_detail_page.dart';
import 'widgets/search_box.dart';
import 'widgets/search_product_list.dart';

class SearchProductsPage extends StatelessWidget {
  static const route = "/market_search_products";

  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var searchProvider = Provider.of<SearchNotifier>(context, listen: false);
    var searchConsumer = Consumer<SearchNotifier>(
      builder: (context, provider, child) {
        return provider.searchResult == null
            ? provider.errorMsg == null
                ? Txt(
                    "نام محصول مورد نظر خود را جستجو کنید",
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : Txt(
                    provider.errorMsg,
                    style: AppTxtStyles().body..alignment.center(),
                  )
            : Expanded(
                child: SingleChildScrollView(
                  child: SearchProductList(
                    products: provider.searchResult!.data!,
                    onItemTap: (index) {
                      Routes.sailor.navigate(
                        ProductDetailPage.route,
                        params: {
                          "product": provider.searchResult!.data![index]
                        },
                      );
                    },
                    onItemEditTap: (index) {
                      Routes.sailor.navigate(
                        AddProductPage.route,
                        params: {
                          "product": provider.searchResult!.data![index],
                          "isProductExist": false,
                        },
                      );
                    },
                  ),
                ),
              );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جستجوی محصولات",
        showBackBtn: true,
      ),
      body: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: SearchBox(
              controller: searchCtrl,
              onSearchTap: () {
                searchProvider.fetchNotListedProducts(
                  context,
                  term: searchCtrl.text.trim(),
                );
              },
            ),
          ),
          searchConsumer,
        ],
      ),
    );
  }
}
