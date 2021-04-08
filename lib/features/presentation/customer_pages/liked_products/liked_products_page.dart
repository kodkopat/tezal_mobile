import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/product_notifier.dart';
import 'widgets/liked_product_list.dart';

class LikedProductsPage extends StatelessWidget {
  static const route = "/customer_liked_products";

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<ProductNotifier>(
      builder: (context, provider, child) {
        if (provider.likedProductsResultModel == null &&
            provider.likedProductsErrorMsg == null) {
          provider.fetchLikedProducts();
        }

        return provider.likedProductsloading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.likedProductsErrorMsg != null
                ? Txt(
                    provider.likedProductsErrorMsg,
                    style: AppTxtStyles().body..alignment.center(),
                  )
                : provider.likedProductsResultModel.data.isEmpty
                    ? Txt(
                        "لیست محصولات مورد علاقه خالی است",
                        style: AppTxtStyles().body..alignment.center(),
                      )
                    : LikedProductList(
                        likedProducts: provider.likedProductsResultModel.data,
                        productNotifier: provider,
                      );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "محصولات مورد علاقه",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
