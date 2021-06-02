import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/delivery/orders_result_model.dart';
import '../../data/repositories/delivery_order_repository.dart';

class DeliveryOrdersNotifier extends ChangeNotifier {
  static DeliveryOrdersNotifier? _instance;

  factory DeliveryOrdersNotifier(
    DeliveryOrderRepository deliveryOrderRepo,
  ) {
    if (_instance == null) {
      _instance = DeliveryOrdersNotifier._privateConstructor(deliveryOrderRepo);
    }

    return _instance!;
  }

  DeliveryOrdersNotifier._privateConstructor(this.deliveryOrderRepo);

  final DeliveryOrderRepository deliveryOrderRepo;

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
    "بر اساس فاصله", // distance,
    "بر اساس تاریخ", // date,
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

  List<OrderItem>? orderItems;

  Future<void> fetchOrders(BuildContext context) async {
    if (!wasFetchOrdersCalled) {
      wasFetchOrdersCalled = true;
      notifyListeners();
    }

    bool? distanceAscending;
    if (orderSortListIndex != null && orderSortListIndex == 0) {
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

    bool? dateAscescending;
    if (orderSortListIndex != null && orderSortListIndex == 1) {
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

    if (totalCount == null) {
      var result = await deliveryOrderRepo.getDeliveryOrders(
        skip: skip,
        take: take,
        orderStatus:
            orderStatusListIndex == null ? "" : "$orderStatusListIndex",
        orderbyDistanceDescending: distanceAscending,
        orderbyCreateDate: dateAscescending,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          totalCount = right.data!.totalCount;
          orderItems = right.data!.result;
          enableLoadMoreOption = totalCount != orderItems!.length;
          skip += take;
        },
      );

      loading = false;
    } else {
      if (totalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await deliveryOrderRepo.getDeliveryOrders(
        skip: skip,
        take: take,
        orderStatus:
            orderStatusListIndex == null ? "" : "$orderStatusListIndex",
        orderbyDistanceDescending: distanceAscending,
        orderbyCreateDate: dateAscescending,
      );

      result.fold(
        (left) => errorMsg = left.message,
        (right) {
          orderItems!.addAll(right.data!.result!);
          enableLoadMoreOption = totalCount != orderItems!.length;
          skip += take;
        },
      );

      prgDialog.hide();
    }

    print("ordersLength: ${orderItems!.length}\n");
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
    orderItems = null;

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
    orderItems = null;

    notifyListeners();

    await fetchOrders(context);
  }
}
