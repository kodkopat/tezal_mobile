import 'package:flutter/material.dart';

import '../../data/models/customer/liked_products_result_model.dart';
import '../../data/repositories/customer_product_repository.dart';

class LikedProductNotifier extends ChangeNotifier {
  static LikedProductNotifier? _instance;

  factory LikedProductNotifier(
    CustomerProductRepository customerProductRepo,
  ) {
    if (_instance == null) {
      _instance = LikedProductNotifier._privateConstructor(customerProductRepo);
    }

    return _instance!;
  }

  LikedProductNotifier._privateConstructor(this.customerProductRepo);

  final CustomerProductRepository customerProductRepo;

  bool likedProductsLoading = true;
  String? likedProductsErrorMsg;
  LikedProductsResultModel? likedProductsResultModel;

  Future<void> fetchLikedProducts() async {
    var result = await customerProductRepo.getLikedProducts();

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
    var result = await customerProductRepo.like(
      id: productId,
    );

    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  Future<void> unlikeProduct({required String productId}) async {
    var result = await customerProductRepo.unlike(
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
