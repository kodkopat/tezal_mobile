import 'package:flutter/material.dart';

import '../../../core/widgets/progress_dialog.dart';
import '../../data/models/wallet_balance_result_model.dart';
import '../../data/models/wallet_detail_result_model.dart';
import '../../data/models/withdrawal_requests_result_model.dart';
import '../../data/repositories/market_wallet_repository.dart';

class MarketWalletNotifier extends ChangeNotifier {
  static MarketWalletNotifier? _instance;

  factory MarketWalletNotifier(
    MarketWalletRepository marketWalletRepo,
  ) {
    if (_instance == null) {
      _instance = MarketWalletNotifier._privateConstructor(marketWalletRepo);
    }

    return _instance!;
  }

  MarketWalletNotifier._privateConstructor(this.marketWalletRepo);

  final MarketWalletRepository marketWalletRepo;

  bool wasFetchBalanceCalled = false;
  bool walletLoading = true;
  String? walletErrorMsg;
  WalletBalanceResultModel? walletResult;

  Future<void> fetchBalance() async {
    if (!wasFetchBalanceCalled) {
      wasFetchBalanceCalled = true;
      notifyListeners();
    }

    var result = await marketWalletRepo.getBalance();

    result.fold(
      (left) => walletErrorMsg = left.message,
      (right) => walletResult = right,
    );

    walletLoading = false;
    notifyListeners();
  }

  bool wasFetchDetailsCalled = false;
  bool detailsLoading = true;
  String? detailsErrorMsg;

  int detailsSkip = 0;
  int detailsTake = 10;
  int? detailsTotalCount;
  bool? detailsEnableLoadMoreData;

  List<WalletDetail>? walletDetails;

  Future<void> fetchDetails(BuildContext context) async {
    if (!wasFetchDetailsCalled) {
      wasFetchDetailsCalled = true;
      notifyListeners();
    }

    if (detailsTotalCount == null) {
      var result = await marketWalletRepo.getWalletDetails(
        skip: detailsSkip,
        take: detailsTake,
      );

      result.fold(
        (left) => detailsErrorMsg = left.message,
        (right) {
          detailsTotalCount = right.data!.totalCount;
          walletDetails = right.data!.result;
          detailsEnableLoadMoreData =
              detailsTotalCount != walletDetails!.length;
          detailsSkip += detailsTake;
        },
      );

      detailsLoading = false;
    } else {
      if (detailsTotalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await marketWalletRepo.getWalletDetails(
        skip: detailsSkip,
        take: detailsTake,
      );

      result.fold(
        (left) => detailsErrorMsg = left.message,
        (right) {
          walletDetails!.addAll(right.data!.result!);
          detailsEnableLoadMoreData =
              detailsTotalCount != walletDetails!.length;
          detailsSkip += detailsTake;
        },
      );

      prgDialog.hide();
    }

    notifyListeners();
  }

  bool wasFetchWithDrawalRequestsCalled = false;
  bool withdrawalLoading = true;
  String? withdrawalErrorMsg;

  int withdrawalSkip = 0;
  int withdrawalTake = 10;
  int? withdrawalTotalCount;
  bool? withdrawalEnableLoadMoreData;

  List<WithdrawalRequest>? withdrawalRequests;

  Future<void> fetchWithDrawalRequests(BuildContext context) async {
    if (!wasFetchWithDrawalRequestsCalled) {
      wasFetchWithDrawalRequestsCalled = true;
      notifyListeners();
    }

    if (withdrawalTotalCount == null) {
      var result = await marketWalletRepo.getWithdrawalRequests(
        skip: withdrawalSkip,
        take: withdrawalTake,
      );

      result.fold(
        (left) => withdrawalErrorMsg = left.message,
        (right) {
          withdrawalTotalCount = right.data!.totalCount;
          withdrawalRequests = right.data!.result;
          withdrawalEnableLoadMoreData =
              withdrawalTotalCount != withdrawalRequests!.length;
          withdrawalSkip += withdrawalTake;
        },
      );

      withdrawalLoading = false;
    } else {
      if (withdrawalTotalCount == 0) return;

      var prgDialog = AppProgressDialog(context).instance;
      prgDialog.show();

      var result = await marketWalletRepo.getWithdrawalRequests(
        skip: withdrawalSkip,
        take: withdrawalTake,
      );

      result.fold(
        (left) => withdrawalErrorMsg = left.message,
        (right) {
          withdrawalRequests!.addAll(right.data!.result!);
          withdrawalEnableLoadMoreData =
              withdrawalTotalCount != withdrawalRequests!.length;
          withdrawalSkip += withdrawalTake;
        },
      );

      prgDialog.hide();
    }

    notifyListeners();
  }

  void refresh(BuildContext context) async {
    // clear fetch balance parameters
    wasFetchBalanceCalled = false;
    walletLoading = true;
    walletErrorMsg = null;
    walletResult = null;
    fetchBalance();

    // clear fetch details parameters
    wasFetchDetailsCalled = false;
    detailsLoading = true;
    detailsErrorMsg = null;
    detailsSkip = 0;
    detailsTake = 10;
    detailsTotalCount = null;
    detailsEnableLoadMoreData = null;
    walletDetails = null;
    fetchDetails(context);

    // clear fetch withdrawal parameters
    wasFetchWithDrawalRequestsCalled = false;
    withdrawalLoading = true;
    withdrawalErrorMsg = null;
    withdrawalSkip = 0;
    withdrawalTake = 10;
    withdrawalTotalCount = null;
    withdrawalEnableLoadMoreData = null;
    withdrawalRequests = null;
    fetchWithDrawalRequests(context);
  }
}
