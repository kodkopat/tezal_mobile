import 'package:flutter/material.dart';

import '../../data/models/base_api_result_model.dart';
import '../../data/models/customer/nearby_markets_result_model.dart';
import '../../data/repositories/customer_market_repository.dart';

class MarketNotifier extends ChangeNotifier {
  MarketNotifier(this.customerMarketRepo);

  final CustomerMarketRepository customerMarketRepo;

  bool nearByMarketsLoading = true;
  String? nearByMarketsErrorMsg;
  String? marketCategoryId;

  bool? enableLoadMoreData;
  int? nearyByMarketsTotalCount;
  int? latestPageIndex;
  List<Market>? nearByMarkets;

  Future<void> fetchNearbyMarkets(
    BuildContext context, {
    required String marketCategoryId,
  }) async {
    if (nearyByMarketsTotalCount == null) {
      var result = await customerMarketRepo.getNearByMarkets(
        marketCategoryId: marketCategoryId,
        maxDistance: 10,
        page: 1,
      );

      this.marketCategoryId = marketCategoryId;

      result.fold(
        (left) => nearByMarketsErrorMsg = left.message,
        (right) {
          print("nearByMarkets: ${right.toJson()}\n");
          NearByMarketsResultModel model = right;
          nearyByMarketsTotalCount = model.data!.total;
          latestPageIndex = right.data!.page;
          nearByMarkets = right.data!.markets;
          enableLoadMoreData =
              nearyByMarketsTotalCount != nearByMarkets!.length;
        },
      );
    } else {
      if (nearyByMarketsTotalCount == 0) return;

      var result = await customerMarketRepo.getNearByMarkets(
        marketCategoryId: marketCategoryId,
        maxDistance: 10,
        page: latestPageIndex! + 1,
      );

      result.fold(
        (left) => nearByMarketsErrorMsg = left.message,
        (right) {
          // nearByMarketsResultModel = right;
          // nearyByMarketsTotalCount = right.data!.total;
          latestPageIndex = right.data!.page;
          nearByMarkets!.addAll(right.data!.markets!);
          enableLoadMoreData =
              nearyByMarketsTotalCount != nearByMarkets!.length;
        },
      );
    }

    nearByMarketsLoading = false;
    notifyListeners();
  }

  String? likeErrorMsg;
  BaseApiResultModel? likeResult;

  Future<void> like({required String marketId}) async {
    var result = await customerMarketRepo.like(
      marketId: marketId,
    );

    result.fold(
      (left) => likeErrorMsg = left.message,
      (right) => likeResult = right,
    );

    notifyListeners();
  }

  String? unLikeErrorMsg;
  BaseApiResultModel? unLikeResult;

  Future<void> unLike({required String marketId}) async {
    var result = await customerMarketRepo.unLike(
      marketId: marketId,
    );

    result.fold(
      (left) => likeErrorMsg = left.message,
      (right) => likeResult = right,
    );

    notifyListeners();
  }

  void refresh(BuildContext context) async {
    nearByMarketsLoading = true;
    notifyListeners();

    enableLoadMoreData = null;
    nearyByMarketsTotalCount = null;
    latestPageIndex = null;
    nearByMarkets = null;

    await fetchNearbyMarkets(
      context,
      marketCategoryId: marketCategoryId!,
    );
  }
}
