// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/page_routes/routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/widgets/carousel_image_slider.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/comments_result_model.dart';
import '../../../data/models/market_detail_result_model.dart';
import '../../../data/models/nearby_markets_result_model.dart';
import '../../../data/models/photos_result_model.dart';
import '../../../data/repositories/customer_market_repository.dart';
import '../../customer_widgets/category_list/category_list.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/market_list/markets_list_item.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../market_comments/market_comments_page.dart';

class MarketDetailPage extends StatelessWidget {
  static const route = "/customer_market_detail";

  MarketDetailPage({required this.marketId});

  final String marketId;

  final _customerMarketRepo = CustomerMarketRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات فروشگاه",
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: CustomFutureBuilder(
        future: _customerMarketRepo.marketDetail(
          marketId: marketId,
        ),
        successBuilder: (context, data) {
          var result = data as Either<Failure, MarketDetailResultModel>;

          return result.fold(
            (left) {
              return Txt(
                left.message,
                style: AppTxtStyles().body..alignment.center(),
              );
            },
            (right) => _listOfSections(right),
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
    var categories = marketDetail.data!.categories;

    var data = marketDetail.data;
    var market = Market(
      id: data!.id,
      name: data.name,
      phone: data.phone,
      address: data.address,
      location: data.location,
      score: data.score,
      distance: data.distance,
      deliveryCost: data.deliveryCost,
      clouseAt: data.clouseAt,
      openAt: data.openAt,
      situation: data.situation,
    );

    return SingleChildScrollView(
      // padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _sectionCarouselSlider(marketDetail),
          const SizedBox(height: 16),
          _sectionDetailsBox(market),
          _sectionCategories(categories!),
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
          return data!.fold(
            (l) => CarouselImageSlider(images: []),
            (r) => CarouselImageSlider(images: r.data.photos),
          );
        },
        errorBuilder: (context, data) {
          return CarouselImageSlider(images: []);
        },
      ),
    );
  }

  Widget _sectionDetailsBox(Market market) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: MarketsListItem(
        market: market,
        repository: _customerMarketRepo,
        onTap: () {},
      ),
    );
  }

  Widget _sectionCategories(List<Category> categories) {
    return CategoryList(
      categories: categories,
      marketId: marketId,
    );
  }

  Widget _sectionComments() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomFutureBuilder<Either<Failure, CommentsResultModel>>(
        future: _customerMarketRepo.marketComments(
          marketId: marketId,
          page: 1,
        ),
        successBuilder: (context, data) {
          return data!.fold(
            (left) => Txt(
              left.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (right) => CommentList(
              comments: right.data!.comments!,
              showAllCommentOnTap: () {
                Routes.sailor.navigate(
                  MarketCommentsPage.route,
                  params: {"marketId": marketId},
                );
              },
              enableHeader: right.data!.comments!.isNotEmpty,
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
