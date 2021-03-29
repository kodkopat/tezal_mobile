import 'package:dartz/dartz.dart' hide State;
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/basket_result_model.dart';
import '../../../data/repositories/customer_basket_repository.dart';
import 'widgets/basket_list.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final customerBasketRepo = CustomerBasketRepository();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "سبد خرید"),
        body: CustomFutureBuilder<Either<Failure, BasketResultModel>>(
          future: customerBasketRepo.basket,
          successBuilder: (context, data) {
            return data.fold(
              (l) => Txt(
                l.message,
                style: AppTxtStyles().body..alignment.center(),
              ),
              (r) => BasketList(basketItems: r.data.items),
            );
          },
          errorBuilder: (context, data) {
            return AppLoading(color: AppTheme.customerPrimary);
          },
        ),
      ),
    );
  }
}
