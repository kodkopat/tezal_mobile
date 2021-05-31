import 'package:flutter/material.dart';

import '../../data/models/base_api_result_model.dart';
import '../../data/models/customer/market_detail_result_model.dart';
import '../../data/repositories/customer_market_repository.dart';

class MarketDetailNotifier extends ChangeNotifier {
  MarketDetailNotifier(this.customerMarketRepo);

  final CustomerMarketRepository customerMarketRepo;

  String? marketId;
  bool marketDetailLoading = true;
  String? marketDetailErrorMsg;
  MarketDetailResultModel? marketDetail;

  Future<void> fetchMarketDetail({required String marketId}) async {
    this.marketId = marketId;
    var result = await customerMarketRepo.getMarketDetail(
      marketId: marketId,
    );

    result.fold(
      (left) => marketDetailErrorMsg = left.message,
      (right) => marketDetail = right,
    );

    marketDetailLoading = false;
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

  Future<void> refresh() async {
    marketDetail = null;
    notifyListeners();
  }
}
