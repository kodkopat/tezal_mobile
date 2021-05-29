// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/languages/language.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_providers/liked_product_notifier.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/liked_product_list.dart';

class LikedProductsPage extends StatelessWidget {
  static const route = "/customer_liked_products";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<LikedProductNotifier>(
      builder: (context, provider, child) {
        if (provider.likedProductsResultModel == null &&
            provider.likedProductsErrorMsg == null) {
          print("fetchLikedProducts\n");
          provider.fetchLikedProducts();
        }

        return provider.likedProductsLoading
            ? AppLoading()
            : provider.likedProductsErrorMsg != null
                ? Txt(
                    provider.likedProductsErrorMsg!,
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : provider.likedProductsResultModel!.data.isEmpty
                    ? Txt(
                        "لیست محصولات مورد علاقه خالی است",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                    : LikedProductList(
                        likedProducts: provider.likedProductsResultModel!.data,
                        productNotifier: provider,
                      );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: Lang.of(context).likedProductsPage,
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
