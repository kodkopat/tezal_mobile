import 'package:flutter/material.dart';

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

  void refresh() async {
    await fetchOrders();
  }
}
