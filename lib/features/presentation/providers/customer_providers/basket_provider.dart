import 'package:flutter/material.dart';

import '../../../data/models/basket_result_model.dart';
import '../../../data/repositories/customer_basket_repository.dart';
import '../../../data/repositories/customer_product_repository.dart';

class BasketNotifier extends ChangeNotifier {
  BasketNotifier({
    @required this.customerBasketRepo,
    @required this.customerProductRepo,
  });

  final CustomerBasketRepository customerBasketRepo;
  final CustomerProductRepository customerProductRepo;

  bool loading = true;
  String errorMsg;
  BasketResultModel basketResultModel;

  Future<void> fetchBasket() async {
    var result = await customerBasketRepo.basket;
    result.fold(
      (left) {
        errorMsg = left.message;
      },
      (right) {
        basketResultModel = right;
      },
    );
    loading = false;
    notifyListeners();
  }

  void refresh() async {
    await fetchBasket();
  }
}
