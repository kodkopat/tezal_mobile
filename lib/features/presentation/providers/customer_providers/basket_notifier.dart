import 'package:flutter/material.dart';

import '../../../data/models/basket_result_model.dart';
import '../../../data/repositories/customer_basket_repository.dart';
import '../../../data/repositories/customer_product_repository.dart';

class BasketNotifier extends ChangeNotifier {
  static BasketNotifier _instance;

  factory BasketNotifier(
    CustomerBasketRepository customerBasketRepo,
    CustomerProductRepository customerProductRepo,
  ) {
    if (_instance == null) {
      _instance = BasketNotifier._privateConstructor(
        customerBasketRepo: customerBasketRepo,
        customerProductRepo: customerProductRepo,
      );
    }

    return _instance;
  }

  BasketNotifier._privateConstructor({
    this.customerBasketRepo,
    this.customerProductRepo,
  }) {
    fetchBasketCount();
  }

  final CustomerBasketRepository customerBasketRepo;
  final CustomerProductRepository customerProductRepo;

  bool loading = true;
  String errorMsg;
  BasketResultModel basketResultModel;
  int basketCount;

  Future<void> addToBasket({
    @required String productId,
    @required int amount,
  }) async {
    var result = await customerBasketRepo.addProductToBasket(
      productId: productId,
      amount: amount,
    );

    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  Future<void> removeFromBasket({
    @required String productId,
    @required int amount,
  }) async {
    var result = await customerBasketRepo.removeProductToBasket(
      productId: productId,
      amount: amount,
    );

    result.fold(
      (left) => null,
      (right) => refresh(),
    );
  }

  Future<void> clearBasket() async {
    var result = await customerBasketRepo.emptyBasket();
    result.fold(
      (left) {
        errorMsg = left.message;
      },
      (right) {
        basketResultModel = null;
        basketCount = 0;
      },
    );
    notifyListeners();
  }

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

  Future<void> fetchBasketCount() async {
    var result = await customerBasketRepo.basketCount;
    result.fold(
      (left) => null,
      (right) => basketCount = right.data,
    );
    notifyListeners();
  }

  void refresh() async {
    await fetchBasket();
    await fetchBasketCount();
  }
}
