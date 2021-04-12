import 'package:flutter/material.dart';

import '../../../data/models/older_orders_result_model.dart';
import '../../../data/models/order_detail_result_model.dart';
import '../../../data/models/order_result_model.dart';
import '../../../data/repositories/customer_order_repository.dart';
import '../../../data/repositories/customer_product_repository.dart';

class OrderNotifier extends ChangeNotifier {
  static OrderNotifier? _instance;

  factory OrderNotifier(
    CustomerOrderRepository customerOrderRepo,
    CustomerProductRepository customerProductRepo,
  ) {
    if (_instance == null) {
      _instance = OrderNotifier._privateConstructor(
        customerOrderRepo: customerOrderRepo,
        customerProductRepo: customerProductRepo,
      );
    }

    return _instance!;
  }

  OrderNotifier._privateConstructor({
    required this.customerOrderRepo,
    required this.customerProductRepo,
  });

  final CustomerOrderRepository customerOrderRepo;
  final CustomerProductRepository customerProductRepo;

  bool olderOrdersLoading = true;
  String? olderOrdersErrorMsg;
  OlderOrdersResultModel? olderOrdersResultModel;
  Future<void> fetchOlderOrders() async {
    var result = await customerOrderRepo.olderOrders(page: 1);
    result.fold(
      (left) => olderOrdersErrorMsg = left.message,
      (right) => olderOrdersResultModel = right,
    );

    olderOrdersLoading = false;
    notifyListeners();
  }

  bool orderDetailLoading = true;
  String? orderDetailErrorMsg;
  OrderDetailResultModel? orderDetailResultModel;
  Future<void> fetchOrderDetail({required String orderId}) async {
    var result = await customerOrderRepo.orderDetail(id: orderId);
    result.fold(
      (left) => orderDetailErrorMsg = left.message,
      (right) => orderDetailResultModel = right,
    );

    orderDetailLoading = false;
    notifyListeners();
  }

  bool orderLoading = true;
  String? orderErrorMsg;
  OrderResultModel? orderResultModel;
  Future<void> saveOrder({
    required int paymentType,
    required String addressId,
  }) async {
    var result = await customerOrderRepo.saveOrder(
      paymentType: paymentType,
      addressId: addressId,
    );

    result.fold(
      (left) => orderErrorMsg = left.message,
      (right) => orderResultModel = right,
    );

    orderLoading = false;
    notifyListeners();
  }

  void refresh() async {
    await fetchOlderOrders();
  }
}
