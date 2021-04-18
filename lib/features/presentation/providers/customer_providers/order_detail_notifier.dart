import 'package:flutter/material.dart';

import '../../../../core/widgets/progress_dialog.dart';
import '../../../data/models/base_api_result_model.dart';
import '../../../data/models/order_detail_result_model.dart';
import '../../../data/repositories/customer_order_repository.dart';
import '../../../data/repositories/customer_product_repository.dart';

class OrderDetailNotifier extends ChangeNotifier {
  OrderDetailNotifier(
    this.customerOrderRepo,
    this.customerProductRepo,
  );

  final CustomerOrderRepository customerOrderRepo;
  final CustomerProductRepository customerProductRepo;

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

  String? addOrderToBasketErrorMsg;
  BaseApiResultModel? oaddOrderToBasketResult;

  Future<void> addOrderToBasket({
    required BuildContext context,
    required String orderId,
  }) async {
    var prgDialog = AppProgressDialog(context).instance;
    prgDialog.show();

    var result = await customerOrderRepo.addOrderToBasket(orderId: orderId);
    result.fold(
      (left) => addOrderToBasketErrorMsg = left.message,
      (right) => oaddOrderToBasketResult = right,
    );

    prgDialog.hide();
    notifyListeners();
  }
}
