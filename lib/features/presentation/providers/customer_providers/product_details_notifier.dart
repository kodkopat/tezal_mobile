import 'package:flutter/material.dart';

import '../../../data/models/customer/product_detail_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';

class ProductDetailNotifier extends ChangeNotifier {
  ProductDetailNotifier(this.customerProductRepo);

  final CustomerProductRepository customerProductRepo;

  bool productLoading = true;
  String? productErrorMsg;
  ProductDetailResultModel? productDetails;

  Future<void> fetchProductDetail({
    required String productId,
  }) async {
    var result = await customerProductRepo.getDetail(
      id: productId,
    );

    result.fold(
      (left) => productErrorMsg = left.message,
      (right) => productDetails = right,
    );

    productLoading = false;
    notifyListeners();
  }
}
