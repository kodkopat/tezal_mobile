import 'package:flutter/material.dart';

import '../../../data/models/market_detail_result_model.dart';
import '../../../data/repositories/customer_market_repository.dart';

class MarketDetailNotifier extends ChangeNotifier {
  MarketDetailNotifier(this.customerMarketRepo);

  final CustomerMarketRepository customerMarketRepo;

  String? marketId;
  bool marketDetailLoading = true;
  String? marketDetailErrorMsg;
  MarketDetailResultModel? marketDetail;

  Future<void> fetchMarketDetail({required String marketId}) async {
    this.marketId = marketId;
    var result = await customerMarketRepo.marketDetail(
      marketId: marketId,
    );

    result.fold(
      (left) => marketDetailErrorMsg = left.message,
      (right) => marketDetail = right,
    );

    marketDetailLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    marketDetail = null;
    notifyListeners();
  }
}
