import 'package:flutter/material.dart';

import '../../../data/models/customer/nearby_markets_result_model.dart';
import '../../../data/repositories/customer_market_repository.dart';

class MarketNotifier extends ChangeNotifier {
  static MarketNotifier? _instance;

  factory MarketNotifier(
    CustomerMarketRepository customerMarketRepo,
  ) {
    if (_instance == null) {
      _instance = MarketNotifier._privateConstructor(customerMarketRepo);
    }

    return _instance!;
  }

  MarketNotifier._privateConstructor(this.customerMarketRepo);

  final CustomerMarketRepository customerMarketRepo;

  bool nearByMarketsLoading = true;
  String? nearByMarketsErrorMsg;

  bool? enableLoadMoreData;
  int? nearyByMarketsTotalCount;
  int? latestPageIndex;
  List<Market>? nearByMarkets;

  Future<void> fetchNearbyMarkets(BuildContext context) async {
    if (nearyByMarketsTotalCount == null) {
      var result = await customerMarketRepo.nearByMarkets(
        context,
        maxDistance: 10,
        page: 1,
      );

      result.fold(
        (left) => nearByMarketsErrorMsg = left.message,
        (right) {
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

      var result = await customerMarketRepo.nearByMarkets(
        context,
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

  void refresh(BuildContext context) async {
    nearByMarketsLoading = true;
    notifyListeners();

    enableLoadMoreData = null;
    nearyByMarketsTotalCount = null;
    latestPageIndex = null;
    nearByMarkets = null;

    await fetchNearbyMarkets(context);
  }
}
