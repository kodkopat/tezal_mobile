import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/customer/older_orders_result_model.dart';
import '../../../data/models/customer/order_result_model.dart';
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

  bool? enableLoadMoreData;
  int? olderOrdersTotalCount;
  int? latestPageIndex;
  List<Order>? olderOrders;

  Future<void> fetchOlderOrders(BuildContext context) async {
    if (olderOrdersTotalCount == null) {
      var result = await customerOrderRepo.olderOrders(page: 1);

      result.fold(
        (left) => olderOrdersErrorMsg = left.message,
        (right) {
          olderOrdersTotalCount = right.data!.total;
          latestPageIndex = right.data!.page;
          olderOrders = right.data!.orders!;
          enableLoadMoreData = olderOrdersTotalCount != olderOrders!.length;
        },
      );
      olderOrdersLoading = false;
    } else {
      if (olderOrdersTotalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await customerOrderRepo.olderOrders(
        page: latestPageIndex! + 1,
      );

      result.fold(
        (left) => olderOrdersErrorMsg = left.message,
        (right) {
          olderOrdersTotalCount = right.data!.total;
          latestPageIndex = right.data!.page;
          olderOrders!.addAll(right.data!.orders!);
          enableLoadMoreData = olderOrdersTotalCount != olderOrders!.length;
        },
      );

      prgDialog.hide();
    }
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

  void refresh(BuildContext context) async {
    olderOrdersLoading = true;
    notifyListeners();

    enableLoadMoreData = null;
    olderOrdersTotalCount = null;
    latestPageIndex = null;
    olderOrders = null;

    await fetchOlderOrders(context);
  }
}
