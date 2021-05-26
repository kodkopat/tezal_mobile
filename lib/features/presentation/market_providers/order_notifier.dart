import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/base_api_result_model.dart';
import '../../data/repositories/market_order_repository.dart';

class OrderNotifier extends ChangeNotifier {
  OrderNotifier(this.marketOrderRepo);

  final MarketOrderRepository marketOrderRepo;

  Future<List<String>> fetchPhotos({
    required String orderId,
  }) async {
    List<String> photosList = [];
    var result = await marketOrderRepo.getOrderPhotos(orderId: orderId);

    result.fold(
      (left) {},
      (right) {
        for (int i = 0; i < right.data!.length; i++) {
          photosList.add(right.data![i].photo);
        }
      },
    );

    return photosList;
  }

  String? approveOrderErrorMsg;
  BaseApiResultModel? approveOrderResult;

  Future<void> approveOrder({
    required BuildContext context,
    required String orderId,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketOrderRepo.approveOrder(id: orderId);

    result.fold(
      (left) => approveOrderErrorMsg = left.message,
      (right) => approveOrderResult = right,
    );

    prgDialog.hide();
    notifyListeners();
  }

  String? rejectOrderErrorMsg;
  BaseApiResultModel? rejectOrderResult;

  Future<void> rejectOrder({
    required BuildContext context,
    required String orderId,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketOrderRepo.rejectOrder(id: orderId);

    result.fold(
      (left) => rejectOrderErrorMsg = left.message,
      (right) => rejectOrderResult = right,
    );

    prgDialog.hide();
    notifyListeners();
  }
}
