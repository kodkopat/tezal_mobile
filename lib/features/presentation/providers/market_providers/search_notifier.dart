import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/market/products_result_model.dart';
import '../../../data/repositories/market_product_repository.dart';

class SearchNotifier extends ChangeNotifier {
  static SearchNotifier? _instance;

  factory SearchNotifier(
    MarketProductRepository marketProductRepo,
  ) {
    if (_instance == null) {
      _instance = SearchNotifier._privateConstructor(marketProductRepo);
    }

    return _instance!;
  }

  SearchNotifier._privateConstructor(this.marketProductRepo);

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
