import 'package:flutter/material.dart';

import '../../../data/models/wallet_detail_result_model.dart';
import '../../../data/models/wallet_info_result_model.dart';
import '../../../data/repositories/customer_wallet_repository.dart';

class WalletNotifier extends ChangeNotifier {
  static WalletNotifier _instance;

  factory WalletNotifier(
    CustomerWalletRepository customerWalletRepo,
  ) {
    if (_instance == null) {
      _instance = WalletNotifier._privateConstructor(
        customerWalletRepo: customerWalletRepo,
      );
    }

    return _instance;
  }

  WalletNotifier._privateConstructor({
    this.customerWalletRepo,
  });

  final CustomerWalletRepository customerWalletRepo;

  WalletInfoResultModel walletInfoResultModel;
  WalletDetailResultModel walletDetailResultModel;

  bool infoLoading = true;
  String infoErrorMsg;

  Future<void> fetchWalletInfo() async {
    var result = await customerWalletRepo.walletInfo;
    result.fold(
      (left) => infoErrorMsg = left.message,
      (right) => walletInfoResultModel = right,
    );

    infoLoading = false;
    notifyListeners();
  }

  bool detailLoading = true;
  String detailErrorMsg;

  Future<void> walletDetails({@required int page}) async {
    var result = await customerWalletRepo.walletDetails(page: page);
    result.fold(
      (left) => detailErrorMsg = left.message,
      (right) => walletDetailResultModel = right,
    );
    detailLoading = false;
    notifyListeners();
  }

  void refresh() async {
    await fetchWalletInfo();
    await walletDetails(page: 1);
  }
}
