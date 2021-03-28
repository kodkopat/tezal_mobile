import 'package:dartz/dartz.dart' hide State;
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/market_comments_result_model.dart';

import '../../../data/repositories/customer_market_repository.dart';
import 'widgets/market_comment_list.dart';

class MarketCommentsPage extends StatefulWidget {
  static const route = "/customer_market_comments";

  MarketCommentsPage({
    Key key,
    @required this.marketId,
  }) : super(key: key);

  final String marketId;
  final _customerMarketRepo = CustomerMarketRepository();

  @override
  _MarketCommentsPageState createState() => _MarketCommentsPageState();
}

class _MarketCommentsPageState extends State<MarketCommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.intance(
        text: "نظرات کاربران",
        showBackBtn: true,
      ),
      body: CustomFutureBuilder<Either<Failure, MarketCommentsResultModel>>(
        future: widget._customerMarketRepo.marketComments(
          marketId: widget.marketId,
          // orderBy: "",
          page: 1,
          // pageSize: 10,
        ),
        successBuilder: (context, data) {
          return data.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) => SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: MarketCommentList(
                marketId: widget.marketId,
                marketComments: r,
                enableLoadMore: false,
              ),
            ),
          );
        },
        errorBuilder: (context, data) {
          return AppLoading(color: AppTheme.customerPrimary);
        },
      ),
    );
  }
}
