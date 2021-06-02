import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/market/orders_result_model.dart';
import '../../data/repositories/market_order_repository.dart';

class MarketOrdersNotifier extends ChangeNotifier {
  static MarketOrdersNotifier? _instance;

  factory MarketOrdersNotifier(
    MarketOrderRepository marketOrderRepo,
  ) {
    if (_instance == null) {
      _instance = MarketOrdersNotifier._privateConstructor(marketOrderRepo);
    }

    return _instance!;
  }

  MarketOrdersNotifier._privateConstructor(this.marketOrderRepo);

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
  bool loading = true;
  String? errorMsg;

  int skip = 0;
  int take = 10;
  int? totalCount;
  bool? enableLoadMoreOption;

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

    if (totalCount == null) {
      var result = await marketOrderRepo.getOrders(
        skip: skip,
        take: take,
        status: orderStatusListIndex == null ? "" : "$orderStatusListIndex",
        dateAscescending: dateAscescending,
        distanceAscending: distanceAscending,
        priceAscending: priceAscending,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          totalCount = right.data!.totalCount;
          marketOrders = right.data!.result;
          enableLoadMoreOption = totalCount != marketOrders!.length;
          skip += take;
        },
      );

      loading = false;
    } else {
      if (totalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await marketOrderRepo.getOrders(
        skip: skip,
        take: take,
        status: orderStatusListIndex == null ? "" : "$orderStatusListIndex",
        dateAscescending: dateAscescending,
        distanceAscending: distanceAscending,
        priceAscending: priceAscending,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          marketOrders!.addAll(right.data!.result!);
          enableLoadMoreOption = totalCount != marketOrders!.length;
          skip += take;
        },
      );

      prgDialog.hide();
    }

    print("ordersLength: ${marketOrders!.length}\n");
    print("ordersTotalCount: $totalCount\n");

    notifyListeners();
  }

  void clearFilter(BuildContext context) async {
    orderStatusListIndex = null;
    orderSortListIndex = null;
    orderDirectionListIndex = null;

    loading = true;
    errorMsg = null;

    skip = 0;
    take = 10;
    totalCount = null;
    enableLoadMoreOption = null;
    marketOrders = null;

    notifyListeners();

    await fetchOrders(context);
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

    loading = true;
    errorMsg = null;

    skip = 0;
    take = 10;
    totalCount = null;
    enableLoadMoreOption = null;
    marketOrders = null;

    notifyListeners();

    await fetchOrders(context);
  }
}
