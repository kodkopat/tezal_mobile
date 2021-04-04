import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/liked_products_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';
import '../../customer_widgets/simple_app_bar.dart';
import 'widgets/liked_product_list.dart';

class LikedProductsPage extends StatelessWidget {
  static const route = "/customer_liked_products";

  LikedProductsPage({Key key}) : super(key: key);

  final _customerProductRepo = CustomerProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar().create(
        context,
        text: "محصولات مورد علاقه",
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: CustomFutureBuilder<Either<Failure, LikedProductsResultModel>>(
        future: _customerProductRepo.likedProdutcs(),
        successBuilder: (context, data) {
          return data.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) => LikedProductList(likedProducts: r.data),
          );
        },
        errorBuilder: (context, data) {
          return AppLoading(color: AppTheme.customerPrimary);
        },
      ),
    );
  }
}
