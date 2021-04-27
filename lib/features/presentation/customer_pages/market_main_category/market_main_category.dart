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
import '../../../data/models/customer/main_category_result_model.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../../providers/customer_providers/category_notifier.dart';
import '../market_sub_category/market_sub_category.dart';
import 'widgets/market_main_category_list.dart';

class MarketMainCategoryPage extends StatelessWidget {
  static const route = "customer_market_main_category";

  MarketMainCategoryPage({required this.marketId});

  final String marketId;

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
        future: categoryNotifier.customerCategoryRepo.mainCategories(
          marketId: marketId,
        ),
        successBuilder: (context, data) {
          var result = data as Either<Failure, MainCategoryResultModel>;

          return result.fold(
            (left) => Txt(
              left.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (right) => MarketMainCategoryList(
              categoryNotifier: categoryNotifier,
              mainCategories: right.data!,
              onItemTap: (index) {
                Routes.sailor.navigate(
                  MarketSubCategoryPage.route,
                  params: {
                    "marketId": marketId,
                    "mainCategoryId": right.data![index].id,
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
