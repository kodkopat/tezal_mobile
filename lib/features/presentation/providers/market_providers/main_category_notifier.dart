import 'package:flutter/material.dart';

import '../../../data/models/market/main_categories_result_model.dart';
import '../../../data/repositories/market_product_repository.dart';

class MainCategoryNotifier extends ChangeNotifier {
  static MainCategoryNotifier? _instance;

  factory MainCategoryNotifier(
    MarketProductRepository marketProductRepo,
  ) {
    if (_instance == null) {
      _instance = MainCategoryNotifier._privateConstructor(marketProductRepo);
    }

    return _instance!;
  }

  MainCategoryNotifier._privateConstructor(this.marketProductRepo);

  final MarketProductRepository marketProductRepo;

  bool mainCategoriesLoading = true;
  String? mainCategoriesErrorMsg;
  List<MainCategory>? mainCategories;

  Future<void> fetchMainCategories() async {
    var result = await marketProductRepo.getMainCategories();

    result.fold(
      (left) => mainCategoriesErrorMsg = left.message,
      (right) => mainCategories = right.data,
    );

    mainCategoriesLoading = false;
    notifyListeners();
  }
}
