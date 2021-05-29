import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/market/products_result_model.dart';
import '../../data/repositories/market_product_repository.dart';

class MarketSearchNotifier extends ChangeNotifier {
  static MarketSearchNotifier? _instance;

  factory MarketSearchNotifier(
    MarketProductRepository marketProductRepo,
  ) {
    if (_instance == null) {
      _instance = MarketSearchNotifier._privateConstructor(marketProductRepo);
    }

    return _instance!;
  }

  MarketSearchNotifier._privateConstructor(this.marketProductRepo);

  final MarketProductRepository marketProductRepo;

  String? errorMsg;
  ProductsResultModel? searchResult;

  Future<void> fetchNotListedProducts(BuildContext context,
      {required String term}) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketProductRepo.getNotListedProducts(
      terms: term,
    );

    result.fold(
      (left) => errorMsg = left.message,
      (right) => searchResult = right,
    );

    prgDialog.hide();
    notifyListeners();
  }
}
