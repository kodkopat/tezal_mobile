import 'package:dartz/dartz.dart' hide State;
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../data/models/nearby_markets_result_model.dart';
import '../../data/repositories/customer_market_repository.dart';
import '../widgets/nearby_markets_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CustomerMarketRepository repository;

  @override
  void initState() {
    super.initState();
    repository = CustomerMarketRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: SimpleAppBar.intance(text: "خانه"),
        body: CustomFutureBuilder(
          future: repository.getNearByMarkets(
            context,
            maxDistance: 50,
            count: 10,
          ),
          successBuilder: (context, data) {
            var result = data as Either<Failure, NearByMarketsResultModel>;

            return result.fold(
              (l) => Txt(
                l.message,
                style: AppTxtStyles().body..alignment.center(),
              ),
              (r) => NearByMarketsList(model: r),
            );
          },
          errorBuilder: (context, error) {
            return AppLoading(color: AppTheme.customerPrimary);
          },
        ),
      ),
    );
  }
}
