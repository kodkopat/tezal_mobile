// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/page_routes/base_routes.dart';
import '../../../../core/styles/txt_styles.dart';
import '../../../../core/widgets/custom_future_builder.dart';
import '../../../../core/widgets/loading.dart';
import '../../../data/models/customer/comments_result_model.dart';
import '../../../data/models/customer/market_detail_result_model.dart';
import '../../../data/models/customer/nearby_markets_result_model.dart';
import '../../../data/models/customer/photos_result_model.dart';
import '../../../data/repositories/customer_market_repository.dart';
import '../../customer_pages/home/widgets/markets_list_item.dart';
import '../../customer_providers/market_detail_notifier.dart';
import '../../customer_widgets/category_list/category_list.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../market_comments/market_comments_page.dart';
import 'widgets/market_slider.dart';

class MarketDetailPage extends StatelessWidget {
  static const route = "/customer_market_detail";

  MarketDetailPage({required this.marketId});

  final String marketId;

  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<MarketDetailNotifier>(
      builder: (context, provider, child) {
        Get.put<MarketDetailNotifier>(provider);

        if (provider.marketDetail == null) {
          provider.fetchMarketDetail(marketId: marketId);
        }

        return provider.marketDetailLoading
            ? AppLoading()
            : provider.marketDetail == null
                ? provider.marketDetailErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.marketDetailErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : _listOfSections(
                    context,
                    provider.marketDetail!,
                    provider,
                  );
      },
    );

    return Scaffold(
      appBar: SimpleAppBar(context).create(
        text: "جزئیات فروشگاه",
        showBackBtn: true,
        showBasketBtn: true,
      ),
      body: consumer,
    );
  }

  Widget _listOfSections(
    BuildContext context,
    MarketDetailResultModel marketDetail,
    MarketDetailNotifier notifier,
  ) {
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
      isLiked: data.liked,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _sectionCarouselSlider(marketDetail),
          const SizedBox(height: 16),
          _sectionDetailsBox(market, notifier),
          _sectionCategories(categories!, notifier),
          _sectionComments(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _sectionCarouselSlider(MarketDetailResultModel marketDetail) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomFutureBuilder<Either<Failure, PhotosResultModel>>(
        future:
            Get.find<CustomerMarketRepository>().getPhotos(marketId: marketId),
        successBuilder: (context, data) {
          return data!.fold(
            (left) => MarketSlider(images: []),
            (right) {
              // spl stands for, splited market location
              List<String> spl = "${marketDetail.data!.location}".split("-");
              var latitude = spl[0];
              var longitude = spl[1];

              return MarketSlider(
                images: right.data!.photos,
                marketLatitude: double.parse(latitude),
                marketLongitude: double.parse(longitude),
              );
            },
          );
        },
        errorBuilder: (context, data) {
          return MarketSlider(images: []);
        },
      ),
    );
  }

  Widget _sectionDetailsBox(Market market, MarketDetailNotifier notifier) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: MarketsListItem(
        market: market,
        onTap: () {},
        onLikeStatusChanged: () {
          notifier.like(marketId: market.id);
        },
      ),
    );
  }

  Widget _sectionCategories(
    List<Category> categories,
    MarketDetailNotifier marketDetailNotifier,
  ) {
    return CategoryList(
      marketId: marketId,
      categories: categories,
      marketDetailNotifier: marketDetailNotifier,
    );
  }

  Widget _sectionComments(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomFutureBuilder<Either<Failure, CommentsResultModel>>(
        future: Get.find<CustomerMarketRepository>().getComments(
          marketId: marketId,
          skip: 0,
          take: 3,
        ),
        successBuilder: (context, data) {
          return data!.fold(
            (left) => Txt(
              left.message,
              style: AppTxtStyles().body..alignment.center(),
            ),
            (right) => CommentList(
              comments: right.data!.comments!,
              enableHeader: right.data!.comments!.isNotEmpty,
              showAllCommentOnTap: () {
                Routes.sailor.navigate(
                  MarketCommentsPage.route,
                  params: {"marketId": marketId},
                );
              },
            ),
          );
        },
        errorBuilder: (context, data) {
          return AppLoading();
        },
      ),
    );
  }
}
