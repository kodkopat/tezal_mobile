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
import '../../customer_pages/home/widgets/markets_list_item.dart';
import '../../customer_providers/basket_notifier.dart';
import '../../customer_providers/market_comments_notifier.dart';
import '../../customer_providers/market_detail_provider.dart';
import '../../customer_widgets/category_list/category_list.dart';
import '../../customer_widgets/comment_list/comment_list.dart';
import '../../customer_widgets/simple_app_bar.dart';
import '../market_comments/market_comments_page.dart';
import 'widgets/market_slider.dart';

class MarketDetailPage extends StatelessWidget {
  static const route = "/customer_market_detail";

  MarketDetailPage({required this.marketId});

  final String marketId;
  late final MarketCommentsNotifier marketCommentsNotifier;
  late final MarketDetailNotifier marketDetailNotifier;
  late final BasketNotifier basketNotifier;

  @override
  Widget build(BuildContext context) {
    marketCommentsNotifier =
        Provider.of<MarketCommentsNotifier>(context, listen: false);
    Get.put<MarketCommentsNotifier>(marketCommentsNotifier);

    marketDetailNotifier =
        Provider.of<MarketDetailNotifier>(context, listen: false);
    Get.put<MarketDetailNotifier>(marketDetailNotifier);

    var consumer = Consumer<MarketDetailNotifier>(
      builder: (context, provider, child) {
        if (provider.marketDetail == null) {
          provider.fetchMarketDetail(marketId: marketId);
          Get.put<MarketDetailNotifier>(provider);
        }

        return provider.marketDetailLoading
            ? AppLoading()
            : provider.marketDetail == null
                ? provider.marketDetailErrorMsg == null
                    ? Txt("خطای بارگذاری اطلاعات",
                        style: AppTxtStyles().body..alignment.center())
                    : Txt(provider.marketDetailErrorMsg,
                        style: AppTxtStyles().body..alignment.center())
                : _listOfSections(context, provider.marketDetail!);
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
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          _sectionCarouselSlider(marketDetail),
          const SizedBox(height: 16),
          _sectionDetailsBox(market),
          _sectionCategories(categories!),
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
        future: marketCommentsNotifier.customerMarketRepo
            .getPhotos(marketId: marketId),
        successBuilder: (context, data) {
          return data!.fold(
            (left) => MarketSlider(images: []),
            (right) {
              var latitude = "${marketDetail.data!.location}".split("-")[0];
              var longitude = "${marketDetail.data!.location}".split("-")[1];
              return MarketSlider(
                images: right.data!.photos,
                marketLatitude: latitude,
                marketLongitude: longitude,
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

  Widget _sectionDetailsBox(Market market) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: MarketsListItem(
        market: market,
        onTap: () {},
      ),
    );
  }

  Widget _sectionCategories(List<Category> categories) {
    return CategoryList(
      marketId: marketId,
      categories: categories,
    );
  }

  Widget _sectionComments(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomFutureBuilder<Either<Failure, CommentsResultModel>>(
        future: marketCommentsNotifier.customerMarketRepo.getComments(
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
