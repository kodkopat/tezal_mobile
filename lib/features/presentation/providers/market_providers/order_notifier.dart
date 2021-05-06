import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/base_api_result_model.dart';
import '../../../data/models/market/orders_result_model.dart';
import '../../../data/repositories/market_order_repository.dart';

class OrderNotifier extends ChangeNotifier {
  static OrderNotifier? _instance;

  factory OrderNotifier(
    MarketOrderRepository marketOrderRepo,
  ) {
    if (_instance == null) {
      _instance = OrderNotifier._privateConstructor(marketOrderRepo);
    }

    return _instance!;
  }

  OrderNotifier._privateConstructor(this.marketOrderRepo);

  final MarketOrderRepository marketOrderRepo;

  int? orderStatusListIndex;
  List<String> orderStatusList = [
    "سفارشات جدید", // new_order,
    "سفارشات تایید شده", // approved,
    "سفارشات تایید نشده", // rejected,
    "سفارشات در حال آماده‌سازی", // preparing,
    "سفارشات در حال تحویل", // ondelivery,
    "سفارشات تحویل شده", // delivered,
    "سفارشات لغو شده", // canceled,
    "سفارشات بازگشتی", // returned
  ];

  int? orderSortListIndex;
  List<String> orderSortList = [
    "بر اساس تاریخ", // date,
    "بر اساس فاصله", // distance,
    "بر اساس قیمت", // price,
  ];

  int? orderDirectionListIndex;
  List<String> orderDirectionList = [
    "صعودی", // acsending,
    "نزولی", // descending,
  ];

  bool wasFetchOrdersCalled = false;
  bool ordersLoading = true;
  String? ordersErrorMsg;

  int ordersSkip = 0;
  int ordersTake = 10;
  int? ordersTotalCount;
  bool? enableLoadMoreData;

  List<MarketOrder>? marketOrders;

  Future<void> fetchOrders(BuildContext context) async {
    if (!wasFetchOrdersCalled) {
      wasFetchOrdersCalled = true;
      notifyListeners();
    }

    bool? dateAscescending;
    if (orderSortListIndex != null && orderSortListIndex == 0) {
      if (orderDirectionListIndex == null) {
        dateAscescending = true;
      } else {
        if (orderDirectionListIndex == 0) {
          dateAscescending = true;
        } else {
          dateAscescending = false;
        }
      }
    }

    bool? distanceAscending;
    if (orderSortListIndex != null && orderSortListIndex == 1) {
      if (orderDirectionListIndex == null) {
        distanceAscending = true;
      } else {
        if (orderDirectionListIndex == 0) {
          distanceAscending = true;
        } else {
          distanceAscending = false;
        }
      }
    }

    bool? priceAscending;
    if (orderSortListIndex != null && orderSortListIndex == 2) {
      if (orderDirectionListIndex == null) {
        priceAscending = true;
      } else {
        if (orderDirectionListIndex == 0) {
          priceAscending = true;
        } else {
          priceAscending = false;
        }
      }
    }

    if (ordersTotalCount == null) {
      var result = await marketOrderRepo.getOrders(
        skip: ordersSkip,
        take: ordersTake,
        status: orderStatusListIndex == null ? "" : "$orderStatusListIndex",
        dateAscescending: dateAscescending,
        distanceAscending: distanceAscending,
        priceAscending: priceAscending,
      );

      result.fold(
        (left) => ordersErrorMsg = left.message,
        (right) {
          ordersTotalCount = right.data!.totalCount;
          marketOrders = right.data!.result;
          enableLoadMoreData = ordersTotalCount != marketOrders!.length;
          ordersSkip += ordersTake;
        },
      );

      ordersLoading = false;
    } else {
      if (ordersTotalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await marketOrderRepo.getOrders(
        skip: ordersSkip,
        take: ordersTake,
        status: orderStatusListIndex == null ? "" : "$orderStatusListIndex",
        dateAscescending: dateAscescending,
        distanceAscending: distanceAscending,
        priceAscending: priceAscending,
      );

      result.fold(
        (left) => ordersErrorMsg = left.message,
        (right) {
          marketOrders!.addAll(right.data!.result!);
          enableLoadMoreData = ordersTotalCount != marketOrders!.length;
          ordersSkip += ordersTake;
        },
      );

      prgDialog.hide();
    }

    print("ordersLength: ${marketOrders!.length}\n");
    print("ordersTotalCount: $ordersTotalCount\n");

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

  void refresh(
    BuildContext context, {
    int? orderStatusListIndex,
    int? orderSortListIndex,
    int? orderDirectionListIndex,
  }) async {
    if (orderStatusListIndex != null)
      this.orderStatusListIndex = orderStatusListIndex;
    if (orderSortListIndex != null)
      this.orderSortListIndex = orderSortListIndex;
    if (orderDirectionListIndex != null)
      this.orderDirectionListIndex = orderDirectionListIndex;

    ordersLoading = true;
    ordersErrorMsg = null;

    ordersSkip = 0;
    ordersTake = 10;
    ordersTotalCount = null;
    enableLoadMoreData = null;
    marketOrders = null;

    notifyListeners();

    await fetchOrders(context);
  }
}
