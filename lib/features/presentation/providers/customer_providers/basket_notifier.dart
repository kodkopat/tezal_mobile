import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/customer/basket_result_model.dart';
import '../../../data/repositories/customer_basket_repository.dart';
import '../../../data/repositories/customer_product_repository.dart';

class BasketNotifier extends ChangeNotifier {
  static BasketNotifier? _instance;

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

    return _instance!;
  }

  BasketNotifier._privateConstructor({
    required this.customerBasketRepo,
    required this.customerProductRepo,
  }) {
    fetchBasketCount();
  }

  final CustomerBasketRepository customerBasketRepo;
  final CustomerProductRepository customerProductRepo;

  bool loading = true;
  String? errorMsg;
  BasketResultModel? basketResultModel;
  List<BasketItem>? basketItemList;
  int? basketCount;

  Future<void> addToBasket({
    required String productId,
    int? amount,
  }) async {
    // var prgDialog = AppProgressDialog(context).instance;
    // prgDialog.show();

    var result = await customerBasketRepo.addProductToBasket(
      productId: productId,
      amount: amount ?? 1,
    );

    result.fold(
      (left) => null,
      (right) => refresh(),
    );

    // prgDialog.hide();
  }

  Future<void> removeFromBasket({
    required String productId,
    int? amount,
  }) async {
    // var prgDialog = AppProgressDialog(context).instance;
    // prgDialog.show();

    var result = await customerBasketRepo.removeProductToBasket(
      productId: productId,
      amount: amount ?? 1,
    );

    result.fold(
      (left) => null,
      (right) => refresh(),
    );

    // prgDialog.hide();
  }

  Future<void> clearBasket(BuildContext context) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await customerBasketRepo.emptyBasket();
    result.fold(
      (left) => errorMsg = left.message,
      (right) {
        basketResultModel = null;
        basketItemList = null;
        basketCount = 0;
      },
    );

    notifyListeners();

    prgDialog.hide();
  }

  Future<void> fetchBasket() async {
    var result = await customerBasketRepo.basket;
    result.fold(
      (left) => errorMsg = left.message,
      (right) {
        basketResultModel = right;
        basketItemList = right.data!.items;
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
    errorMsg = null;
    basketResultModel = null;
    basketItemList = null;
    basketCount = null;

    await fetchBasket();
    await fetchBasketCount();
  }
}
