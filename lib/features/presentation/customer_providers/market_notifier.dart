import 'package:flutter/material.dart';

import '../../data/models/base_api_result_model.dart';
import '../../data/models/customer/nearby_markets_result_model.dart';
import '../../data/repositories/customer_market_repository.dart';

class MarketNotifier extends ChangeNotifier {
  MarketNotifier(this.customerMarketRepo);

  final CustomerMarketRepository customerMarketRepo;

  bool nearByMarketsLoading = true;
  String? nearByMarketsErrorMsg;
  NearByMarketsResultModel? nearByMarkets;

  Future<void> fetchNearbyMarkets() async {
    var result = await customerMarketRepo.getNearByMarkets(
      maxDistance: 10,
    );

    result.fold(
      (left) => nearByMarketsErrorMsg = left.message,
      (right) => nearByMarkets = right,
    );

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

  void refresh() async {
    nearByMarketsLoading = true;
    nearByMarketsErrorMsg = null;
    nearByMarkets = null;

    notifyListeners();

    await fetchNearbyMarkets();
  }
}
