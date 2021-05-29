import 'package:flutter/material.dart';

import '../../data/models/customer/wallet_detail_result_model.dart';
import '../../data/models/customer/wallet_info_result_model.dart';
import '../../data/repositories/customer_wallet_repository.dart';

class CustomerWalletNotifier extends ChangeNotifier {
  static CustomerWalletNotifier? _instance;

  factory CustomerWalletNotifier(
    CustomerWalletRepository customerWalletRepo,
  ) {
    if (_instance == null) {
      _instance =
          CustomerWalletNotifier._privateConstructor(customerWalletRepo);
    }

    return _instance!;
  }

  CustomerWalletNotifier._privateConstructor(this.customerWalletRepo);

  final CustomerWalletRepository customerWalletRepo;

  bool infoLoading = true;
  String? infoErrorMsg;
  WalletInfoResultModel? walletInfoResultModel;

  Future<void> fetchWalletInfo() async {
    var result = await customerWalletRepo.getWalletInfo();
    result.fold(
      (left) => infoErrorMsg = left.message,
      (right) => walletInfoResultModel = right,
    );

    infoLoading = false;
    notifyListeners();
  }

  bool detailLoading = true;
  String? detailErrorMsg;

  bool? enableLoadMoreData;
  int? walletDetailTotalCount;
  int? latestPageIndex;
  List<Detail>? walletDetailList;

  Future<void> walletDetail() async {
    if (walletDetailTotalCount == null) {
      var result = await customerWalletRepo.getWalletDetail(page: 1);
      result.fold(
        (left) => detailErrorMsg = left.message,
        (right) {
          walletDetailTotalCount = right.data.total;
          latestPageIndex = right.data.page;
          walletDetailList = right.data.details;
          enableLoadMoreData =
              walletDetailTotalCount != walletDetailList!.length;
        },
      );
    } else {
      if (walletDetailTotalCount == 0) return;

      var result = await customerWalletRepo.getWalletDetail(
        page: latestPageIndex! + 1,
      );

      result.fold(
        (left) => detailErrorMsg = left.message,
        (right) {
          // walletDetailTotalCount = right.data.total;
          latestPageIndex = right.data.page;
          walletDetailList!.addAll(right.data.details);
          enableLoadMoreData =
              walletDetailTotalCount != walletDetailList!.length;
        },
      );
    }

    detailLoading = false;
    notifyListeners();
  }

  void refresh() async {
    detailLoading = true;
    notifyListeners();

    await fetchWalletInfo();

    enableLoadMoreData = null;
    walletDetailTotalCount = null;
    latestPageIndex = null;
    walletDetailList = null;
    await walletDetail();
  }
}
