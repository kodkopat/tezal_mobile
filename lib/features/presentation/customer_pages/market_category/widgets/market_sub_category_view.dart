// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../../core/exceptions/failure.dart';
import '../../../../../core/page_routes/routes.dart';
import '../../../../../core/styles/txt_styles.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/custom_future_builder.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../data/models/products_result_model.dart';
import '../../../../data/repositories/customer_product_repository.dart';
import '../../../customer_widgets/product_list/product_vertical_list_.dart';
import '../../product_detail/product_detail_page.dart';

class MarketSubCategoryView extends StatelessWidget {
  MarketSubCategoryView({
    required this.marketId,
    required this.subCategoryId,
  });

  final String marketId;
  final String subCategoryId;

  @override
  Widget build(BuildContext context) {
    var customerProductRep = CustomerProductRepository();

    return CustomFutureBuilder(
      future: customerProductRep.productList(
        marketId: marketId,
        categoryId: subCategoryId,
      ),
      successBuilder: (context, data) {
        var result = data as Either<Failure, ProductsResultModel>;

        return result.fold(
          (left) => Txt(
            left.message,
            style: AppTxtStyles().body..alignment.center(),
          ),
          (right) => SingleChildScrollView(
            child: ProductVerticalList(
              products: right.data!,
              onItemTap: (index) {
                Routes.sailor.navigate(
                  ProductDetailPage.route,
                  params: {
                    "productId": right.data![index].id,
                  },
                );
              },
            ),
          ),
        );
      },
      errorBuilder: (context, error) {
        return AppLoading(
          color: AppTheme.customerPrimary,
        );
      },
    );
  }
}
