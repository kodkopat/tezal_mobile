import 'package:flutter/material.dart';

import '../../../data/models/market/market_products_result_model.dart';
import '../../../data/models/market/products_result_model.dart';
import '../../../data/models/market/sub_categories_result_model.dart';
import '../../../data/repositories/market_product_repository.dart';

class SubCategoryNotifier extends ChangeNotifier {
  SubCategoryNotifier(this.marketProductRepo);

  final MarketProductRepository marketProductRepo;

  bool subCategoriesLoading = true;
  String? subCategoriesErrorMsg;
  List<SubCategory>? subCategories;
  List<String> subCategoryNameList = [];
  List<String> subCategoryIdList = [];
  int subCategoryListSelectedIndex = 0;

  Future<void> fetchSubCategories({required String mainCategoryId}) async {
    var result = await marketProductRepo.getSubCategoriesOfCategory(
      mainCategoryId: mainCategoryId,
    );

    result.fold(
      (left) => subCategoriesErrorMsg = left.message,
      (right) {
        subCategories = right.data;
        if (subCategories!.isNotEmpty)
          subCategories!.forEach((element) {
            subCategoryIdList.add("${element.id}");
            subCategoryNameList.add("${element.name}");
          });
      },
    );

    subCategoriesLoading = false;
    notifyListeners();
  }

  bool notListedProductsLoading = true;
  String? notListedProductsErrorMsg;
  ProductsResultModel? notListedProductsResult;

  Future<void> fetchNotListedProducts({
    required String mainCategoryId,
    required String subCategoryId,
  }) async {
    var result = await marketProductRepo.getNotListedProducts(
      mainCategoryId: mainCategoryId,
      subCategoryId: subCategoryId,
    );

    result.fold(
      (left) => notListedProductsErrorMsg = left.message,
      (right) => notListedProductsResult = right,
    );

    notListedProductsLoading = false;
    notifyListeners();
  }

  bool marketProductsLoading = true;
  String? marketProductsErrorMsg;
  MarketProductsResultModel? marketProductsResult;

  Future<void> fetchMarketProducts({
    required String mainCategoryId,
    required String subCategoryId,
  }) async {
    var result = await marketProductRepo.getMarketProducts(
      mainCategoryId: mainCategoryId,
      subCategoryId: subCategoryId,
    );

    result.fold(
      (left) => marketProductsErrorMsg = left.message,
      (right) => marketProductsResult = right,
    );

    marketProductsLoading = false;
    notifyListeners();
  }

  void refreshProducts() {
    notListedProductsLoading = true;
    notListedProductsErrorMsg = null;
    notListedProductsResult = null;

    marketProductsLoading = true;
    marketProductsErrorMsg = null;
    marketProductsResult = null;

    notifyListeners();
  }

  void refreshSubCategoryListSelectedIndex(int index) {
    subCategoryListSelectedIndex = index;
    notifyListeners();
  }
}
