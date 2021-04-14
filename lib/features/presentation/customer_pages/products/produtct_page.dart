// ignore: import_of_legacy_library_into_null_safe
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/loading.dart';
import '../../customer_widgets/product_list/product_vertical_list_.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/products_notifier.dart';

class ProductsPage extends StatelessWidget {
  static const route = "/customer_products";

  ProductsPage({
    required this.marketId,
    required this.categoryId,
  });

  final String marketId;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<ProductsNotifier>(
      builder: (context, provider, child) {
        if (provider.products == null) {
          provider.fetchProducts(
            marketId: marketId,
            categoryId: categoryId,
          );
        }

        return provider.productsLoading
            ? AppLoading(color: AppTheme.customerPrimary)
            : provider.products == null
                ? provider.productsErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.productsErrorMsg!,
                        style: AppTxtStyles().body..alignment.center())
                : SingleChildScrollView(
                    child: ProductVerticalList(products: provider.products!),
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "محصولات",
        showBackBtn: true,
      ),
      body: consumer,
    );
  }
}
