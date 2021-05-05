import 'package:flutter/material.dart';

import '../../../data/models/market/sub_category_products_result_model.dart';
import '../../../data/repositories/market_product_repository.dart';

class ProductsNotifier extends ChangeNotifier {
  ProductsNotifier(this.marketProductRepo);

  final MarketProductRepository marketProductRepo;

  bool productsLoading = true;
  String? productsErrorMsg;
  SubCategoryProductsResultModel? productsResult;

  Future<void> fetchProducts({
    required String mainCategoryId,
    required String subCategoryId,
  }) async {
    var result = await marketProductRepo.getProductsOfSubCategory(
      mainCategoryId: mainCategoryId,
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
