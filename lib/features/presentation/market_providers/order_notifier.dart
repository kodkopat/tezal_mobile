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

  Future<void> approveOrder(
    BuildContext context, {
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

  Future<void> rejectOrder(
    BuildContext context, {
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

  String? prepareOrderErrorMsg;
  BaseApiResultModel? prepareOrderResult;

  Future<void> prepareOrder(
    BuildContext context, {
    required String orderId,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketOrderRepo.prepareOrder(id: orderId);

    result.fold(
      (left) => prepareOrderErrorMsg = left.message,
      (right) => prepareOrderResult = right,
    );

    prgDialog.hide();
    notifyListeners();
  }

  String? cancelOrderErrorMsg;
  BaseApiResultModel? cancelOrderResult;

  Future<void> cancelOrder(
    BuildContext context, {
    required String orderId,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await marketOrderRepo.cancelOrderApprove(id: orderId);

    result.fold(
      (left) => cancelOrderErrorMsg = left.message,
      (right) => cancelOrderResult = right,
    );

    prgDialog.hide();
    notifyListeners();
  }
}
