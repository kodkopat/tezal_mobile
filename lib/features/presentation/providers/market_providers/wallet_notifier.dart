import 'package:flutter/material.dart';

import '../../../data/models/market/wallet_balance_result_model.dart';
import '../../../data/repositories/market_wallet_repository.dart';

class WalletNotifier extends ChangeNotifier {
  static WalletNotifier? _instance;

  factory WalletNotifier(
    MarketWalletRepository marketWalletRepo,
  ) {
    if (_instance == null) {
      _instance = WalletNotifier._privateConstructor(marketWalletRepo);
    }

    return _instance!;
  }

  WalletNotifier._privateConstructor(this.marketWalletRepo);

  final MarketWalletRepository marketWalletRepo;

  bool walletLoading = true;
  String? walletErrorMsg;
  WalletBalanceResultModel? walletResult;

  Future<void> fetchBalance() async {
    var result = await marketWalletRepo.getBalance();

    result.fold(
      (left) => walletErrorMsg = left.message,
      (right) => walletResult = right,
    );

    walletLoading = false;
    notifyListeners();
  }

  void refresh() async {
    await fetchBalance();
  }
}
