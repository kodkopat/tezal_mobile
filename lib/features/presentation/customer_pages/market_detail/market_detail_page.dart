import 'package:dartz/dartz.dart';
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/image_view.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/simple_app_bar.dart';
import '../../../data/models/market_comments_result_model.dart';
import '../../../data/models/market_detail_result_model.dart';
import '../../../data/models/nearby_markets_result_model.dart';
import '../../../data/models/photos_result_model.dart';

import '../../../data/repositories/customer_market_repository.dart';
import '../home/widgets/nearby_markets_list_item.dart';
import '../market_comments/widgets/market_comment_list.dart';
import 'widgets/market_detail_category_list.dart';

class MarketDetailPage extends StatelessWidget {
  static const route = "/customer_market_detail";

  MarketDetailPage({
    Key key,
    @required this.marketId,
  }) : super(key: key);

  final String marketId;

  final _customerMarketRepo = CustomerMarketRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar.intance(
        text: "جزئیات فروشگاه",
        showBackBtn: true,
      ),
      body: CustomFutureBuilder(
        future: _customerMarketRepo.marketDetail(
          marketId: marketId,
        ),
        successBuilder: (context, data) {
          var result = data as Either<Failure, MarketDetailResultModel>;

          return result.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) => _listOfSections(r),
          );
        },
        errorBuilder: (context, error) {
          return AppLoading(
            color: AppTheme.customerPrimary,
          );
        },
      ),
    );
  }

  Widget _listOfSections(MarketDetailResultModel marketDetail) {
    var categories = marketDetail.data.categories;

    var data = marketDetail.data;
    var market = Market(
      id: data.id,
      name: data.name,
      phone: data.phone,
      address: data.address,
      location: data.location,
      score: data.score,
      distance: data.distance,
      deliveryCost: data.deliveryCost,
      basketCount: data.basketCount,
    );

    return SingleChildScrollView(
      // padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _sectionCarouselSlider(marketDetail),
          const SizedBox(height: 16),
          _sectionDetailsBox(market),
          const SizedBox(height: 16),
          _sectionCategories(categories),
          const SizedBox(height: 16),
          _sectionComments(),
        ],
      ),
    );
  }

  Widget _sectionCarouselSlider(MarketDetailResultModel marketDetail) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
        future: _customerMarketRepo.photo(marketId: marketId),
        successBuilder: (context, data) {
          return data.fold(
            (l) => ProductImageView(images: ["", ""]),
            (r) => ProductImageView(images: r.data.photos),
          );
        },
        errorBuilder: (context, data) {
          return ProductImageView(images: ["", ""]);
        },
      ),
    );
  }

  Widget _sectionDetailsBox(Market market) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: NearByMarketsListItem(
        market: market,
        repository: _customerMarketRepo,
        onTap: () {},
      ),
    );
  }

  Widget _sectionCategories(List<Category> categories) {
    return MarketDetailCategoryList(categories: categories);
  }

  Widget _sectionComments() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomFutureBuilder<Either<Failure, MarketCommentsResultModel>>(
        future: _customerMarketRepo.marketComments(
          marketId: marketId,
          // orderBy: "",
          page: 1,
          // pageSize: 3,
        ),
        successBuilder: (context, data) {
          return data.fold(
            (l) => Txt(
              l.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (r) => MarketCommentList(
              marketId: marketId,
              marketComments: r,
              enableLoadMore: true,
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
