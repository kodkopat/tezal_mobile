// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/customer/sub_category_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/category_notifier.dart';
import '../products/produtct_page.dart';
import 'widgets/market_sub_category_list.dart';

class MarketSubCategoryPage extends StatelessWidget {
  static const route = "customer_market_sub_category";

  MarketSubCategoryPage({
    required this.marketId,
    required this.mainCategoryId,
  });

  final String marketId;
  final String mainCategoryId;

  @override
  Widget build(BuildContext context) {
    var categoryNotifier =
        Provider.of<CategoryNotifier>(context, listen: false);

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات فروشگاه",
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: CustomFutureBuilder(
        future: categoryNotifier.customerCategoryRepo.getSubCategories(
          marketId: marketId,
          mainCategoryId: mainCategoryId,
        ),
        successBuilder: (context, data) {
          var result = data as Either<Failure, SubCategoryResultModel>;

          return result.fold(
            (left) => Txt(
              left.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (right) => MarketSubCategoryList(
              categoryNotifier: categoryNotifier,
              subCategories: right.data!,
              onItemTap: (index) {
                Routes.sailor.navigate(
                  ProductsPage.route,
                  params: {
                    "marketId": marketId,
                    "categoryId": right.data![index].id,
                  },
                );
              },
            ),
          );
        },
        errorBuilder: (context, error) {
          return AppLoading();
        },
      ),
    );
  }
}
