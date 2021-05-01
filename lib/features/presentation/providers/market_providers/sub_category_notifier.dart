import 'package:flutter/material.dart';

import '../../../data/models/market/sub_categories_result_model.dart';
import '../../../data/models/market/sub_category_products_result_model.dart';
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
        subCategories!.forEach((element) {
          subCategoryIdList.add("${element.id}");
          subCategoryNameList.add("${element.name}");
        });
      },
    );

    subCategoriesLoading = false;
    notifyListeners();
  }

  void refreshSubCategoryListSelectedIndex() {
    notifyListeners();
  }

  bool productsLoading = true;
  String? productsErrorMsg;
  SubCategoryProductsResultModel? productsResult;

  Future<void> fetchProducts({required String subCategoryId}) async {
    var result = await marketProductRepo.getProductsOfSubCategory(
      subCategoryId: subCategoryId,
    );

    result.fold(
      (left) => productsErrorMsg = left.message,
      (right) => productsResult = right,
    );

    productsLoading = false;
    notifyListeners();
  }

  void refreshProducts() {
    productsLoading = true;
    productsErrorMsg = null;
    productsResult = null;

    notifyListeners();
  }
}
