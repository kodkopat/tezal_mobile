import 'package:flutter/material.dart';

import '../../data/models/base_api_result_model.dart';
import '../../data/models/customer/nearby_markets_result_model.dart';
import '../../data/repositories/customer_market_repository.dart';

class MarketCategoryNotifier extends ChangeNotifier {
  static MarketCategoryNotifier? _instance;

  factory MarketCategoryNotifier(
    CustomerMarketRepository customerMarketRepo,
  ) {
    if (_instance == null) {
      _instance =
          MarketCategoryNotifier._privateConstructor(customerMarketRepo);
    }

    return _instance!;
  }

  MarketCategoryNotifier._privateConstructor(this.customerMarketRepo);

  final CustomerMarketRepository customerMarketRepo;

  // bool marketCategoriesLoading = true;
  // String? marketCategoriesErrorMsg;
  // List<MarketCategory>? marketCategories;

  // Future<void> fetchMarketCategories() async {
  //   var result = await customerMarketRepo.getMarketCategories();

  //   result.fold(
  //     (left) => marketCategoriesErrorMsg = left.message,
  //     (right) => marketCategories = right.data,
  //   );

  //   marketCategoriesLoading = false;
  //   notifyListeners();
  // }

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
    // marketCategoriesLoading = true;
    // marketCategoriesErrorMsg = null;
    // marketCategories = null;

    // notifyListeners();

    // await fetchMarketCategories();

    nearByMarketsLoading = true;
    nearByMarketsErrorMsg = null;
    nearByMarkets = null;

    notifyListeners();

    await fetchNearbyMarkets();
  }
}
