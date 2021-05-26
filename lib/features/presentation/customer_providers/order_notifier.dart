import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/customer/older_orders_result_model.dart';
import '../../data/models/customer/order_result_model.dart';
import '../../data/repositories/customer_order_repository.dart';
import '../../data/repositories/customer_product_repository.dart';

class OrderNotifier extends ChangeNotifier {
  static OrderNotifier? _instance;

  factory OrderNotifier(
    CustomerOrderRepository customerOrderRepo,
    CustomerProductRepository customerProductRepo,
  ) {
    if (_instance == null) {
      _instance = OrderNotifier._privateConstructor(
        customerOrderRepo,
        customerProductRepo,
      );
    }

    return _instance!;
  }

  OrderNotifier._privateConstructor(
    this.customerOrderRepo,
    this.customerProductRepo,
  );

  final CustomerOrderRepository customerOrderRepo;
  final CustomerProductRepository customerProductRepo;

  bool wasFetchOlderOrdersCalled = false;
  bool loading = true;
  String? errorMsg;

  int skip = 0;
  int take = 10;
  int? totalCount;
  bool? enableLoadMoreOption;

  List<Order>? orders;

  Future<void> fetchOlderOrders(BuildContext context) async {
    if (!wasFetchOlderOrdersCalled) {
      wasFetchOlderOrdersCalled = true;
      notifyListeners();
    }

    if (totalCount == null) {
      var result = await customerOrderRepo.getOlderOrders(
        skip: skip,
        take: take,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          totalCount = right.data!.totalCount;
          orders = right.data!.orders;
          enableLoadMoreOption = totalCount != orders!.length;
          skip += take;
        },
      );

      loading = false;
    } else {
      if (totalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await customerOrderRepo.getOlderOrders(
        skip: skip,
        take: take,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          orders!.addAll(right.data!.orders!);
          enableLoadMoreOption = totalCount != orders!.length;
          skip += take;
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
    required String deliveryTime,
  }) async {
    var result = await customerOrderRepo.save(
      paymentType: paymentType,
      addressId: addressId,
      deliveryTime: deliveryTime,
    );

    result.fold(
      (left) => orderErrorMsg = left.message,
      (right) => orderResultModel = right,
    );

    orderLoading = false;
    notifyListeners();
  }

  void refresh(BuildContext context) async {
    wasFetchOlderOrdersCalled = false;
    loading = true;
    errorMsg = null;
    skip = 0;
    take = 10;
    totalCount = null;
    enableLoadMoreOption = null;
    orders = null;

    await fetchOlderOrders(context);
  }
}
