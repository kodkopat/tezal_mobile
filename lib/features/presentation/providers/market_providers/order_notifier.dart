import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/customer/base_api_result_model.dart';
import '../../../data/models/market/market_orders_result_model.dart';
import '../../../data/repositories/market_order_repository.dart';

class OrderNotifier extends ChangeNotifier {
  static OrderNotifier? _instance;

  factory OrderNotifier(
    MarketOrderRepository marketOrderRepo,
  ) {
    if (_instance == null) {
      _instance = OrderNotifier._privateConstructor(
        marketOrderRepo: marketOrderRepo,
      );
    }

    return _instance!;
  }

  OrderNotifier._privateConstructor({
    required this.marketOrderRepo,
  });

  final MarketOrderRepository marketOrderRepo;

  bool ordersLoading = true;
  String? ordersErrorMsg;
  List<MarketOrder>? marketOrders;

  Future<void> fetchOrders() async {
    var result = await marketOrderRepo.getOrders();

    result.fold(
      (left) => ordersErrorMsg = left.message,
      (right) {
        marketOrders = right.data;
      },
    );

    ordersLoading = false;
    notifyListeners();
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

  void refresh() async {
    await fetchOrders();
  }
}
