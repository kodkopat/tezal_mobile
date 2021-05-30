import 'package:flutter/material.dart';

import '../../data/models/customer/market_categories_result_model.dart';
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

  bool marketCategoriesLoading = true;
  String? marketCategoriesErrorMsg;
  List<MarketCategory>? marketCategories;

  Future<void> fetchMarketCategories() async {
    var result = await customerMarketRepo.getMarketCategories();

    result.fold(
      (left) => marketCategoriesErrorMsg = left.message,
      (right) => marketCategories = right.data,
    );

    marketCategoriesLoading = false;
    notifyListeners();
  }

  void refresh() async {
    marketCategoriesLoading = true;
    marketCategoriesErrorMsg = null;
    marketCategories = null;

    notifyListeners();

    await fetchMarketCategories();
  }
}
