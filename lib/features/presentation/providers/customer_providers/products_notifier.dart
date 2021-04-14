import 'package:flutter/material.dart';

import '../../../data/models/product_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';

class ProductsNotifier extends ChangeNotifier {
  ProductsNotifier(this.customerProductRepo);

  final CustomerProductRepository customerProductRepo;

  bool productsLoading = true;
  String? productsErrorMsg;
  List<ProductResultModel>? products;

  Future<void> fetchProducts({
    required String marketId,
    required String categoryId,
  }) async {
    try {
      var result = await customerProductRepo.productList(
        marketId: marketId,
        categoryId: categoryId,
      );

      result.fold(
        (left) => productsErrorMsg = left.message,
        (right) {
          products = right.data;
        },
      );
    } catch (error) {
      print("fetchProducts error: $error\n");
    }

    notifyListeners();
  }
}
