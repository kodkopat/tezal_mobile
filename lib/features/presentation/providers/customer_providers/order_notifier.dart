import 'package:flutter/material.dart';

import '../../../data/models/older_orders_result_model.dart';
import '../../../data/models/order_result_model.dart';
import '../../../data/repositories/customer_order_repository.dart';

class OrderNotifier extends ChangeNotifier {
  static OrderNotifier _instance;

  factory OrderNotifier(
    CustomerOrderRepository customerOrderRepo,
  ) {
    if (_instance == null) {
      _instance = OrderNotifier._privateConstructor(
        customerOrderRepo: customerOrderRepo,
      );
    }

    return _instance;
  }

  OrderNotifier._privateConstructor({
    this.customerOrderRepo,
  });

  final CustomerOrderRepository customerOrderRepo;

  bool loading = true;
  String errorMsg;

  OlderOrdersResultModel olderOrdersResultModel;
  OrderResultModel orderResultModel;

  Future<void> fetchOlderOrders() async {
    var result = await customerOrderRepo.olderOrders();
    result.fold(
      (left) => errorMsg = left.message,
      (right) => olderOrdersResultModel = right,
    );

    loading = false;
    notifyListeners();
  }

  Future<void> saveOrder({@required int paymentType}) async {
    var result = await customerOrderRepo.saveOrder(paymentType: paymentType);
    result.fold(
      (left) => errorMsg = left.message,
      (right) => orderResultModel = right,
    );

    loading = false;
    notifyListeners();
  }

  void refresh() async {
    await fetchOlderOrders();
  }
}
