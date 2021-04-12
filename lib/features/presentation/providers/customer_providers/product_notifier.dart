import 'package:flutter/material.dart';

import '../../../data/models/liked_products_result_model.dart';
import '../../../data/repositories/customer_product_repository.dart';

class ProductNotifier extends ChangeNotifier {
  static ProductNotifier? _instance;

  factory ProductNotifier(
    CustomerProductRepository customerProductRepo,
  ) {
    if (_instance == null) {
      _instance = ProductNotifier._privateConstructor(
        customerProductRepo: customerProductRepo,
      );
    }

    return _instance!;
  }

  ProductNotifier._privateConstructor({
    required this.customerProductRepo,
  });

  final CustomerProductRepository customerProductRepo;

  bool likedProductsLoading = true;
  String? likedProductsErrorMsg;
  LikedProductsResultModel? likedProductsResultModel;

  Future<void> fetchLikedProducts() async {
    var result = await customerProductRepo.likedProdutcs();

    result.fold(
      (left) => likedProductsErrorMsg = left.message,
      (right) {
        print("likedProducts: ${right.toJson()}\n");
        likedProductsResultModel = right;
      },
    );

    likedProductsLoading = false;
    notifyListeners();
  }

  Future<void> likeProduct({required String productId}) async {
    var result = await customerProductRepo.likeProduct(
      id: productId,
    );

    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  Future<void> unlikeProduct({required String productId}) async {
    var result = await customerProductRepo.unlikeProduct(
      id: productId,
    );

    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  void refresh() async {
    await fetchLikedProducts();
  }
}
