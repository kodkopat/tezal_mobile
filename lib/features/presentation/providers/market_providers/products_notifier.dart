import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/base_api_result_model.dart';
import '../../../data/repositories/market_product_repository.dart';

class ProductsNotifier extends ChangeNotifier {
  ProductsNotifier(this.marketProductRepo);

  final MarketProductRepository marketProductRepo;

  String? addToMarketProductsErrorMsg;
  BaseApiResultModel? addToMarketProductsResult;

  Future<void> addToMarketProducts(
    BuildContext context, {
    required String productId,
    required double amount,
    required double discountRate,
    required double discountedPrice,
    required double originalPrice,
    required bool onSale,
    required String description,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketProductRepo.addToProductMarket(
      productId: productId,
      amount: amount,
      discountRate: discountRate,
      discountedPrice: discountedPrice,
      originalPrice: originalPrice,
      onSale: onSale,
      description: description,
    );

    prgDialog.hide();

    result.fold(
      (left) => addToMarketProductsErrorMsg = left.message,
      (right) => addToMarketProductsResult = right,
    );

    notifyListeners();
  }
}
